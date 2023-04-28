module GSL
  class SparseMatrix < Matrix
    enum Type
      COO = 0 # coordinate/triplet representation
      CSC = 1 # compressed sparse column
      CSR = 2 # compressed sparse row
    end

    def type
      Type.new(pointer.value.sptype)
    end

    def initialize(nrows : Int32, ncols : Int32)
      @pointer = LibGSL.gsl_spmatrix_alloc(nrows, ncols)
    end

    def initialize(nrows : Int32, ncols : Int32, type : Type, non_zero = nrows * ncols / 10)
      @pointer = LibGSL.gsl_spmatrix_alloc_nzmax(nrows, ncols, non_zero, type)
    end

    def initialize(another : SparseMatrix, type : Type = another.type)
      if type == another.type
        @pointer = LibGSL.gsl_spmatrix_alloc_nzmax(another.nrows, another.ncols, another.non_zero, type)
        LibGSL.gsl_spmatrix_memcpy(@pointer, another)
      else
        @pointer = LibGSL.gsl_spmatrix_compress(another, type)
      end
    end

    def initialize(another : DenseMatrix, type : Type = Type::COO)
      if type.coo?
        @pointer = LibGSL.gsl_spmatrix_alloc(another.nrows, another.ncols)
        LibGSL.gsl_spmatrix_d2sp(@pointer, another)
      else
        temp = LibGSL.gsl_spmatrix_alloc(another.nrows, another.ncols)
        LibGSL.gsl_spmatrix_d2sp(temp, another)
        @pointer = LibGSL.gsl_spmatrix_compress(temp, type)
        LibGSL.gsl_spmatrix_free(temp)
      end
    end

    def get(row, column) : Float64
      return LibGSL.gsl_spmatrix_get(self, row.to_i, column.to_i)
    end

    def set(row, column, x)
      return LibGSL.gsl_spmatrix_set(self, row, column, x)
    end

    def [](row : Int32, column : Int32) : Float64
      return self.get(row, column)
    end

    def []=(row : Symbol | Int32, column : Symbol | Int32, x : Int32 | Float64)
      if row == :all
        (0...nrows).each { |n| self.set(n, column.to_i, x) }
        self[:all, column]
      elsif column == :all
        (0...ncols).each { |n| self.set(row.to_i, n, x) }
        self[row, :all]
      else
        self.set(row.to_i, column.to_i, x.to_f)
        self[row, column]
      end
    end

    def ==(m : GSL::SparseMatrix)
      LibGSL.gsl_spmatrix_equal(self, m) == 1 ? true : false
    end

    def column(c : Int32 | Symbol) : Vector
      result = Vector.new nrows
      (0...nrows).each { |r|
        result[r] = self.get(r, c)
      }
      return result
    end

    def row(r : Int32 | Symbol) : Vector
      result = Vector.new ncols
      (0...ncols).each { |c|
        result[c] = self.get(r, c)
      }
      return result
    end

    def set_zero
      LibGSL.gsl_spmatrix_set_zero(self)
      self
    end

    def like : SparseMatrix
      return SparseMatrix.new nrows, ncols, type, non_zero
    end

    def clone : SparseMatrix
      SparseMatrix.new(self)
    end

    def non_zero : Int32
      Int32.new(LibGSL.gsl_spmatrix_nnz(self))
    end

    def lib_free
      LibGSL.gsl_spmatrix_free(@pointer)
    end

    def convert(type : Type)
      SparseMatrix.new(self, type)
    end

    def minmax
      return {0.0, 0.0} if non_zero == 0
      LibGSL.gsl_spmatrix_minmax(self, out min, out max)
      min = 0.0 if min > 0.0
      max = 0.0 if max < 0.0
      return min, max
    end

    def transpose : SparseMatrix
      transpose = SparseMatrix.new self.shape[1].to_i, self.shape[0].to_i, type, non_zero
      LibGSL.gsl_spmatrix_transpose_memcpy(transpose, self)
      return transpose
    end

    def transpose!
      LibGSL.gsl_spmatrix_transpose(self)
      self
    end

    def *(n : Int32 | Float64) : SparseMatrix
      temp = self.copy
      LibGSL.gsl_spmatrix_scale(temp, n.to_f)
      temp
    end

    def to_dense
      DenseMatrix.new(self)
    end

    def norm1
      LibGSL.gsl_spmatrix_norm1(self)
    end

    def scale_columns!(v)
      raise ArgumentError.new("dimensions do not match: #{ncols} != #{v.size}") unless ncols == v.size
      v = Vector.new(v) unless v.is_a? Vector
      LibGSL.gsl_spmatrix_scale_columns(self, v)
    end

    def scale_rows!(v)
      raise ArgumentError.new("dimensions do not match: #{nrows} != #{v.size}") unless nrows == v.size
      v = Vector.new(v) unless v.is_a? Vector
      LibGSL.gsl_spmatrix_scale_rows(self, v)
    end

    def min_index
      LibGSL.gsl_spmatrix_min_index(self, out row, out column)
      return row, column
    end
  end

  class DenseMatrix < Matrix
    def to_sparse(typ = SparseMatrix::Type::COO)
      SparseMatrix.new(self, typ)
    end

    def initialize(another : SparseMatrix)
      @pointer = LibGSL.gsl_matrix_calloc(another.nrows, another.ncols)
      LibGSL.gsl_spmatrix_sp2d(@pointer, another)
    end

    def add!(another : SparseMatrix)
      raise ArgumentError.new("dimensions do not match: #{self.shape} != #{another.shape}") unless self.shape == another.shape
      LibGSL.gsl_spmatrix_dense_add(self, another)
    end

    def sub!(another : SparseMatrix)
      raise ArgumentError.new("dimensions do not match: #{self.shape} != #{another.shape}") unless self.shape == another.shape
      LibGSL.gsl_spmatrix_dense_sub(self, another)
    end
  end
end
