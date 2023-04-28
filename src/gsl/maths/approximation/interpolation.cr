module GSL
  # 1D Interpolation object
  class Interpolate1D < GSL::Object
    @acc : Pointer(LibGSL::Gsl_interp_accel)
    @xa : Slice(Float64)
    @ya : Slice(Float64)

    enum Type
      Linear
      Polynomial
      CSpline
      CSplinePeriodic
      Akima
      AkimaPeriodic
      Steffen

      def to_unsafe
        case self
        in .linear?
          LibGSL.gsl_interp_linear
        in .polynomial?
          LibGSL.gsl_interp_polynomial
        in .c_spline?
          LibGSL.gsl_interp_cspline
        in .c_spline_periodic?
          LibGSL.gsl_interp_cspline_periodic
        in .akima?
          LibGSL.gsl_interp_akima
        in .akima_periodic?
          LibGSL.gsl_interp_akima_periodic
        in .steffen?
          LibGSL.gsl_interp_steffen
        end
      end

      def to_s
        String.new(to_unsafe.value.name)
      end

      def min_points
        LibGSL.gsl_interp_type_min_size(to_unsafe)
      end
    end

    # TODO - check sorted?
    def initialize(@type : Type, xa : Array(Float64) | Slice(Float64), ya : Array(Float64) | Slice(Float64))
      xa = Slice(Float64).new(xa.to_unsafe, xa.size, read_only: true) if xa.is_a? Array(Float64)
      ya = Slice(Float64).new(ya.to_unsafe, ya.size, read_only: true) if ya.is_a? Array(Float64)
      raise ArgumentError.new("xa.size != ya.size (#{xa.size} != #{ya.size})") unless xa.size == ya.size
      raise ArgumentError.new("xa.size < minimum for #{type.to_s} (#{xa.size} < #{type.min_points})") unless xa.size >= type.min_points
      @pointer = LibGSL.gsl_interp_alloc(type, xa.size)
      @xa = xa.dup
      @ya = ya.dup
      @acc = LibGSL.gsl_interp_accel_alloc
      LibGSL.gsl_interp_init(@pointer, @xa, @ya, @xa.size)
    end

    getter type

    def x
      Slice.new(@xa.to_unsafe, @xa.size, read_only: true)
    end

    def y
      Slice.new(@ya.to_unsafe, @ya.size, read_only: true)
    end

    def size
      @xa.size
    end

    def update(xa = nil, ya = nil)
      return if xa.nil? && ya.nil?
      if xa
        raise ArgumentError.new("Updated xa must have same size (#{xa.size} != #{size})") unless xa.size == size
        @xa.copy_from(xa.to_unsafe, xa.size)
        LibGSL.gsl_interp_accel_reset(@acc)
      end
      if ya
        raise ArgumentError.new("Updated ya must have same size (#{ya.size} != #{size})") unless ya.size == size
        @ya.copy_from(ya.to_unsafe, ya.size)
      end
      LibGSL.gsl_interp_init(@pointer, @xa, @ya, @xa.size)
    end

    def lib_free
      LibGSL.gsl_interp_free(@pointer)
      LibGSL.gsl_interp_accel_free(@acc)
    end

    enum DerivativeOrder
      Function
      FirstDerivative
      SecondDerivative
    end

    def eval(x, deriv : DerivativeOrder = DerivativeOrder::Function)
      result = 0.0
      case deriv
      in .function?
        code = LibGSL.gsl_interp_eval_e(@pointer, @xa, @ya, x, @acc, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp_eval_e")
      in .first_derivative?
        code = LibGSL.gsl_interp_eval_deriv_e(@pointer, @xa, @ya, x, @acc, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp_eval_deriv_e")
      in .second_derivative?
        code = LibGSL.gsl_interp_eval_deriv2_e(@pointer, @xa, @ya, x, @acc, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp_eval_deriv2_e")
      end
      result
    end

    def integrate(a, b)
      code = LibGSL.gsl_interp_eval_integ_e(@pointer, @xa, @ya, a, b, @acc, out result)
      GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp_eval_integ_e")
      result
    end

    def x_index(x)
      LibGSL.gsl_interp_accel_find(@acc, @xa, size, x)
    end
  end

  class Interpolate2D < GSL::Object
    @accx : Pointer(LibGSL::Gsl_interp_accel)
    @accy : Pointer(LibGSL::Gsl_interp_accel)
    @xa : Slice(Float64)
    @ya : Slice(Float64)
    @za : Slice(Float64)

    enum Type
      Bilinear
      Bicubic

      def to_unsafe
        case self
        in .bilinear?
          LibGSL.gsl_interp2d_bilinear
        in .bicubic?
          LibGSL.gsl_interp2d_bicubic
        end
      end

      def to_s
        String.new(to_unsafe.value.name)
      end

      def min_points
        LibGSL.gsl_interp2d_type_min_size(to_unsafe)
      end
    end

    # TODO - check sorted?
    def initialize(@type : Type, xa : Array(Float64) | Slice(Float64), ya : Array(Float64) | Slice(Float64), za : Array(Float64) | Slice(Float64))
      xa = Slice(Float64).new(xa.to_unsafe, xa.size, read_only: true) if xa.is_a? Array(Float64)
      ya = Slice(Float64).new(ya.to_unsafe, ya.size, read_only: true) if ya.is_a? Array(Float64)
      za = Slice(Float64).new(za.to_unsafe, za.size, read_only: true) if za.is_a? Array(Float64)
      raise ArgumentError.new("xa.size*ya.size != za.size (#{xa.size}*#{ya.size} != #{za.size})") unless xa.size*ya.size == za.size
      raise ArgumentError.new("xa.size < minimum for #{type.to_s} (#{xa.size} < #{type.min_points})") unless xa.size >= type.min_points
      raise ArgumentError.new("ya.size < minimum for #{type.to_s} (#{ya.size} < #{type.min_points})") unless ya.size >= type.min_points
      @pointer = LibGSL.gsl_interp2d_alloc(type, xa.size, ya.size)
      @xa = xa.dup
      @ya = ya.dup
      @za = za.dup
      @accx = LibGSL.gsl_interp_accel_alloc
      @accy = LibGSL.gsl_interp_accel_alloc
      LibGSL.gsl_interp2d_init(@pointer, @xa, @ya, @za, @xa.size, @ya.size)
    end

    getter type

    def x
      Slice.new(@xa.to_unsafe, @xa.size, read_only: true)
    end

    def y
      Slice.new(@ya.to_unsafe, @ya.size, read_only: true)
    end

    # TODO - property z

    def size
      {@xa.size, @ya.size}
    end

    def update(xa = nil, ya = nil, za = nil)
      return if xa.nil? && ya.nil? && za.nil?
      if xa
        raise ArgumentError.new("Updated xa must have same size (#{xa.size} != #{size[0]})") unless xa.size == size[0]
        @xa.copy_from(xa.to_unsafe, xa.size)
        LibGSL.gsl_interp_accel_reset(@accx)
      end
      if ya
        raise ArgumentError.new("Updated ya must have same size (#{ya.size} != #{size[1]})") unless ya.size == size[1]
        @ya.copy_from(ya.to_unsafe, ya.size)
        LibGSL.gsl_interp_accel_reset(@accy)
      end
      if za
        raise ArgumentError.new("Updated za must have same size (#{za.size} != #{size[0]*size[1]})") unless za.size == size[0]*size[1]
        @za.copy_from(za.to_unsafe, za.size)
      end
      LibGSL.gsl_interp_init(@pointer, @xa, @ya, @xa.size)
    end

    def lib_free
      LibGSL.gsl_interp2d_free(@pointer)
      LibGSL.gsl_interp_accel_free(@accx)
      LibGSL.gsl_interp_accel_free(@accy)
    end

    enum DerivativeOrder
      Function
      Extrapolate
      DfDx
      DfDy
      D2fDx2
      D2fDy2
      D2fDxDy
    end

    def eval(x, y, deriv : DerivativeOrder = DerivativeOrder::Function)
      result = 0.0
      case deriv
      in .function?
        code = LibGSL.gsl_interp2d_eval_e(@pointer, @xa, @ya, @za, x, y, @accx, @accy, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp2d_eval_e")
      in .extrapolate?
        code = LibGSL.gsl_interp2d_eval_extrap_e(@pointer, @xa, @ya, @za, x, y, @accx, @accy, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp2d_eval_extrap_e")
      in .df_dx?
        code = LibGSL.gsl_interp2d_eval_deriv_x_e(@pointer, @xa, @ya, @za, x, y, @accx, @accy, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp2d_eval_deriv_x_e")
      in .df_dy?
        code = LibGSL.gsl_interp2d_eval_deriv_y_e(@pointer, @xa, @ya, @za, x, y, @accx, @accy, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp2d_eval_deriv_y_e")
      in .d2f_dx2?
        code = LibGSL.gsl_interp2d_eval_deriv_xx_e(@pointer, @xa, @ya, @za, x, y, @accx, @accy, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp2d_eval_deriv_xx_e")
      in .d2f_dx_dy?
        code = LibGSL.gsl_interp2d_eval_deriv_xy_e(@pointer, @xa, @ya, @za, x, y, @accx, @accy, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp2d_eval_deriv_xy_e")
      in .d2f_dy2?
        code = LibGSL.gsl_interp2d_eval_deriv_yy_e(@pointer, @xa, @ya, @za, x, y, @accx, @accy, pointerof(result))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_interp2d_eval_deriv_yy_e")
      end
      result
    end

    def x_index(x)
      LibGSL.gsl_interp_accel_find(@accx, @xa, size, x)
    end

    def y_index(y)
      LibGSL.gsl_interp_accel_find(@accy, @ya, size, y)
    end
  end
end
