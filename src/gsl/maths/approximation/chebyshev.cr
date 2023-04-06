module GSL
  # Class representing Chebyshev approximations to univariate functions
  class Chebyshev
    @raw : Pointer(LibGSL::Gsl_cheb_series)

    def to_unsafe
      @raw
    end

    def order
      @raw.value.order
    end

    def size
      order + 1
    end

    def min
      @raw.value.a
    end

    def max
      @raw.value.b
    end

    def range
      min..max
    end

    def coeffs : Slice(Float64)
      @raw.value.c.to_slice(size)
    end

    protected def initialize(order)
      @raw = LibGSL.gsl_cheb_alloc(order)
    end

    def Chebyshev.allocate(order)
      self.new(order)
    end

    def initialize(order, f : GSL::Function, range : Range(Float64, Float64))
      @raw = LibGSL.gsl_cheb_alloc(order)
      f_boxed = GSL.wrap_function(f)
      LibGSL.gsl_cheb_init(@raw, pointerof(f_boxed), range.begin, range.end)
    end

    def initialize(order, f : GSL::Function, min : Float64, max : Float64)
      @raw = LibGSL.gsl_cheb_alloc(order)
      LibGSL.gsl_cheb_init(@raw, GSL.wrap_function(f), min, max)
    end

    def free
      return if @raw.null?
      LibGSL.gsl_cheb_free(@raw)
      @raw = Pointer(LibGSL::Gsl_cheb_series).null
    end

    def finalize
      free
    end

    def eval(x, order = nil)
      if order
        LibGSL.gsl_cheb_eval_n(@raw, order, x)
      else
        LibGSL.gsl_cheb_eval(@raw, x)
      end
    end

    def eval_err(x, order = nil)
      result = 0.0
      err = 0.0
      if order
        code = LibGSL.gsl_cheb_eval_n_err(@raw, order, x, pointerof(result), pointerof(err))
      else
        code = LibGSL.gsl_cheb_eval_err(@raw, x, pointerof(result), pointerof(err))
      end
      GSL.check_return_code(LibGSL::Code.new(code), "gsl_cheb_eval_err")
      {result, err}
    end

    def deriv
      result = Chebyshev.allocate(order)
      LibGSL.gsl_cheb_calc_deriv(result.to_unsafe, to_unsafe)
      result
    end

    def integrate
      result = Chebyshev.allocate(order)
      LibGSL.gsl_cheb_calc_integ(result.to_unsafe, to_unsafe)
      result
    end
  end
end
