require "./spec_helper"

ROWS = 5
COLS = 5
test_matrix = GSL::SparseMatrix.new ROWS, COLS

describe GSL::SparseMatrix do
  describe "#nrows" do
    it "should return the number of rows of a matrix" do
      test_matrix.nrows.should eq ROWS
    end
  end
  describe "#ncols" do
    it "should return the number of columns of a matrix" do
      test_matrix.ncols.should eq COLS
    end
  end
  describe "#shape" do
    it "should return the shape of a matrix" do
      test_matrix.shape.should eq({ROWS, COLS})
    end
  end
  describe "#[]" do
    it "should return a value of expected index" do
      test_matrix[0, 0].should eq 0.0
    end
    it "should return a vector of expected column" do
      test_matrix[:all, 0].should eq(GSL::Vector.new ROWS)
    end
    it "should return a vector of expected row" do
      test_matrix[0, :all].should eq(GSL::Vector.new COLS)
    end
    it "should return a matrix with the same dimensions" do
      temp = test_matrix.like
      temp.shape.should eq({5, 5})
    end
  end
  describe "#set_zero" do
    it "should set all the values in the sparse matrix to zero" do
      temp = GSL::SparseMatrix.new ROWS, COLS
      temp[0, 0] = 10
      temp.set_zero.should eq test_matrix
    end
  end
  describe "#*" do
    it "should return the scaling of two matrices" do
      temp = test_matrix.like
      temp[0, 0] = 7.0
      result = test_matrix.like
      result[0, 0] = 14.0
      (temp * 2.0).should eq result
    end
  end
  describe "#non_zero" do
    it "should count all non-zero entries" do
      temp = GSL::SparseMatrix.new ROWS, COLS
      temp[0, 0] = 10
      temp[1, 1] = 5.0
      temp.non_zero.should eq 2
    end
  end
  describe "#minmax" do
    it "should return the minimum and maximun value of the matrix" do
      temp = test_matrix.like
      temp[0, 0] = 1
      temp.minmax.should eq({0, 1})
    end
    it "should return 0 value for empty matrix" do
      temp = test_matrix.like
      temp.minmax.should eq({0, 0})
    end
  end

  describe ".new" do
    it "should create empty COO matrix" do
      sp = GSL::SparseMatrix.new 5, 5
      sp.type.should eq GSL::SparseMatrix::Type::COO
    end
    it "should create sparse matrix of given type" do
      sp = GSL::SparseMatrix.new 5, 5, :csr
      sp.type.should eq GSL::SparseMatrix::Type::CSR
    end

    it "should create copy of matrix" do
      sp1 = GSL::SparseMatrix.new 7, 3
      sp1[1, 1] = 1
      sp2 = GSL::SparseMatrix.new sp1
      sp2.type.should eq GSL::SparseMatrix::Type::COO
      sp2.should eq sp1
      sp1[1, 1] = 5
      sp2[1, 1].should eq 1
    end

    it "should create copy of matrix with given type" do
      sp1 = GSL::SparseMatrix.new 7, 3
      sp1[1, 1] = 1
      sp2 = GSL::SparseMatrix.new sp1, :csr
      sp2.type.should eq GSL::SparseMatrix::Type::CSR
      sp2[1, 1].should eq 1
    end

    it "should create sparse matrix from dense matrix" do
      sp1 = GSL::DenseMatrix.new 7, 3
      sp1[1, 1] = 1
      sp2 = GSL::SparseMatrix.new sp1, :csr
      sp2.type.should eq GSL::SparseMatrix::Type::CSR
      sp2[1, 1].should eq 1
    end
  end

  describe "#convert" do
    it "should convert matrix to given type" do
      sp1 = GSL::SparseMatrix.new 7, 3, :coo
      sp1[1, 2] = 3
      sp2 = sp1.convert(:csr)
      sp2.type.should eq GSL::SparseMatrix::Type::CSR
      sp2[1, 2].should eq 3
    end
    it "should return clone when type isn't changed" do
      sp1 = GSL::SparseMatrix.new 7, 3, :coo
      sp1[1, 2] = 3
      sp2 = sp1.convert(:coo)
      sp2.type.should eq GSL::SparseMatrix::Type::COO
      sp2[1, 2].should eq 3
    end
  end

  describe "#transpose" do
    it "should return transpose" do
      sp1 = GSL::SparseMatrix.new 7, 3
      sp1[1, 2] = 3
      sp2 = sp1.transpose
      sp2.type.should eq sp1.type
      sp2.shape.should eq({3, 7})
      sp2[2, 1].should eq 3
    end
  end
  describe "#transpose!" do
    it "should transpose inplace" do
      sp1 = GSL::SparseMatrix.new 7, 3
      sp1[1, 2] = 3
      sp1 = sp1.convert(:csr)
      sp1.transpose!
      sp1.shape.should eq({3, 7})
      sp1[2, 1].should eq 3
    end
  end

  describe "#to_dense" do
    it "returns dense matrix with same elements" do
      sp1 = GSL::SparseMatrix.new 7, 3
      sp1[1, 2] = 3
      sp2 = sp1.to_dense
      sp2[1, 2].should eq 3
      sp1[1, 1].should eq 0
    end
  end

  describe "#norm1" do
    it "returns zero for empty matrix" do
      test_matrix.norm1.should eq 0
    end
    it "returns norm1 value" do
      sp1 = GSL::SparseMatrix.new 7, 3
      sp1[1, 2] = -3
      sp1[2, 2] = 2
      sp1.norm1.should eq 5
    end
  end

  describe "#scale_columns" do
    it "scale columns by vector" do
      a = GSL::SparseMatrix.new 4, 3
      a[2, 0] = -3
      a[3, 1] = 2
      a.scale_columns! GSL::Vector.new [10.0, 20.0, 30.0]
      a[2, 0].should eq -30
      a[3, 1].should eq 40
    end
    it "scale columns by array" do
      a = GSL::SparseMatrix.new 4, 3
      a[2, 0] = -3
      a[3, 1] = 2
      a.scale_columns!([10.0, 20.0, 30.0])
      a[2, 0].should eq -30
      a[3, 1].should eq 40
    end
    it "should raise if dimensions don't match" do
      a = GSL::SparseMatrix.new 4, 3
      expect_raises(Exception) { a.scale_columns!([1.0, 2.0, 3.0, 4.0]) }
    end
  end

  describe "#scale_rows" do
    it "scale rows by vector" do
      a = GSL::SparseMatrix.new 4, 3
      a[0, 2] = -3
      a[1, 2] = 2
      a.scale_rows! GSL::Vector.new [10.0, 20.0, 30.0, 40.0]
      a[0, 2].should eq -30
      a[1, 2].should eq 40
    end
    it "scale rows by array" do
      a = GSL::SparseMatrix.new 4, 3
      a[0, 2] = -3
      a[1, 2] = 2
      a.scale_rows!([10.0, 20.0, 30.0, 40.0])
      a[0, 2].should eq -30
      a[1, 2].should eq 40
    end
    it "should raise if dimensions don't match" do
      a = GSL::SparseMatrix.new 7, 3
      expect_raises(Exception) { a.scale_rows!([4.0, 5.0, 6.0]) }
    end
  end

  describe "#min_index" do
    it "should find minimal element" do
      a = GSL::SparseMatrix.new 4, 3
      a[0, 2] = -3
      a[1, 2] = 2
      a.min_index.should eq({0, 2})
    end
    it "should find minimal element when all elements are positive" do
      a = GSL::SparseMatrix.new 4, 3
      a[0, 2] = 3
      a[1, 2] = 0
      a.min_index.should eq({1, 2})
    end
  end

  describe "#*" do
    it "can multiply to sparse matrix" do
      a = GSL::DenseMatrix.eye 5
      a[0, 2] = -3
      a[2, 0] = 3
      sa = a.to_sparse(GSL::SparseMatrix::Type::CSC)
      sb = a.i.to_sparse(GSL::SparseMatrix::Type::CSC)
      ((sa*sb).to_dense - GSL::DenseMatrix.eye(5)).norm1.should be < 1e-9
    end

    it "should raise when dimension of matrices do not match" do
      a = GSL::SparseMatrix.new 3, 4, GSL::SparseMatrix::Type::CSC
      b = GSL::SparseMatrix.new 3, 4, GSL::SparseMatrix::Type::CSC
      expect_raises(Exception) { a*b }
    end

    it "can multiply to vector" do
      a = GSL::SparseMatrix.new 4, 3
      a[1, 2] = -1
      a[2, 0] = -1
      b = GSL::Vector.new [10.0, 20.0, 30.0]
      (a*b).to_a.should eq [0, -30, -10, 0]
    end

    it "should raise when dimension of vector do not match" do
      a = GSL::SparseMatrix.new 3, 4
      b = GSL::Vector.new [10.0, 20.0, 30.0]
      expect_raises(Exception) { a*b }
    end
  end

  describe ".solve" do
    it "should solve example from gsl docs" do
      n = 100         #  number of grid points
      size = n - 2    # subtract 2 to exclude boundaries
      h = 1 / (n - 1) # grid spacing
      a = GSL::SparseMatrix.new(size, size)
      f = GSL::Vector.new(size)
      # construct the sparse matrix for the finite difference equation
      # construct first row
      a[0, 0] = -2
      a[0, 1] = 1
      # construct rows [1:n-2]
      (1...size - 1).each do |i|
        a[i, i + 1] = 1
        a[i, i] = -2
        a[i, i - 1] = 1
      end
      # construct last row
      a[size - 1, size - 1] = -2
      a[size - 1, size - 2] = 1
      # scale by h^2
      a = a*h
      # construct right hand side vector
      size.times do |i|
        xi = (i + 1) * h
        fi = -Math::PI * Math::PI * Math.sin(Math::PI * xi)
        f[i] = fi
      end
      # convert to compressed column format
      c = a.convert(:csc)
      # now solve the system with the GMRES iterative solver
      u = GSL::SparseMatrix.solve(a, f)
      pp u.to_a
    end
  end
end

describe GSL::DenseMatrix do
  describe "#add!" do
    it "should add! sparse matrix to dense" do
      a = GSL::DenseMatrix.new 5, 5
      a[1, 2] = 3
      a[2, 3] = 4
      b = GSL::SparseMatrix.new 5, 5
      b[1, 2] = -3
      b[3, 2] = -4

      a.add! b
      a[1, 2].should eq 0
      a[2, 3].should eq 4
      a[3, 2].should eq -4
    end
    it "should raise if dimensions don't match" do
      a = GSL::DenseMatrix.new 5, 4
      expect_raises(Exception) { a.add!(GSL::SparseMatrix.new(4, 5)) }
    end
  end

  describe "#sub!" do
    it "should sub! sparse matrix from dense" do
      a = GSL::DenseMatrix.new 5, 5
      a[1, 2] = 3
      a[2, 3] = 4
      b = GSL::SparseMatrix.new 5, 5
      b[1, 2] = 3
      b[3, 2] = 4

      a.sub! b
      a[1, 2].should eq 0
      a[2, 3].should eq 4
      a[3, 2].should eq -4
    end
    it "should raise if dimensions don't match" do
      a = GSL::DenseMatrix.new 5, 4
      expect_raises(Exception) { a.sub!(GSL::SparseMatrix.new(4, 5)) }
    end
  end
end
