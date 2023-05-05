module Statistics
  abstract class DiscreteDistribution
    abstract def sample(rng : Random? = nil) : Int

    def sample(n : Int32, rng : Random? = nil)
      return Array.new (n) { sample(rng) }
    end

    def self.sample(n : Int32, *args)
      return Array.new (n) { self.sample(*args) }
    end
  end

  abstract class ContinuousDistribution
    abstract def sample(rng : Random? = nil) : Float64

    def sample(n : Int32, rng : Random? = nil) : Array(Float64)
      return Array.new (n) { sample(rng) }
    end

    def self.sample(n : Int32, *args) : Array(Float64)
      return Array.new (n) { self.sample(*args) }
    end
  end

  private macro distribution_named(name, continuous, gsl_name, *params)
    class {{name.id}} < {{continuous ? ContinuousDistribution : DiscreteDistribution}} 
      {% for param in params %}
          property {{param}}
      {% end %} 

      def initialize({{
                       *params.map do |field|
                         "@#{field.id}".id
                       end
                     }})
      end


      def pdf(x : {{continuous ? Float64 : Int}} ) : Float64
        return LibGSL.gsl_ran_{{gsl_name.id}}_pdf(x, {{ *params.map(&.var) }})
      end

      def cdf(x : {{continuous ? Float64 : Int}} ) : Float64
        return LibGSL.gsl_cdf_{{gsl_name.id}}_P(x, {{ *params.map(&.var) }})
      end

      {% if params.size > 0 %}
        def sample(rng : Random? = nil) : {{continuous ? Float64 : Int}} 
          return {{name.id}}.sample({{ *params.map(&.var) }}, rng)
        end

        def self.sample({{ *params }}, rng : Random? = nil) : {{continuous ? Float64 : Int}}
          if rng
            rng_value = GSL.wrap_rng(rng)
            rng = pointerof(rng_value)
          else
            rng = GSL::RNG
          end
          return LibGSL.gsl_ran_{{gsl_name.id}}(rng, {{ *params.map(&.var) }})
        end
      {% else %}
        def sample(rng : Random? = nil) : {{continuous ? Float64 : Int}} 
          return {{name.id}}.sample(rng)
        end

        def self.sample(rng : Random? = nil) : {{continuous ? Float64 : Int}}
          if rng
            rng_value = GSL.wrap_rng(rng)
            rng = pointerof(rng_value)
          else
            rng = GSL::RNG
          end
        return LibGSL.gsl_ran_{{gsl_name.id}}(rng)
        end
      {% end %}


      end
  end

  private macro distribution(name, continuous, *params)
  distribution_named({{name}}, {{continuous}}, {{name.stringify.underscore.id}}, {{*params}})
  end

  distribution(Cauchy, true, a : Float64)
  distribution(Poisson, false, mu : Float64)
  distribution(Binomial, false, p : Float64, n : UInt32)
  distribution_named(ChiSquare, true, chisq, nu : Float64)
  distribution(Exponential, true, mu : Float64)
  distribution(Gamma, true, shape : Float64, scale : Float64)
  distribution(GaussianTail, true, a : Float64, sigma : Float64)
  distribution(Laplace, true, width : Float64)
  distribution_named(Uniform, true, flat, a : Float64, b : Float64)
  distribution_named(Normal, true, gaussian, mean : Float64, std : Float64)
  distribution_named(ExponentialPower, true, exppow, scale : Float64, exponent : Float64)
  distribution(Rayleigh, true, sigma : Float64)
  distribution(RayleighTail, true, a : Float64, sigma : Float64)
  distribution(Landau, true)
  distribution(Levy, true, c : Float64, alpha : Float64)
  distribution(LevySkew, true, c : Float64, alpha : Float64, beta : Float64)
  distribution(Lognormal, true, zeta : Float64, sigma : Float64)
  distribution_named(FDist, true, fdist, nu1 : Float64, nu2 : Float64)
  distribution_named(TDist, true, tdist, nu : Float64)
  distribution(Beta, true, a : Float64, b : Float64)
  distribution(Logistic, true, a : Float64)
  distribution(Pareto, true, a : Float64, b : Float64)
  distribution(Weibull, true, a : Float64, b : Float64)
  distribution(Gumbel1, true, a : Float64, b : Float64)
  distribution(Gumbel2, true, a : Float64, b : Float64)
  distribution(Bernoulli, true, a : Float64, b : Float64)
  distribution(NegativeBinomial, false, p : Float64, n : Float64)
  distribution(Pascal, false, p : Float64, n : Int32)
  distribution(Geometric, false, p : Float64)
  distribution(HyperGeometric, false, n1 : UInt32, n2 : UInt32, t : UInt32)
  distribution(Logarithmic, false, p : Float64)

  class Gamma
    def self.sample(shape : Float64, scale : Float64, rng : Random? = nil) : Float64
      rate = 1.0 / scale
      if rng
        rng_value = GSL.wrap_rng(rng)
        rng = pointerof(rng_value)
      else
        rng = GSL::RNG
      end
      return LibGSL.gsl_ran_gamma(rng, shape, rate)
    end
  end

  class Normal
    def self.sample(mean : Float64, std : Float64, rng : Random? = nil) : Float64
      if rng
        rng_value = GSL.wrap_rng(rng)
        rng = pointerof(rng_value)
      else
        rng = GSL::RNG
      end
      return LibGSL.gsl_ran_gaussian(rng, std) + mean
    end

    def self.pdf(mean : Float64, std : Float64, rng : Random? = nil)
      return LibGSL.gsl_ran_gaussian_pdf(x - mean, std)
    end
  end

  # For *n* independent trials each of which leads to a success for exactly one of *k* categories,
  # with each category having a given fixed success probability, the multinomial distribution gives the
  # probability of any particular combination of numbers of successes for the various categories.
  class Multinomial
    # Given an array of probabilities *probs*, one per category, return the indices of the sampled categories.
    # Note that the probabilities do not need to be normalised.
    #
    # ```
    # w = Array.new(6, 1/6.0)           # probabilities of a fair die
    # Statistics::Multinomial.sample(w) # => [1, 0, 0, 1, 5, 4]
    # ```
    def self.sample(probs : Array(Float64)) : Array(Int32)
      n = probs.size

      probs = Statistics.normalise(probs)
      q = Statistics.cumulative_sum(probs)
      i = 0
      index = Array(Int32).new(n, 0)
      while i < n
        s = Random.rand
        j = 0
        while q[j] < s
          j += 1
        end
        index[i] = j
        i += 1
      end
      return index
    end
  end

  class MultivariateNormal
    def self.sample(mean : Vector, cov : Matrix)
      work = cov.copy
      n = mean.size
      result = Vector.new n

      LibGSL.gsl_linalg_cholesky_decomp(work.pointer)

      (0...n).each do |k|
        result[k] = Normal.sample(0.0, 1.0)
      end

      LibGSL.gsl_blas_dtrmv(LibGSL::CBLAS_UPLO_t::CblasLower, LibGSL::CBLAS_TRANSPOSE_t::CblasNoTrans, LibGSL::CBLAS_DIAG_t::CblasNonUnit, work.pointer, result.pointer)

      LibGSL.gsl_vector_add(result.pointer, mean.pointer)

      LibGSL.gsl_matrix_free(work.pointer)

      return result
    end
  end

  # Class representing an inverse-gamma distribution
  class InverseGamma < ContinuousDistribution
    def initialize(@shape : Float64, @scale : Float64)
    end

    def pdf(x : Float64) : Float64
      return InverseGamma.pdf(x, @shape, @scale)
    end

    def self.pdf(x : Float64, shape : Float64, scale : Float64) : Float64
      return Math.exp(InverseGamma.log_pdf(x, shape, scale))
    end

    def log_pdf(x : Float64) : Float64
      return InverseGamma.log_pdf(x, @shape, @scale)
    end

    def self.log_pdf(x : Float64, shape : Float64, scale : Float64)
      return shape * Math.log(scale) - GSL.lngamma(shape) + -(shape + 1) * Math.log(x) + -scale/x
    end

    def sample(rng : Random? = nil) : Float64
      return 1.0 / Gamma.next(@shape, @scale, rng)
    end
  end

  # A symmetric probability distribution whereby a finite number of values are
  # equally likely to be observed: every one of *n* values has equal probability *1/n*.
  class DiscreteUniform < DiscreteDistribution
    # Create a new discrete uniform object with parameters *min* and *man*
    #
    # ```
    # u = DiscreteUniform.new 0, 2
    # ```
    def initialize(@min : Int64, @max : Int64)
    end

    # Returns a random integer from *min* to *max*
    #
    # ```
    # u = DiscreteUniform.new 0, 2
    # u.sample # => 1
    # ```
    def sample(rng : Random? = nil) : Int
      DiscreteUniform.sample(@min, @max, rng)
    end

    # Returns a random integer from *min* to *max*
    #
    # ```
    # DiscreteUniform.sample(0, 2) # => 1
    # ```
    def self.sample(min : Int, max : Int, rng : Random? = nil)
      if max < min
        raise ArgumentError.new("Maximum cannot be smaller than minimum")
      end
      (rng || Random::DEFAULT).rand(min..max)
    end

    # Returns an array of random integers from *min* to *max*
    #
    # ```
    # DiscreteUniform.sample(4, 0, 2) # => [0, 2, 1, 1, 2]
    # ```
    def self.sample(n : Int, min : Int, max : Int, rng : Random? = nil)
      (0...n).map { |i| DiscreteUniform.sample min, max, rng }
    end
  end
end
