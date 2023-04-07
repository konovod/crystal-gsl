module GSL
  # Class representing smoothing basis splines (B-splines)
  # Note that is was changed substancially in GSL 2.8, currently only 2.7 API is supported
  class BSpline
    @raw : Pointer(LibGSL::Gsl_bspline_workspace)

    def initialize(order, points : GSL::Vector)
      @raw = LibGSL.gsl_bspline_alloc(order, points.size)
      LibGSL.gsl_bspline_knots(points.to_unsafe, @raw)
    end

    def self.new(order, points)
      new(order, points.to_vector)
    end

    def initialize(order, npoints : Int32, uniform : Range)
      @raw = LibGSL.gsl_bspline_alloc(order, npoints)
      LibGSL.gsl_bspline_knots_uniform(uniform.begin, uniform.end, @raw)
    end

    def to_unsafe
      @raw
    end

    def size
      LibGSL.gsl_bspline_ncoeffs(@raw).to_i32
    end

    def order
      @raw.value.spline_order.to_i32
    end

    def eval(x, reuse : GSL::Vector? = nil)
      if reuse
        raise ArgumentError.new("Vector is too small, need size #{size} got #{reuse.size}") unless reuse.size >= size
      else
        reuse = GSL::Vector.new(size)
      end
      LibGSL.gsl_bspline_eval(x, reuse.to_unsafe, @raw)
      reuse
    end

    def eval_nonzero(x, reuse : GSL::Vector? = nil)
      if reuse
        raise ArgumentError.new("Vector is too small, need size #{order} got #{reuse.size}") unless reuse.size >= order
      else
        reuse = GSL::Vector.new(order)
      end
      LibGSL.gsl_bspline_eval_nonzero(x, reuse.raw, out istart, out iend, @raw)
      {reuse, istart, iend}
    end

    def greville_abscissa(i)
      LibGSL.gsl_bspline_greville_abscissa(i, @raw)
    end

    def deriv(x, nderiv, reuse : GSL::DenseMatrix? = nil)
      if reuse
        raise ArgumentError.new("Matrix is too small, need size #{size}*#{nderiv + 1} got #{reuse.nrows}*#{reuse.ncols}") unless reuse.nrows >= size && reuse.ncols >= nderiv + 1
      else
        reuse = GSL::DenseMatrix.new(size, nderiv + 1)
      end
      LibGSL.gsl_bspline_deriv_eval(x, nderiv, reuse.to_unsafe, @raw)
      reuse
    end

    def deriv_nonzero(x, nderiv, reuse : GSL::DenseMatrix? = nil)
      if reuse
        raise ArgumentError.new("Matrix is too small, need size #{order}*#{nderiv + 1} got #{reuse.nrows}*#{reuse.ncols}") unless reuse.nrows >= order && reuse.ncols >= nderiv + 1
      else
        reuse = GSL::DenseMatrix.new(order, nderiv + 1)
      end
      LibGSL.gsl_bspline_deriv_eval_nonzero(x, nderiv, reuse.to_unsafe, out istart, out iend, @raw)
      {reuse, istart, iend}
    end

    def free
      return if @raw.null?
      LibGSL.gsl_bspline_free(@raw)
      @raw = Pointer(LibGSL::Gsl_bspline_workspace).null
    end

    def finalize
      free
    end
  end
end
