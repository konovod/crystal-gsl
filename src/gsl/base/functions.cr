require "./libgsl.cr"

module GSL
  private macro def_function(fn)
    def self.{{fn}}(x) : Float64
      code = LibGSL.gsl_sf_{{fn}}_e(x, out result)
      check_return_code(LibGSL::Code.new(code), "gsl_sf_{{fn}}_e")
      result.val
    end
  end

  enum Precision
    Double = 0
    Single = 1
    Approx = 2
  end

  private macro def_function_with_mode(fn)
    def self.{{fn}}(x, precision : Precision) : Float64
      code = LibGSL.gsl_sf_{{fn}}_e(x, LibGSL::Gsl_mode_t.new(precision), out result)
      check_return_code(LibGSL::Code.new(code), "gsl_sf_{{fn}}_e")
      result.val
    end
  end

  def_function(lngamma)
end
