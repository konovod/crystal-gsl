require "../../base/*"

module GSL::Min
  enum Type
    GoldenSection
    Brent
    QuadGolden
  end

  class FMinimizer
    getter raw : LibGSL::MinFminimizer*

    def initialize(typ : Type)
      case typ
      when .golden_section?
        lib_type = LibGSL.gsl_min_fminimizer_goldensection
      when .brent?
        lib_type = LibGSL.gsl_min_fminimizer_brent
      when .quad_golden?
        lib_type = LibGSL.gsl_min_fminimizer_quad_golden
      else
        raise ArgumentError.new("incorrect minimizer type")
      end
      @raw = LibGSL.min_fminimizer_alloc(lib_type)
    end

    def free
      # to prevent second free (e.g. during finalize)
      return if @raw == Pointer(LibGSL::MinFminimizer).new(0)
      LibGSL.min_fminimizer_free(@raw)
      @raw = Pointer(LibGSL::MinFminimizer).new(0)
    end

    def finalize
      free
    end

    # fun min_fminimizer_set = gsl_min_fminimizer_set(s : MinFminimizer*, f : Function*, x_minimum : LibC::Double, x_lower : LibC::Double, x_upper : LibC::Double) : LibC::Int
    # fun min_fminimizer_set_with_values = gsl_min_fminimizer_set_with_values(s : MinFminimizer*, f : Function*, x_minimum : LibC::Double, f_minimum : LibC::Double, x_lower : LibC::Double, f_lower : LibC::Double, x_upper : LibC::Double, f_upper : LibC::Double) : LibC::Int
    # fun min_fminimizer_iterate = gsl_min_fminimizer_iterate(s : MinFminimizer*) : LibC::Int
    # fun min_test_interval = gsl_min_test_interval(x_lower : LibC::Double, x_upper : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double) : LibC::Int
    # fun min_find_bracket = gsl_min_find_bracket(f : Function*, x_minimum : LibC::Double*, f_minimum : LibC::Double*, x_lower : LibC::Double*, f_lower : LibC::Double*, x_upper : LibC::Double*, f_upper : LibC::Double*, eval_max : LibC::SizeT) : LibC::Int

    def name
      String.new(LibGSL.min_fminimizer_name(@raw))
    end

    getter function : GSL::Function?
    @wrap = LibGSL::Function.new

    def setup(x_minimum : Float64, x_lower : Float64, x_upper : Float64, &f : GSL::Function)
      @function = f
      @wrap = GSL.wrap_function(self) do |x, data|
        data.as(FMinimizer).function.not_nil!.call(x)
      end
      LibGSL.min_fminimizer_set(@raw, pointerof(@wrap),
        x_minimum, x_lower, x_upper)
    end

    def setup(x_minimum : Float64, f_minimum : Float64, x_lower : Float64, f_lower : Float64, x_upper : Float64, f_upper : Float64, &f : GSL::Function)
      @function = f
      @wrap = GSL.wrap_function(self) do |x, data|
        data.as(FMinimizer).function.not_nil!.call(x)
      end
      LibGSL.min_fminimizer_set(@raw, pointerof(@wrap),
        x_minimum, f_minimum, x_lower, f_lower, x_upper, f_upper)
    end

    delegate x_lower, x_upper, x_minimum, f_lower, f_upper, f_minimum, to: @raw.value

    def iterate
      LibGSL.min_fminimizer_iterate(@raw)
    end

    def test_interval(eps_abs, eps_rel = 0.0)
      LibGSL::Code.new(LibGSL.min_test_interval(x_lower, x_upper, eps_abs, eps_rel))
    end
  end
end
