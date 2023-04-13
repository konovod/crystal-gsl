module GSL
  # This enum represents algorithm of [Numerical Differentiation](https://www.gnu.org/software/gsl/doc/html/diff.html)
  enum Diff::Direction
    # Function will be evaluated at points `x-step`, `x-step/2`, `x+step/2` and `x+step`
    # This is default option
    Central
    # Function will be evaluated at points `x+step/4`, `x+step/2`, `x+3*step/4` and `x+step`
    # It is useful when function is not defined at points <= x
    Forward
    # Equivalent to `Forward` but with negative `step`
    Backward
  end

  # This function implements [Numerical Differentiation](https://www.gnu.org/software/gsl/doc/html/diff.html)
  #
  # This is a variant of method where function is passed as pointer
  #
  # Usage example:
  # ```
  # f = ->(x : Float64) { Math.log(x) }
  # result, eps = GSL.diff(f, 4.0)
  # result.should be_close 0.25, 1e-9
  # ```
  #
  # Parameters:
  #  - `function` - pointer to function
  #  - `x` - point where differential is calculated
  #  - `step` - step of algorithm. Function values will be evaluated in a range `(x-step .. x+step)`.
  #  - `dir` - algorithm. See `Diff::Direction` and GSL docs for details
  def self.diff(function : GSL::Function, x : Float64, step : Float64 = 0.01, dir : Diff::Direction = Diff::Direction::Central)
    f = wrap_function(function)
    result = uninitialized Float64
    abserr = uninitialized Float64
    case dir
    in .central?
      code = LibGSL.gsl_deriv_central(pointerof(f), x, step, pointerof(result), pointerof(abserr))
      check_return_code(LibGSL::Code.new(code), "gsl_deriv_central")
    in .forward?
      code = LibGSL.gsl_deriv_forward(pointerof(f), x, step, pointerof(result), pointerof(abserr))
      check_return_code(LibGSL::Code.new(code), "gsl_deriv_forward")
    in .backward?
      code = LibGSL.gsl_deriv_backward(pointerof(f), x, step, pointerof(result), pointerof(abserr))
      check_return_code(LibGSL::Code.new(code), "gsl_deriv_backward")
    end
    return result, abserr
  end

  # This function implements [Numerical Differentiation](https://www.gnu.org/software/gsl/doc/html/diff.html)
  #
  # This is a variant of method where function is passed as a block
  #
  # Usage example:
  # ```
  # result, eps = GSL.diff(0.25) { |x| Math.log(x) }
  # result.should be_close 4.0, 1e-9
  # ```
  #
  # Parameters:
  #  - `function` - pointer to function
  #  - `x` - point where differential is calculated
  #  - `step` - step of algorithm. Function values will be evaluated in a range `(x-step .. x+step)`.
  #  - `dir` - algorithm. See `Diff::Direction` and GSL docs for details
  def self.diff(x : Float64, step : Float64 = 0.01, dir : Diff::Direction = Diff::Direction::Central, &f : GSL::Function)
    diff(f, x, step, dir)
  end
end
