require "../../base/*"

# This module implements [Multidimensional Minimization](https://www.gnu.org/software/gsl/doc/html/multimin.html)
#
# Usage examples:
# ```
# center = {1.0, 2.0}
# scale = {10.0, 20.0}
# height = 30.0
#
# result, min_x, min_f = GSL::MultiMin.find_min(initial: GSL::Vector.new([5.0, 7.0]), initial_step: 1.0, eps_abs: 1e-2, max_iter: 100) do |x|
#   scale[0]*Math.sqr(x[0] - center[0]) + scale[1]*Math.sqr(x[1] - center[1]) + height
# end
#
# result.should eq GSL::Result::Success
# min_x.should eq GSL::Vector.new([1.0, 2.0])
# min_f.should eq 30.0
# ```
# ```
# center = {1.0, 2.0}
# scale = {10.0, 20.0}
# height = 30.0
#
# result, min_x, min_f = GSL::MultiMin.find_min(initial: GSL::Vector.new([5.0, 7.0]), initial_step: 1.0, eps_abs: 1e-2, max_iter: 100) do |x, y, dy|
#   if y
#     y.value = scale[0]*Math.sqr(x[0] - center[0]) + scale[1]*Math.sqr(x[1] - center[1]) + height
#   end
#   if dy
#     dy[0] = 2.0*scale[0]*(x[0] - center[0])
#     dy[1] = 2.0*scale[1]*(x[1] - center[1])
#   end
# end
#
# result.should eq GSL::Result::Success
# min_x.should eq GSL::Vector.new([1.0, 2.0])
# min_f.should eq 30.0
# ```
#
module GSL::MultiMin
  enum AlgorithmF
    # This method use the Simplex algorithm of Nelder and Mead.
    NMSimplex
    # This method the same underlying algorithm, but the simplex updates are computed more efficiently for high-dimensional problems.
    NMSimplex2
    # This method is a variant of NMSimplex2 which initialises the simplex around the starting point x using a randomly-oriented set of basis vectors instead of the fixed coordinate axes
    NMSimplex2Rand

    def to_unsafe
      case self
      in .nm_simplex?
        LibGSL.gsl_multimin_fminimizer_nmsimplex
      in .nm_simplex2?
        LibGSL.gsl_multimin_fminimizer_nmsimplex2
      in .nm_simplex2_rand?
        LibGSL.gsl_multimin_fminimizer_nmsimplex2rand
      end
    end

    def to_s
      LibGSL.gsl_multimin_fminimizer_name(to_unsafe)
    end
  end

  enum AlgorithmFDF
    # This is the Fletcher-Reeves conjugate gradient algorithm.
    ConjugateFR
    # This is the Polak-Ribiere conjugate gradient algorithm.
    ConjugatePR
    # This method use the vector Broyden-Fletcher-Goldfarb-Shanno (BFGS) algorithm.
    BFGS
    # This method is the most efficient version available
    BFGS2
    # The steepest descent method is inefficient and is included only for demonstration purposes.
    SteepestDescent

    def to_unsafe
      case self
      in .conjugate_fr?
        LibGSL.gsl_multimin_fdfminimizer_conjugate_fr
      in .conjugate_pr?
        LibGSL.gsl_multimin_fdfminimizer_conjugate_pr
      in .bfgs?
        LibGSL.gsl_multimin_fdfminimizer_vector_bfgs
      in .bfgs2?
        LibGSL.gsl_multimin_fdfminimizer_vector_bfgs2
      in .steepest_descent?
        LibGSL.gsl_multimin_fdfminimizer_steepest_descent
      end
    end

    def to_s
      LibGSL.gsl_multimin_fdfminimizer_name(to_unsafe)
    end
  end

  # High-level interface to minimizer.
  #
  # - `f` - function to minimize
  # - `initial` - initial guess
  # - `initial_step` - initial step
  # - `eps_abs` - tolerance by x. Iterations terminates when characteristic size of algorithm is <= eps_abs
  # - `algorithm` - root finding algorithm to be used
  # - `max_iter` - maximum number of iterations
  #
  # returns `{result, x_min, f_min}`
  #  - `result` (type `GSL::Result`) represents result of minimization
  #  - `x_min` - value of x on last iteration
  #  - `f_min` - value of f on last iteration
  def self.find_min(f : GSL::MultiMinFunction, initial : GSL::Vector, initial_step : GSL::Vector | Float64 = 1.0, eps_abs : Float64 = 1e-6, *,
                    algorithm : GSL::MultiMin::AlgorithmF = GSL::MultiMin::AlgorithmF::NMSimplex2,
                    max_iter = 10000)
    n = initial.size
    if initial_step.is_a? Float64
      v = initial_step
      initial_step = Vector.new(n)
      initial_step.to_slice.fill(v)
    else
      raise ArgumentError.new("initial_step.size differs from initial.size") if initial.size != initial_step.size
    end
    raw = LibGSL.gsl_multimin_fminimizer_alloc(algorithm.to_unsafe, n)
    begin
      function = GSL.wrap_function(f, n)
      LibGSL.gsl_multimin_fminimizer_set(raw, pointerof(function), initial, initial_step)
      max_iter.times do |i|
        unless LibGSL::Code.new(LibGSL.gsl_multimin_fminimizer_iterate(raw)).gsl_success?
          return GSL::Result::NoConvergence, GSL::Vector.new(LibGSL.gsl_multimin_fminimizer_x(raw)).clone, LibGSL.gsl_multimin_fminimizer_minimum(raw)
        end
        if LibGSL.gsl_multimin_fminimizer_size(raw).abs <= eps_abs
          return GSL::Result::Success, GSL::Vector.new(LibGSL.gsl_multimin_fminimizer_x(raw)).clone, LibGSL.gsl_multimin_fminimizer_minimum(raw)
        end
      end
      return GSL::Result::IterationLimit, GSL::Vector.new(LibGSL.gsl_multimin_fminimizer_x(raw)).clone, LibGSL.gsl_multimin_fminimizer_minimum(raw)
    ensure
      LibGSL.gsl_multimin_fminimizer_free(raw)
    end
  end

  def self.find_min(initial : GSL::Vector, initial_step : GSL::Vector | Float64 = 1.0, eps_abs : Float64 = 1e-6, *,
                    algorithm : GSL::MultiMin::AlgorithmF = GSL::MultiMin::AlgorithmF::NMSimplex2,
                    max_iter = 10000, &f : GSL::MultiMinFunction)
    find_min(f, initial, initial_step, eps_abs, algorithm: algorithm, max_iter: max_iter)
  end

  # High-level interface to minimizer.
  #
  # - `f` - function to minimize
  # - `initial` - initial guess
  # - `initial_step` - initial step
  # - `eps_abs` - tolerance by x. Iterations terminates when norm of gradient is <= eps_abs
  # - `algorithm` - root finding algorithm to be used
  # - `max_iter` - maximum number of iterations
  # - `line_tol` - the accuracy of the line minimization (internal parameter)
  # returns `{result, x_min, f_min}`
  #  - `result` (type `GSL::Result`) represents result of minimization
  #  - `x_min` - value of x on last iteration
  #  - `f_min` - value of f on last iteration
  def self.find_min_fdf(f : GSL::MultiMinFunctionFDF, initial : GSL::Vector, initial_step : Float64 = 0.01, eps_abs : Float64 = 1e-6, *,
                        line_tol = 0.1, algorithm : GSL::MultiMin::AlgorithmFDF = GSL::MultiMin::AlgorithmFDF::BFGS2,
                        max_iter = 10000)
    n = initial.size
    raw = LibGSL.gsl_multimin_fdfminimizer_alloc(algorithm.to_unsafe, n)
    begin
      function = GSL.wrap_function(f, n)
      LibGSL.gsl_multimin_fdfminimizer_set(raw, pointerof(function), initial, initial_step, line_tol)
      max_iter.times do |i|
        unless LibGSL::Code.new(LibGSL.gsl_multimin_fdfminimizer_iterate(raw)).gsl_success?
          return GSL::Result::NoConvergence, GSL::Vector.new(LibGSL.gsl_multimin_fdfminimizer_x(raw)).clone, LibGSL.gsl_multimin_fdfminimizer_minimum(raw)
        end
        if LibGSL::Code.new(LibGSL.gsl_multimin_test_gradient(LibGSL.gsl_multimin_fdfminimizer_gradient(raw), eps_abs)).gsl_success?
          return GSL::Result::Success, GSL::Vector.new(LibGSL.gsl_multimin_fdfminimizer_x(raw)).clone, LibGSL.gsl_multimin_fdfminimizer_minimum(raw)
        end
      end
      return GSL::Result::IterationLimit, GSL::Vector.new(LibGSL.gsl_multimin_fdfminimizer_x(raw)).clone, LibGSL.gsl_multimin_fdfminimizer_minimum(raw)
    ensure
      LibGSL.gsl_multimin_fdfminimizer_free(raw)
    end
  end

  def self.find_min_fdf(initial : GSL::Vector, initial_step : GSL::Vector | Float64 = 1.0, eps_abs : Float64 = 1e-6, *,
                        algorithm : GSL::MultiMin::AlgorithmFDF = GSL::MultiMin::AlgorithmFDF::BFGS2,
                        max_iter = 10000, &f : GSL::MultiMinFunctionFDF)
    find_min_fdf(f, initial, initial_step, eps_abs, algorithm: algorithm, max_iter: max_iter)
  end
end
