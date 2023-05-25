require "../../base/*"
require "./find_bracket"

# This module implements [One Dimensional Root-Finding](https://www.gnu.org/software/gsl/doc/html/roots.html)
#
# Usage examples:
# ```
# # find root inside a range.
# xm = GSL::Roots.find_root(0, 3) do |x|
#   Math.cos(x) - 0.5
# end
# xm.should be_close(Math::PI / 3, 1e-9)
# ```
#
# ```
# # polish root from initial guess. This method requires function and its derivative
# root = GSL::Roots.polish_root(10, x_possible: (0.0..)) do |x|
#   f = x*x*x - 125
#   df = 3*x*x
#   {f, df}
# end
# root.should be_close 5, 1e-9
# ```
#
module GSL::Roots
  enum TypeBracketing
    # The bisection algorithm is the simplest method of bracketing the roots of a function. It is the slowest algorithm provided by the library, with linear convergence.
    Bisection
    # The false position algorithm is a method of finding roots based on linear interpolation. Its convergence is linear, but it is usually faster than bisection.
    FalsePosition
    # The Brent-Dekker method combines an interpolation strategy with the bisection algorithm. This produces a fast algorithm which is still robust.
    BrentDekker

    def to_unsafe
      case self
      in .bisection?
        LibGSL.gsl_root_fsolver_bisection
      in .false_position?
        LibGSL.gsl_root_fsolver_falsepos
      in .brent_dekker?
        LibGSL.gsl_root_fsolver_brent
      end
    end

    def to_s
      LibGSL.gsl_root_fsolver_name(to_unsafe)
    end
  end

  enum TypePolishing
    # Newton’s Method is the standard root-polishing algorithm.
    Newton
    # The secant method is a simplified version of Newton’s method which does not require the computation of the derivative on every step.
    Secant
    # The Steffenson Method provides the fastest convergence of all the routines. It combines the basic Newton algorithm with an Aitken “delta-squared” acceleration.
    Steffenson

    def to_unsafe
      case self
      in .newton?
        LibGSL.gsl_root_fdfsolver_newton
      in .secant?
        LibGSL.gsl_root_fdfsolver_secant
      in .steffenson?
        LibGSL.gsl_root_fdfsolver_steffenson
      end
    end

    def to_s
      LibGSL.gsl_root_fdfsolver_name(to_unsafe)
    end
  end

  # High-level interface to root finder. Finds root of function f between `x_lower` and `x_upper`,
  #
  # due to nature of used algorithms, signs of function in `x_lower` and `x_upper` must differ
  #
  # - `algorithm` - root bracketing algorithm to be used
  #
  # returns `{result, x_root}`
  #  - `result` (type `GSL::Result`) represents result of minimization
  #  - `x_root` - value of root on last iteration
  def self.find_root(f : GSL::Function, x_lower : Float64, x_upper : Float64, eps : Float64 = 1e-9, *,
                     algorithm : GSL::Roots::TypeBracketing = GSL::Roots::TypeBracketing::BrentDekker,
                     max_iter = 10000)
    raw = LibGSL.gsl_root_fsolver_alloc(algorithm.to_unsafe)
    begin
      function = GSL.wrap_function(f)
      LibGSL.gsl_root_fsolver_set(raw, pointerof(function), x_lower, x_upper)
      max_iter.times do
        LibGSL.gsl_root_fsolver_iterate(raw)
        if (raw.value.x_upper - raw.value.x_lower) < eps
          return GSL::Result::Success, raw.value.root
        end
      end
      return GSL::Result::IterationLimit, raw.value.root
    ensure
      LibGSL.gsl_root_fsolver_free(raw)
    end
  end

  def self.find_root(x_lower : Float64, x_upper : Float64, eps : Float64 = 1e-9, *,
                     algorithm : GSL::Roots::TypeBracketing = GSL::Roots::TypeBracketing::BrentDekker,
                     max_iter = 10000, &f : GSL::Function)
    find_root(f, x_lower, x_upper, eps, algorithm: algorithm, max_iter: max_iter)
  end

  # High-level interface to root polishing. Finds root of function f near `initial_guess`
  #
  # - `algorithm` - root bracketing algorithm to be used
  #
  # returns `{result, x_root}`
  #  - `result` (type `GSL::Result`) represents result of minimization
  #  - `x_root` - value of root on last iteration
  def self.polish_root(f : GSL::FunctionFDF, initial_guess : Float64, eps : Float64 = 1e-9, *,
                       x_possible : Range(Float64?, Float64?)? = nil,
                       algorithm : GSL::Roots::TypePolishing = GSL::Roots::TypePolishing::Steffenson,
                       max_iter = 10000)
    raw = LibGSL.gsl_root_fdfsolver_alloc(algorithm.to_unsafe)
    begin
      function = GSL.wrap_function(f)
      LibGSL.gsl_root_fdfsolver_set(raw, pointerof(function), initial_guess)
      x0 = initial_guess
      max_iter.times do |i|
        LibGSL.gsl_root_fdfsolver_iterate(raw)
        x1 = raw.value.root
        if x_possible
          return Result::NoConvergence, raw.value.root unless x_possible.includes? x1
        end
        # pp! i, x0, x1, eps, (x0 - x1).abs
        if (x0 - x1).abs < eps
          return Result::Success, x1
        end
        x0 = x1
      end
      return Result::IterationLimit, raw.value.root
    ensure
      LibGSL.gsl_root_fdfsolver_free(raw)
    end
  end

  def self.polish_root(initial_guess : Float64, eps : Float64 = 1e-9, *,
                       x_possible : Range(Float64?, Float64?)? = nil,
                       algorithm : GSL::Roots::TypePolishing = GSL::Roots::TypePolishing::Steffenson,
                       max_iter = 10000, &f : GSL::FunctionFDF)
    polish_root(f, initial_guess, eps, x_possible: x_possible, algorithm: algorithm, max_iter: max_iter)
  end
end
