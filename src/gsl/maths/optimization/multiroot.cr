require "../../base/*"

# This module implements [Multidimensional Root-Finding](https://www.gnu.org/software/gsl/doc/html/multiroots.html)
#
# Usage examples:
# ```
# a = 1.0
# b = 10.0
# result, root_value = GSL::MultiRoot.find_root(initial: GSL::Vector.new([-10.0, -5.0]), eps_f: 1e-7, max_iter: 1000) do |x, y|
#   y[0] = a * (1 - x[0])
#   y[1] = b * (x[1] - x[0] * x[0])
# end
# result.should eq GSL::Result::Success
# root_value.should eq GSL::Vector.new([1.0, 1.0])
# ```
#
# ```
# a = 1.0
# b = 10.0
# result, root_value = GSL::MultiRoot.find_root_fdf(initial: GSL::Vector.new([-10.0, -5.0]), eps_f: 1e-7, max_iter: 1000) do |x, y, j|
#   if y
#     y[0] = a * (1 - x[0])
#     y[1] = b * (x[1] - x[0] * x[0])
#   end
#   if j
#     j[0, 0] = -a
#     j[0, 1] = 0
#     j[1, 0] = -2 * b * x[0]
#     j[1, 1] = b
#   end
# end
# result.should eq GSL::Result::Success
# root_value.should eq GSL::Vector.new([1.0, 1.0])
# ```
#
module GSL::MultiRoot
  enum AlgorithmF
    # This is a version of the Hybrid algorithm which replaces calls to the Jacobian function by its finite difference approximation.
    HybridScaled
    # This is a finite difference version of the Hybrid algorithm without internal scaling.
    Hybrid
    # The discrete Newton algorithm is the simplest method of solving a multidimensional system.  The algorithm may become unstable if the finite differences are not a good approximation to the true derivatives.
    DiscreteNewton
    # The Broyden algorithm is a version of the discrete Newton algorithm which attempts to avoids the expensive update of the Jacobian matrix on each iteration. This algorithm is included only for demonstration purposes, and is not recommended for serious use.
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
    # This is a modified version of Powell’s Hybrid method as implemented in the HYBRJ algorithm in MINPACK.
    HybridScaled
    # This algorithm is an unscaled version of HYBRIDSJ. This can be useful if the generalized region estimated by HYBRIDSJ is inappropriate.
    Hybrid
    # Newton’s Method is the standard root-polishing algorithm.
    Newton
    # This is a modified version of Newton’s method which attempts to improve global convergence by requiring every step to reduce the Euclidean norm of the residual
    GNewton

    def to_unsafe
      case self
      in .hybrid_scaled?
        LibGSL.gsl_multiroot_fdfsolver_hybridsj
      in .hybrid?
        LibGSL.gsl_multiroot_fdfsolver_hybridj
      in .newton?
        LibGSL.gsl_multiroot_fdfsolver_newton
      in .g_newton?
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
  def self.find_root(f : GSL::MultiRootFunction, initial : GSL::Vector, eps_x : Float64 = 1e-6, eps_f : Float64 = 1e-9, *,
                     algorithm : GSL::MultiRoot::AlgorithmF = GSL::MultiRoot::AlgorithmF::HybridScaled,
                     max_iter = 10000)
    n = initial.size
    raw = LibGSL.gsl_multiroot_fsolver_alloc(algorithm.to_unsafe, n)
    begin
      function = GSL.wrap_function(f, n)
      LibGSL.gsl_multiroot_fsolver_set(raw, pointerof(function), initial)
      max_iter.times do |i|
        unless LibGSL::Code.new(LibGSL.gsl_multiroot_fsolver_iterate(raw)).gsl_success?
          return GSL::Result::NoConvergence, GSL::Vector.new(raw.value.x)
        end
        dx = GSL::Vector.new(raw.value.dx)
        f_value = GSL::Vector.new(raw.value.f)
        dx_passed = dx.all? { |v| v.abs <= eps_x }
        f_passed = f_value.all? { |v| v.abs <= eps_f }
        if dx_passed || f_passed
          return GSL::Result::Success, GSL::Vector.new(raw.value.x)
        end
      end
      return GSL::Result::IterationLimit, GSL::Vector.new(raw.value.x)
    ensure
      LibGSL.gsl_multiroot_fsolver_free(raw)
    end
  end

  def self.find_root(initial : GSL::Vector, eps_x : Float64 = 1e-6, eps_f : Float64 = 1e-9, *,
                     algorithm : GSL::MultiRoot::AlgorithmF = GSL::MultiRoot::AlgorithmF::HybridScaled,
                     max_iter = 10000, &f : GSL::MultiRootFunction)
    find_root(f, initial, eps_x, eps_f, algorithm: algorithm, max_iter: max_iter)
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
  def self.find_root_fdf(f : GSL::MultiRootFunctionFDF, initial : GSL::Vector, eps_x : Float64 = 1e-6, eps_f : Float64 = 1e-9, *,
                         algorithm : GSL::MultiRoot::AlgorithmFDF = GSL::MultiRoot::AlgorithmF::HybridJScaled,
                         max_iter = 10000)
    n = initial.size
    raw = LibGSL.gsl_multiroot_fdfsolver_alloc(algorithm.to_unsafe, n)
    begin
      function = GSL.wrap_function(f, n)
      LibGSL.gsl_multiroot_fdfsolver_set(raw, pointerof(function), initial)
      max_iter.times do
        unless LibGSL::Code.new(LibGSL.gsl_multiroot_fdfsolver_iterate(raw)).gsl_success?
          return GSL::Result::NoConvergence, GSL::Vector.new(raw.value.x)
        end
        dx = GSL::Vector.new(raw.value.dx)
        f_value = GSL::Vector.new(raw.value.f)
        dx_passed = dx.all? { |v| v.abs <= eps_x }
        f_passed = f_value.all? { |v| v.abs <= eps_f }
        if dx_passed || f_passed
          return GSL::Result::Success, GSL::Vector.new(raw.value.x)
        end
      end
      return GSL::Result::IterationLimit, GSL::Vector.new(raw.value.x)
    ensure
      LibGSL.gsl_multiroot_fdfsolver_free(raw)
    end
  end

  def self.find_root_fdf(initial : GSL::Vector, eps_x : Float64 = 1e-6, eps_f : Float64 = 1e-9, *,
                         algorithm : GSL::MultiRoot::AlgorithmFDF = GSL::MultiRoot::AlgorithmFDF::HybridScaled,
                         max_iter = 10000, &f : GSL::MultiRootFunctionFDF)
    find_root_fdf(f, initial, eps_x, eps_f, algorithm: algorithm, max_iter: max_iter)
  end
end
