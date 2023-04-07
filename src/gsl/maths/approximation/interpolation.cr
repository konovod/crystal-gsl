module GSL
  # 1D Interpolation object
  class Interpolate1D
    @raw : Pointer(LibGSL::Gsl_interp)
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
      Bilinear
      Bicubic

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
        LibGSL.gsl_interp_type_min_size(to_unsafe)
      end
    end

    # TODO - check sorted?
    # TODO - resuse accelerator object?
    def initialize(@type : Type, xa : Array(Float64) | Slice(Float64), ya : Array(Float64) | Slice(Float64))
      xa = Slice(Float64).new(xa.to_unsafe, xa.size, read_only: true) if xa.is_a? Array(Float64)
      ya = Slice(Float64).new(ya.to_unsafe, ya.size, read_only: true) if ya.is_a? Array(Float64)
      raise ArgumentError.new("xa.size != ya.size (#{xa.size} != #{ya.size})") unless xa.size == ya.size
      raise ArgumentError.new("xa.size < minimum for #{type.to_s} (#{xa.size} != #{type.min_points})") unless xa.size >= type.min_points
      @raw = LibGSL.gsl_interp_alloc(type, xa.size)
      @xa = xa.dup
      @ya = ya.dup
      @acc = LibGSL.gsl_interp_accel_alloc
      LibGSL.gsl_interp_init(@raw, @xa, @ya, @xa.size)
    end

    getter type

    def to_unsafe
      @raw
    end

    def x
      Slice.new(@xa.to_unsafe, @xa.size, read_only: true)
    end

    def y
      Slice.new(@ya.to_unsafe, @ya.size, read_only: true)
    end

    def size
      @xa.size
    end

    def update(xa, ya)
      raise ArgumentError.new("Updated xa must have same size (#{xa.size} != #{size})") unless xa.size == size
      raise ArgumentError.new("Updated ya must have same size (#{ya.size} != #{size})") unless ya.size == size
      @xa.copy_from(xa.to_unsafe, xa.size)
      @ya.copy_from(ya.to_unsafe, ya.size)
      LibGSL.gsl_interp_init(@raw, @xa, @ya, @xa.size)
      LibGSL.gsl_interp_accel_reset(@acc)
    end

    def free
      return if @raw.null?
      LibGSL.gsl_interp_free(@raw)
      LibGSL.gsl_interp_accel_free(@acc)
      @raw = Pointer(LibGSL::Gsl_spline).null
    end

    def finalize
      free
    end

    enum Derivative
      Function
      Derivative1
      Derivative2
      Integral
    end

    def eval(x, deriv : Derivative = Derivative::Function)
      result = 0.0
      case deriv
      in .function?
        code = LibGSL.gsl_interp_eval_e(@raw, @xa, @ya, x, @acc, pointerof(result))
      in .derivative1?
        code = LibGSL.gsl_interp_eval_deriv_e(@raw, @xa, @ya, x, @acc, pointerof(result))
      in .derivative2?
        code = LibGSL.gsl_interp_eval_deriv2_e(@raw, @xa, @ya, x, @acc, pointerof(result))
      in .integral?
        code = LibGSL.gsl_interp_eval_integ_e(@raw, @xa, @ya, x, @acc, pointerof(result))
      end
      GSL.check_return_code(code)
      result
    end

    def find(x)
      LibGSL.gsl_interp_accel_find(@acc, @xa, size, x)
    end
  end
end
