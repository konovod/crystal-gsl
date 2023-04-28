module GSL
  # Class representing Chebyshev approximations to univariate functions
  class Chebyshev < GSL::Object

    def order
      @pointer.value.order
    end

    def size
      order + 1
    end

    def min
      @pointer.value.a
    end

    def max
      @pointer.value.b
    end

    def range
      min..max
    end

    def coeffs : Slice(Float64)
      @pointer.value.c.to_slice(size)
    end

    protected def initialize(order)
      @pointer = LibGSL.gsl_cheb_alloc(order)
    end

    def Chebyshev.allocate(order)
      self.new(order)
    end

    def initialize(order, f : GSL::Function, range : Range(Float64, Float64))
      @pointer = LibGSL.gsl_cheb_alloc(order)
      f_boxed = GSL.wrap_function(f)
      LibGSL.gsl_cheb_init(@pointer, pointerof(f_boxed), range.begin, range.end)
    end

    def initialize(order, f : GSL::Function, min : Float64, max : Float64)
      @pointer = LibGSL.gsl_cheb_alloc(order)
      LibGSL.gsl_cheb_init(@pointer, GSL.wrap_function(f), min, max)
    end

    def lib_free
      LibGSL.gsl_cheb_free(@pointer)
    end

    def eval(x, order = nil)
      if order
        LibGSL.gsl_cheb_eval_n(@pointer, order, x)
      else
        LibGSL.gsl_cheb_eval(@pointer, x)
      end
    end

    def eval_err(x, order = nil)
      result = 0.0
      err = 0.0
      if order
        code = LibGSL.gsl_cheb_eval_n_err(@pointer, order, x, pointerof(result), pointerof(err))
      else
        code = LibGSL.gsl_cheb_eval_err(@pointer, x, pointerof(result), pointerof(err))
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
