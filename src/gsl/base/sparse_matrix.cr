module GSL
  class SparseMatrix < Matrix
    getter pointer

    def initialize(@rows : Int32, @columns : Int32)
      @pointer = LibGSL.gsl_spmatrix_alloc(@rows, @columns)
    end

    def get(row, column) : Float64
      return LibGSL.gsl_spmatrix_get(@pointer, row.to_i, column.to_i)
    end

    def set(row, column, x)
      return LibGSL.gsl_spmatrix_set(@pointer, row, column, x)
    end

    def [](row : Int32, column : Int32) : Float64
      return self.get(row, column)
    end

    def []=(row : Symbol | Int32, column : Symbol | Int32, x : Int32 | Float64)
      if row == :all
        (0...@rows).each { |n| self.set(n, column.to_i, x) }
        self[:all, column]
      elsif column == :all
        (0...@columns).each { |n| self.set(row.to_i, n, x) }
        self[row, :all]
      else
        self.set(row.to_i, column.to_i, x.to_f)
        self[row, column]
      end
    end

    def ==(m : GSL::SparseMatrix)
      LibGSL.gsl_spmatrix_equal(@pointer, m.pointer) == 1 ? true : false
    end

    def column(c : Int32 | Symbol) : Vector
      result = Vector.new @rows
      (0...@rows).each { |r|
        result[r] = self.get(r, c)
      }
      return result
    end

    def row(r : Int32 | Symbol) : Vector
      result = Vector.new @columns
      (0...@columns).each { |c|
        result[c] = self.get(r, c)
      }
      return result
    end

    def set_zero
      LibGSL.gsl_spmatrix_set_zero(@pointer)
      self
    end

    def like : SparseMatrix
      return SparseMatrix.new @rows, @columns
    end

    def copy : SparseMatrix
      result = SparseMatrix.new @rows, @columns
      LibGSL.gsl_spmatrix_memcpy(result.pointer, @pointer)
      return result
    end

    def non_zero : Int32
      Int32.new(LibGSL.gsl_spmatrix_nnz(@pointer))
    end

    def finalize
      LibGSL.gsl_spmatrix_free(@pointer)
    end

    def minmax
      return [0.0, 0.0] if non_zero == 0
      LibGSL.gsl_spmatrix_minmax(@pointer, out min, out max)
      min = 0.0 if min > 0.0
      max = 0.0 if max < 0.0
      return [min, max]
    end

    def transpose : SparseMatrix
      transpose = SparseMatrix.new self.shape[1].to_i, self.shape[0].to_i
      LibGSL.gsl_spmatrix_transpose_memcpy(transpose.pointer, self.pointer)
      return transpose
    end

    def *(n : Int32 | Float64) : SparseMatrix
      temp = self.copy
      LibGSL.gsl_spmatrix_scale(temp.pointer, n.to_f)
      temp
    end
  end
end
