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
      in .bfgs?
        LibGSL.gsl_multimin_fdfminimizer_vector_bfgs2
      in .steepest_descent?
        LibGSL.gsl_multimin_fdfminimizer_steepest_descent
      end
    end

    def to_s
      LibGSL.gsl_multimin_fdfminimizer_name(to_unsafe)
    end
  end
end
