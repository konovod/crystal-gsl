module GSL
  class Matrix
    getter pointer

    def initialize(@rows : Int32, @columns : Int32)
      @pointer = LibGSL.matrix_calloc(@rows, @columns)
    end

    def nrows : LibC::SizeT
      @pointer.value.size1
    end

    def ncols : LibC::SizeT
      @pointer.value.size2
    end

    def shape
      Tuple.new(@rows, @columns)
    end

    def inspect
      self.map_rows { |x| x.inspect }.join("\n")
    end

    def ==(m : GSL::Matrix)
      LibGSL.matrix_equal(self.pointer, m.pointer) == 1 ? true : false
    end

    def [](row : Symbol | Int32, column : Symbol | Int32) : Vector
      if row == :all
        return self.column(column)
      elsif column == :all
        return self.row(row)
      else
        return GSL::Vector.new [0.0]
      end
    end

    def [](row : Int32, column : Int32) : Float64
      return LibGSL.matrix_get(@pointer, LibC::SizeT.new(row), LibC::SizeT.new(column))
    end

    def set_row(r : Int32, v : Vector) : Int32
      Int32.new(LibGSL.matrix_set_row(@pointer, LibC::SizeT.new(r), v.pointer))
    end

    def row(r : Int32 | Symbol) : Vector
      result = Vector.new @columns
      LibGSL.matrix_get_row(result.pointer, @pointer, r.to_i)
      return result
    end

    def set_col(c : Int32, v : Vector) : Int32
      Int32.new(LibGSL.matrix_set_col(@pointer, c.to_i, v.pointer))
    end

    def column(c : Int32 | Symbol) : Vector
      result = Vector.new @rows
      LibGSL.matrix_get_col(result.pointer, @pointer, c.to_i)
      return result
    end

    def []=(row : Symbol | Int32, column : Symbol | Int32, x : Int32 | Float64)
      if row == :all
        (0...@rows).each { |n| LibGSL.matrix_set(@pointer, n, column.to_i, x) }
        self[:all, column]
      elsif column == :all
        (0...@columns).each { |n| LibGSL.matrix_set(@pointer, row.to_i, n, x) }
        self[row, :all]
      else
        LibGSL.matrix_set(@pointer, row.to_i, column.to_i, x.to_f)
        self[row, column]
      end
    end

    def []=(row : Symbol | Int32, column : Symbol | Int32, x : Vector)
      if row == :all
        (0...@rows).each { |n| LibGSL.matrix_set(@pointer, n, column.to_i, x[n]) }
        self[:all, column]
      elsif column == :all
        (0...@columns).each { |n| LibGSL.matrix_set(@pointer, row.to_i, n, x[n]) }
        self[row, :all]
      end
    end

    def set(row, column, x)
      return LibGSL.matrix_set(@pointer, row, column, x)
    end

    def get(row, column) : Float64
      return LibGSL.matrix_get(@pointer, row, column)
    end

    def *(v : Vector) : Vector
      result = Vector.new self.nrows
      LibGSL.blas_dgemv(LibGSL::CblasTransposeT::CblasNoTrans, 1.0, @pointer, v.getPointer, 1.0, result.getPointer)
      return result
    end

    def copy : Matrix
      result = Matrix.new @rows, @columns
      LibGSL.matrix_memcpy(result.pointer, @pointer)
      return result
    end

    def like : Matrix
      return Matrix.new @rows, @columns
    end

    def self.eye(size : Int32) : Matrix
      matrix = Matrix.new size, size
      (0...size).each do |i|
        matrix[i, i] = 1.0
      end
      return matrix
    end

    def self.free(m : Matrix)
      LibGSL.matrix_free(m.pointer)
    end

    def set_all(n : Float64 | Int32)
      LibGSL.matrix_set_all(self.pointer, n.to_f)
      self
    end

    def set_zero
      LibGSL.matrix_set_zero(self.pointer)
      self
    end

    def set_identity
      LibGSL.matrix_set_identity(self.pointer)
      self
    end

    def max
      LibGSL.matrix_max(self.pointer)
    end

    def min
      LibGSL.matrix_min(self.pointer)
    end

    def minmax
      [LibGSL.matrix_min(self.pointer), LibGSL.matrix_max(self.pointer)]
    end

    def max_index
      row : LibC::SizeT = 0_u64
      column : LibC::SizeT = 0_u64
      LibGSL.matrix_max_index(self.pointer, pointerof(row), pointerof(column))
      [row, column]
    end

    def min_index
      row : LibC::SizeT = 0_u64
      column : LibC::SizeT = 0_u64
      LibGSL.matrix_min_index(self.pointer, pointerof(row), pointerof(column))
      [row, column]
    end

    def empty?
      LibGSL.matrix_isnull(self.pointer) == 1 ? true : false
    end

    def pos?
      LibGSL.matrix_ispos(self.pointer) == 1 ? true : false
    end

    def neg?
      LibGSL.matrix_isneg(self.pointer) == 1 ? true : false
    end

    def has_neg?
      LibGSL.matrix_isnonneg(self.pointer) == 1 ? false : true
    end

    def head
      self.nrows >= 5 ? puts (0...5).map { |x| self[x, :all].inspect }.join("\n") : puts self.inspect
    end

    def tail
      self.nrows >= 5 ? puts ((self.nrows - 5).to_i...self.nrows.to_i).map { |x| self[x, :all].inspect }.join("\n") : puts self.inspect
    end
  end
end
