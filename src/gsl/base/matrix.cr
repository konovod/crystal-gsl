require "./object"

module GSL
  abstract class Matrix < GSL::Object
    def nrows : Int32
      Int32.new @pointer.value.size1
    end

    def ncols : Int32
      Int32.new @pointer.value.size2
    end

    def shape
      Tuple.new(nrows, ncols)
    end

    def [](row : Symbol | Int32, column : Symbol | Int32) : Vector
      if row == :all
        raise "one of indices should be an integer" unless column.is_a? Int32
        return self.column(column)
      elsif column == :all
        raise "one of indices should be an integer" unless row.is_a? Int32
        return self.row(row)
      else
        raise "incorrect overload called"
      end
    end

    abstract def row(r : Int32) : Vector
    abstract def column(c : Int32) : Vector
    abstract def get(row, column) : Float64
    abstract def set(row, column, x)
    abstract def set_zero
    abstract def clone : self

    def copy
      clone
    end

    abstract def [](row : Int32, column : Int32) : Float64

    def inspect
      self.map_rows { |x| x.inspect }.join("\n")
    end

    abstract def like : Matrix
    abstract def transpose : self

    # alias to transpose
    def t
      self.transpose
    end

    # returns maximum norm of matrix
    def abs
      minmax.map(&.abs).max
    end
  end

  class DenseMatrix < Matrix
    def initialize(nrows : Int32, ncols : Int32)
      @pointer = LibGSL.gsl_matrix_calloc(nrows, ncols)
    end

    def ==(m : GSL::DenseMatrix)
      LibGSL.gsl_matrix_equal(self, m) == 1 ? true : false
    end

    def [](row : Int32, column : Int32) : Float64
      return LibGSL.gsl_matrix_get(self, row.to_i, column.to_i)
    end

    def set_row(r : Int32, v : Vector) : Int32
      LibGSL.gsl_matrix_set_row(self, r.to_i, v.pointer)
    end

    def row(r : Int32) : Vector
      result = Vector.new ncols
      LibGSL.gsl_matrix_get_row(result, self, r.to_i)
      return result
    end

    def set_col(c : Int32, v : Vector) : Int32
      LibGSL.gsl_matrix_set_col(self, c, v)
    end

    def column(c : Int32) : Vector
      result = Vector.new nrows
      LibGSL.gsl_matrix_get_col(result, self, c)
      return result
    end

    def []=(row : Symbol | Int32, column : Symbol | Int32, x : Int32 | Float64)
      if row == :all
        (0...nrows).each { |n| LibGSL.gsl_matrix_set(self, n, column.to_i, x) }
        self[:all, column]
      elsif column == :all
        (0...ncols).each { |n| LibGSL.gsl_matrix_set(self, row.to_i, n, x) }
        self[row, :all]
      else
        LibGSL.gsl_matrix_set(self, row.to_i, column.to_i, x.to_f)
        self[row, column]
      end
    end

    def []=(row : Symbol | Int32, column : Symbol | Int32, x : Vector)
      if row == :all
        (0...nrows).each { |n| LibGSL.gsl_matrix_set(self, n, column.to_i, x[n]) }
        self[:all, column]
      elsif column == :all
        (0...ncols).each { |n| LibGSL.gsl_matrix_set(self, row.to_i, n, x[n]) }
        self[row, :all]
      end
    end

    def set(row, column, x)
      return LibGSL.gsl_matrix_set(self, row, column, x)
    end

    def get(row, column) : Float64
      return LibGSL.gsl_matrix_get(self, row, column)
    end

    def *(v : Vector) : Vector
      result = Vector.new self.nrows
      LibGSL.gsl_blas_dgemv(LibGSL::CBLAS_TRANSPOSE_t::CblasNoTrans, 1.0, self, v, 1.0, result)
      return result
    end

    def like : DenseMatrix
      return DenseMatrix.new nrows, ncols
    end

    def clone : GSL::DenseMatrix
      result = DenseMatrix.new nrows, ncols
      LibGSL.gsl_matrix_memcpy(result, self)
      return result
    end

    def self.eye(size : Int32) : DenseMatrix
      matrix = DenseMatrix.new size, size
      (0...size).each do |i|
        matrix[i, i] = 1.0
      end
      return matrix
    end

    def lib_free
      LibGSL.gsl_matrix_free(@pointer)
    end

    def set_all(n : Float64 | Int32)
      LibGSL.gsl_matrix_set_all(self, n.to_f)
      self
    end

    def set_zero
      LibGSL.gsl_matrix_set_zero(self)
      self
    end

    def set_identity
      LibGSL.gsl_matrix_set_identity(self)
      self
    end

    def max
      LibGSL.gsl_matrix_max(self)
    end

    def min
      LibGSL.gsl_matrix_min(self)
    end

    def minmax
      LibGSL.gsl_matrix_minmax(self, out min, out max)
      return min, max
    end

    def max_index
      LibGSL.gsl_matrix_max_index(self, out row, out column)
      return row, column
    end

    def min_index
      LibGSL.gsl_matrix_min_index(self, out row, out column)
      return row, column
    end

    def empty?
      LibGSL.gsl_matrix_isnull(self) == 1 ? true : false
    end

    def pos?
      LibGSL.gsl_matrix_ispos(self) == 1 ? true : false
    end

    def neg?
      LibGSL.gsl_matrix_isneg(self) == 1 ? true : false
    end

    def has_neg?
      LibGSL.gsl_matrix_isnonneg(self) == 1 ? false : true
    end

    def head
      self.nrows >= 5 ? puts (0...5).map { |x| self[x, :all].inspect }.join("\n") : puts self.inspect
    end

    def tail
      self.nrows >= 5 ? puts ((self.nrows - 5).to_i...self.nrows.to_i).map { |x| self[x, :all].inspect }.join("\n") : puts self.inspect
    end

    def norm1
      LibGSL.gsl_matrix_norm1(self)
    end
  end
end
