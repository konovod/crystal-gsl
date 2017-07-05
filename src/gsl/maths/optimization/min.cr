require "../../base/*"
require "./find_bracket"

private GSL_SQRT_DBL_EPSILON = 1.4901161193847656e-08

module GSL::Min
  enum Type
    GoldenSection
    Brent
    QuadGolden
  end

  class FMinimizer
    getter raw : LibGSL::MinFminimizer*

    def initialize(typ : Type)
      case typ
      when .golden_section?
        lib_type = LibGSL.gsl_min_fminimizer_goldensection
      when .brent?
        lib_type = LibGSL.gsl_min_fminimizer_brent
      when .quad_golden?
        lib_type = LibGSL.gsl_min_fminimizer_quad_golden
      else
        raise ArgumentError.new("incorrect minimizer type")
      end
      @raw = LibGSL.min_fminimizer_alloc(lib_type)
    end

    def free
      # to prevent second free (e.g. during finalize)
      return if @raw == Pointer(LibGSL::MinFminimizer).new(0)
      LibGSL.min_fminimizer_free(@raw)
      @raw = Pointer(LibGSL::MinFminimizer).new(0)
    end

    def finalize
      free
    end

    def self.use(typ : Type)
      min = self.new(typ)
      result = yield(min)
      min.free
      result
    end

    def name
      String.new(LibGSL.min_fminimizer_name(@raw))
    end

    getter function : GSL::Function?
    @wrap = LibGSL::Function.new

    def setup(x_minimum : Float64, x_lower : Float64, x_upper : Float64, &f : GSL::Function)
      @function = f
      @wrap = GSL.wrap_function(self) do |x, data|
        data.as(FMinimizer).function.not_nil!.call(x)
      end
      LibGSL.min_fminimizer_set(@raw, pointerof(@wrap),
        x_minimum, x_lower, x_upper)
    end

    def find_bracket(x_lower : Float64, x_upper : Float64, max_iter = 1000, &f : GSL::Function)
      @function = f
      @wrap = GSL.wrap_function(self) do |x, data|
        data.as(FMinimizer).function.not_nil!.call(x)
      end
      x_min = x_lower
      f_lower = f.call(x_lower)
      f_upper = f.call(x_upper)
      f_min = f_lower
      # LibGSL.min_find_bracket(pointerof(@wrap), pointerof(x_min), pointerof(f_min), pointerof(x_lower), pointerof(f_lower), pointerof(x_upper), pointerof(f_upper), max_iter/2)
      result = GSL::Min.min_find_bracket(f, pointerof(x_min), pointerof(f_min), pointerof(x_lower), pointerof(f_lower), pointerof(x_upper), pointerof(f_upper), max_iter/2)
      LibGSL.min_fminimizer_set_with_values(@raw, pointerof(@wrap),
        x_min, f_min, x_lower, f_lower, x_upper, f_upper)
    end

    def setup(x_minimum : Float64, f_minimum : Float64, x_lower : Float64, f_lower : Float64, x_upper : Float64, f_upper : Float64, &f : GSL::Function)
      @function = f
      @wrap = GSL.wrap_function(self) do |x, data|
        data.as(FMinimizer).function.not_nil!.call(x)
      end
      LibGSL.min_fminimizer_set_with_values(@raw, pointerof(@wrap),
        x_minimum, f_minimum, x_lower, f_lower, x_upper, f_upper)
    end

    delegate x_lower, x_upper, x_minimum, f_lower, f_upper, f_minimum, to: @raw.value

    def to_s(io)
      io << "x: [" << x_lower << " -- " << x_minimum << " -- " << x_upper << "]\n"
      io << "f: [" << f_lower << " -- " << f_minimum << " -- " << f_upper << "]\n"
    end

    def inspect(io)
      io << "GSL::FMinimizer "
      to_s(io)
    end

    def iterate
      LibGSL.min_fminimizer_iterate(@raw)
    end

    def test_interval(eps_abs, eps_rel = 0.0)
      LibGSL::Code.new(LibGSL.min_test_interval(x_lower, x_upper, eps_abs, eps_rel))
    end
  end

  # High-level interface to minimizer. Finds minimum of function f between x_lower and x_upper.
  # algorithm - minimization algorithm to be used
  # returns nil if number of iterations = max_iter is exceeded
  # returns {x_min, f_min} tuple if precision = eps achieved
  def self.find_min?(x_lower, x_upper, eps, *,
                     algorithm : GSL::Min::Type = GSL::Min::Type::Brent,
                     max_iter = 1000, guess = nil, &f : GSL::Function)
    FMinimizer.use(algorithm) do |minimizer|
      if guess
        minimizer.setup(guess.to_f, x_lower.to_f, x_upper.to_f, &f)
      else
        minimizer.find_bracket(x_lower.to_f, x_upper.to_f, max_iter, &f)
      end
      eps = eps.to_f
      max_iter.times do
        minimizer.iterate
        if minimizer.test_interval(eps) == LibGSL::Code::GSL_SUCCESS
          return {minimizer.x_minimum, minimizer.f_minimum}
        end
      end
      if minimizer.f_upper - minimizer.f_minimum < GSL_SQRT_DBL_EPSILON
        return {minimizer.x_minimum, minimizer.f_minimum}
      else
        return nil
      end
    end
  end

  # High-level interface to minimizer. Finds minimum of function f between x_lower and x_upper.
  # algorithm - minimization algorithm to be used
  # raises IterationsLimitExceeded if number of iterations = max_iter is exceeded
  # returns {x_min, f_min} tuple if precision = eps achieved
  def self.find_min(x_lower, x_upper, eps,
                    algorithm : GSL::Min::Type = GSL::Min::Type::Brent,
                    max_iter = 1000, guess = nil, &f : GSL::Function)
    find_min?(x_lower, x_upper, eps, algorithm: algorithm, max_iter: max_iter, guess: guess, &f) || raise IterationsLimitExceeded.new("find_min didn't converge")
  end
end
