require "../../base/libgsl.cr"

module GSL::Min
  enum Type
    GoldenSection
    Brent
    QuadGolden
  end

  class FMinimizer
    @raw : LibGSL::MinFminimizer*

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
  end
end
