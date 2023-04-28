module GSL
  class SparseMatrix < Matrix
    def *(v : Vector)
      raise ArgumentError.new("dimensions do not match - #{ncols} != #{v.size}") unless ncols == v.size
      result = Vector.new(nrows)
      LibGSL.gsl_spblas_dgemv(LibGSL::CBLAS_TRANSPOSE_t::CblasNoTrans, 1.0, self, v, 1.0, result)
      result
    end

    def *(m : SparseMatrix)
      raise ArgumentError.new("Format of first matrix must be CSC") unless type.csc?
      raise ArgumentError.new("Format of second matrix must be CSC") unless m.type.csc?
      raise ArgumentError.new("dimensions do not match - #{ncols} != #{m.nrows}") unless ncols == m.nrows
      result = SparseMatrix.new(nrows, m.ncols, type)
      LibGSL.gsl_spblas_dgemm(1.0, self, m, result)
      result
    end

    def self.solve(a : SparseMatrix, b : Vector, *, guess : Vector? = nil, eps = 1e-6, max_iterations = 10, subspace_size = 0)
      raise ArgumentError.new("Matrix must be square - #{a.shape}") unless a.ncols == a.nrows
      raise ArgumentError.new("size of b do not match a dimensions - #{b.size} != #{a.ncols}") unless a.ncols == b.size
      raise ArgumentError.new("size of guess do not match a dimensions - #{guess.size} != #{a.ncols}") if guess && a.ncols != guess.size
      workspace = LibGSL.gsl_splinalg_itersolve_alloc(LibGSL.gsl_splinalg_itersolve_gmres, a.ncols, subspace_size)
      guess = Vector.new(a.ncols) unless guess
      begin
        max_iterations.times do
          status = LibGSL::Code.new(LibGSL.gsl_splinalg_itersolve_iterate(a, b, eps, guess, workspace))
          return guess if status.gsl_success?
        end
        norm = LibGSL.gsl_splinalg_itersolve_normr(workspace)
        raise Exception.new("gsl_splinalg_itersolve_iterate didn't converge in #{max_iterations} iterations, residual is #{norm}")
      ensure
        LibGSL.gsl_splinalg_itersolve_free(workspace)
      end
    end
  end
end
