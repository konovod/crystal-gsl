require "../../base/*"
require "./find_bracket"

# This module implements [One Dimensional Minimization](https://www.gnu.org/software/gsl/doc/html/min.html)
#
# Usage example:
# ```
# result, xm, fm = GSL::Min.find_min(0, 6, 1e-6) do |x|
#   Math.cos(x)
# end
# result.success?.should be_true
# xm.should be_close Math::PI, 1e-6
# ```
#
module GSL::Min
  # Minimization algorithm
  enum Type
    # The golden section algorithm is the simplest method of bracketing the minimum of a function. It is the slowest algorithm provided by the library, with linear convergence.
    GoldenSection
    # The Brent minimization algorithm combines a parabolic interpolation with the golden section algorithm. This produces a fast algorithm which is still robust.
    Brent
    # This is a variant of Brent’s algorithm which uses the safeguarded step-length algorithm of Gill and Murray.
    QuadGolden

    def to_unsafe
      case self
      in .golden_section?
        LibGSL.gsl_min_fminimizer_goldensection
      in .brent?
        LibGSL.gsl_min_fminimizer_brent
      in .quad_golden?
        LibGSL.gsl_min_fminimizer_quad_golden
      end
    end

    def to_s
      String.new(LibGSL.gsl_min_fminimizer_name(to_unsafe))
    end
  end

  # High-level interface to minimizer. Finds minimum of function f between `x_lower` and `x_upper`.
  #
  # - `eps` - required absolute precision
  # - `algorithm` - minimization algorithm to be used. By default either `Brent` (if `guess` is present) or `QuadGolden` (othrwise) is used.
  # - `max_iter` - maximum number of function evaluations, used to stop iterating when solution doesn't converge
  # - `guess` - initial guess of a root value that can speed up search. If present, f(guess) < f(x_lower) and f(guess) < f(x_upper) should hold.
  #
  # returns `{result, x_min, f_min}`
  #  - `result` (type `GSL::Result`) represents result of minimization
  #  - `x_min` - value of x on last iteration
  #  - `f_min` - value of f on last iteration
  def self.find_min(f : GSL::Function, x_lower : Float64, x_upper : Float64, x_eps : Float64 = 1e-9, f_eps : Float64 = 1e-9, *,
                    algorithm : GSL::Min::Type? = nil,
                    max_iter = 10000, guess = nil) : Tuple(Result, Float64, Float64)
    algorithm = guess ? GSL::Min::Type::Brent : GSL::Min::Type::QuadGolden
    raw = LibGSL.gsl_min_fminimizer_alloc(algorithm.to_unsafe)
    begin
      function = GSL.wrap_function(f)
      if guess
        LibGSL.gsl_min_fminimizer_set(raw, pointerof(function), guess, x_lower, x_upper)
      else
        f_lower = f.call(x_lower)
        f_upper = f.call(x_upper)
        x_min = x_lower
        f_min = f_lower
        # LibGSL.gsl_min_find_bracket(pointerof(function), pointerof(x_min), pointerof(f_min), pointerof(x_lower), pointerof(f_lower), pointerof(x_upper), pointerof(f_upper), max_iter//2)
        result = GSL::Min.min_find_bracket(f, pointerof(x_min), pointerof(f_min), pointerof(x_lower), pointerof(f_lower), pointerof(x_upper), pointerof(f_upper), max_iter//2)
        LibGSL.gsl_min_fminimizer_set_with_values(raw, pointerof(function),
          x_min, f_min, x_lower, f_lower, x_upper, f_upper)
      end
      ok = false
      result = GSL::Result::IterationLimit
      max_iter.times do |i|
        LibGSL.gsl_min_fminimizer_iterate(raw)
        # pp! i, raw.value.x_lower, raw.value.x_upper - raw.value.x_lower, raw.value.f_upper, raw.value.f_upper - raw.value.f_minimum
        ok = raw.value.x_upper - raw.value.x_lower < x_eps || raw.value.f_upper - raw.value.f_minimum <= f_eps
        if ok
          result = GSL::Result::Success
          break
        end
      end
      return result, raw.value.x_minimum, raw.value.f_minimum
    ensure
      LibGSL.gsl_min_fminimizer_free(raw)
    end
  end

  def self.find_min(x_lower : Float64, x_upper : Float64, x_eps : Float64 = 1e-9, f_eps : Float64 = 1e-9, *,
                    algorithm : GSL::Min::Type? = nil,
                    max_iter = 10000, guess = nil, &f : GSL::Function) : Tuple(Result, Float64, Float64)
    find_min(f, x_lower, x_upper, x_eps, f_eps, algorithm: algorithm, max_iter: max_iter, guess: guess)
  end
end
