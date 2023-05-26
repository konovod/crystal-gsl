require "../../base/*"

# This module implements [Multidimensional Root-Finding](https://www.gnu.org/software/gsl/doc/html/multiroots.html)
#
# Usage examples:
# ```
# ```
#
# ```
# ```
#

module GSL::MultiRoot
  enum AlgorithmF
    HybridScaled
    Hybrid
    DiscreteNewton
    Broyden

    def to_unsafe
      case self
      in .hybrid_scaled?
        LibGSL.gsl_multiroot_fsolver_hybrids
      in .hybrid?
        LibGSL.gsl_multiroot_fsolver_hybrid
      in .discrete_newton?
        LibGSL.gsl_multiroot_fsolver_dnewton
      in .broyden?
        LibGSL.gsl_multiroot_fsolver_broyden
      end
    end

    def to_s
      LibGSL.gsl_multiroot_fsolver_name(to_unsafe)
    end
  end
  enum AlgorithmFDF
    HybridJScaled
    HybridJ
    Newton
    GNewton

    def to_unsafe
      case self
      in .hybrid_jscaled?
        LibGSL.gsl_multiroot_fdfsolver_hybridsj
      in .hybrid_j?
        LibGSL.gsl_multiroot_fdfsolver_hybridj
      in .newton?
        LibGSL.gsl_multiroot_fdfsolver_newton
      in .gnewton?
        LibGSL.gsl_multiroot_fdfsolver_gnewton
      end
    end

    def to_s
      LibGSL.gsl_multiroot_fdfsolver_name(to_unsafe)
    end
  end

  # High-level interface to root finder.
  #
  # - `f` - function to minimize
  # - `initial` - initial guess
  # - `eps_x` - tolerance by x. Iterations terminates when all components of dx are <= eps_x
  # - `eps_f` - tolerance by f. Iterations terminates when all components of f are <= eps_x
  # - `algorithm` - root finding algorithm to be used
  # - `max_iter` - maximum number of iterations
  #
  # returns `{result, x_root}`
  #  - `result` (type `GSL::Result`) represents result of minimization
  #  - `x_root` - value of root on last iteration
  def self.find_root(f : GSL::Function, initial : GSL::Vector, eps_x : Float64 = 1e-6, eps_f : Float64 = 1e-9, *,
                     algorithm : GSL::Roots::AlgorithmF = GSL::MultiRoot::AlgorithmF::HybridScaled,
                     max_iter = 10000)
    raw = LibGSL.gsl_multiroot_fsolver_alloc(algorithm.to_unsafe)
    begin
      function = GSL.wrap_function(f)
      LibGSL.gsl_multiroot_fsolver_set(raw, pointerof(function), x_lower, x_upper)
      max_iter.times do
        unless LibGSL::Code.new(LibGSL.gsl_multiroot_fsolver_iterate(raw)).success?
          return GSL::Result::NoConvergence, raw.value.x.value.unsafe_as(GSL::Vector)
        end
        dx = raw.value.dx.value.unsafe_as(GSL::Vector)
        f_value = raw.value.f.value.unsafe_as(GSL::Vector)
        dx_passed = dx.all? { |v| v <= eps_x }
        f_passed = f_value.all? { |v| v <= eps_f }
        if dx_passed || f_passed
          return GSL::Result::Success, raw.value.x.value.unsafe_as(GSL::Vector)
        end
      end
      return GSL::Result::IterationLimit, raw.value.x.value.unsafe_as(GSL::Vector)
    ensure
      LibGSL.gsl_multiroot_fsolver_free(raw)
    end
  end
end
