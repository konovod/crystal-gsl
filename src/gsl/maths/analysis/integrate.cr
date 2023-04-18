require "simplepool"

module GSL::Integration
  # The QNG algorithm is a non-adaptive procedure which uses fixed Gauss-Kronrod-Patterson abscissae to sample the
  # integrand at a maximum of 87 points.
  # It is provided for fast integration of smooth functions
  # Integrates `function` from `a` to `b` with absolute precision `epsabs` OR relative precision `epsrel`.
  # If none of precisions given, it is assumed that `epsabs = 1e-9`.
  # Returns integration result, estimated error and number of evaluations.
  # Example: ```
  # f = ->(x : Float64) { Math.sin(x) }
  # result, eps, count = GSL::Integration.qng(f, 0.0, Math::PI/2)`
  # ```
  #
  def self.qng(function : Proc(Float64, Float64), a : Float64, b : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0)
    f = GSL.wrap_function(function)
    if epsabs.zero? && epsrel.zero?
      epsabs = 1e-9
    end
    code = LibGSL.gsl_integration_qng(pointerof(f), a, b, epsabs, epsrel, out result, out abserr, out neval)
    GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_qng")
    return result, abserr, neval
  end

  # Yielding version of `#qng`
  # Example: ```
  # result, eps, count = GSL::Integration.qng(0.0, Math::PI/2) { |x| Math.sin(x) }`
  # ```
  #
  def self.qng(a : Float64, b : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, &function : Proc(Float64, Float64))
    qng(function, a, b, epsabs: epsabs, epsrel: epsrel)
  end

  enum QAGKey
    GSL_INTEG_GAUSS15 = 1
    GSL_INTEG_GAUSS21 = 2
    GSL_INTEG_GAUSS31 = 3
    GSL_INTEG_GAUSS41 = 4
    GSL_INTEG_GAUSS51 = 5
    GSL_INTEG_GAUSS61 = 6
  end

  private class Workspace(T)
    @raw : Pointer(T)
    getter size : Int32

    private def lib_alloc(size) : Pointer(T)
      {% if T == LibGSL::Gsl_integration_workspace %}
        return LibGSL.gsl_integration_workspace_alloc(size)
      {% elsif T == LibGSL::Gsl_integration_cquad_workspace %}
        return LibGSL.gsl_integration_cquad_workspace_alloc(size)
      {% elsif T == LibGSL::Gsl_integration_romberg_workspace %}
        return LibGSL.gsl_integration_romberg_alloc(size)
      {% else %}
        {% raise "incorrect type #{T}" %}
      {% end %}
    end

    private def lib_free(ptr : Pointer(T))
      {% if T == LibGSL::Gsl_integration_workspace %}
        LibGSL.gsl_integration_workspace_free(ptr)
      {% elsif T == LibGSL::Gsl_integration_cquad_workspace %}
        LibGSL.gsl_integration_cquad_workspace_free(ptr)
      {% elsif T == LibGSL::Gsl_integration_romberg_workspace %}
        LibGSL.gsl_integration_romberg_free(ptr)
      {% else %}
        {% raise "incorrect type #{T}" %}
      {% end %}
    end

    def initialize
      @size = 0
      @raw = Pointer(T).null
    end

    def initialize(@size)
      @raw = lib_alloc(@size)
    end

    def resize(new_size)
      return if new_size <= size
      lib_free(@raw) unless size == 0
      @size = new_size
      @raw = lib_alloc(@size)
    end

    def free
      return if @size == 0
      @size = 0
      lib_free(@raw)
      @raw = Pointer(T).null
    end

    def to_unsafe
      @raw
    end
  end

  @@workspace = SimplePool(Workspace(LibGSL::Gsl_integration_workspace)).new(0)

  def self.qag(function : Proc(Float64, Float64), a : Float64, b : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, limit = 1000, key : QAGKey = QAGKey::GSL_INTEG_GAUSS61)
    @@workspace.use do |workspace|
      workspace.resize(limit)
      f = GSL.wrap_function(function)
      if epsabs.zero? && epsrel.zero?
        epsabs = 1e-9
      end
      code = LibGSL.gsl_integration_qag(pointerof(f), a, b, epsabs, epsrel, limit, key.to_i, workspace, out result, out abserr)
      GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_qag")
      return result, abserr
    end
  end

  def self.qags(function : Proc(Float64, Float64), a : Float64, b : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, limit = 1000)
    @@workspace.use do |workspace|
      workspace.resize(limit)
      f = GSL.wrap_function(function)
      if epsabs.zero? && epsrel.zero?
        epsabs = 1e-9
      end
      result = uninitialized Float64
      abserr = uninitialized Float64
      if a.finite? && b.finite?
        code = LibGSL.gsl_integration_qags(pointerof(f), a, b, epsabs, epsrel, limit, workspace, pointerof(result), pointerof(abserr))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_qags")
      elsif a.finite? && b > 0
        code = LibGSL.gsl_integration_qagiu(pointerof(f), a, epsabs, epsrel, limit, workspace, pointerof(result), pointerof(abserr))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_qagiu")
      elsif b.finite? && a < 0
        code = LibGSL.gsl_integration_qagil(pointerof(f), b, epsabs, epsrel, limit, workspace, pointerof(result), pointerof(abserr))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_qagil")
      elsif a < 0 && b > 0
        code = LibGSL.gsl_integration_qagi(pointerof(f), epsabs, epsrel, limit, workspace, pointerof(result), pointerof(abserr))
        GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_qagi")
      else
        raise ArgumentError.new("integration incorrect bounds: #{a}, #{b}")
      end
      return result, abserr
    end
  end

  def self.qagp(function : Proc(Float64, Float64), points, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, limit = 1000)
    @@workspace.use do |workspace|
      workspace.resize(limit)
      f = GSL.wrap_function(function)
      if epsabs.zero? && epsrel.zero?
        epsabs = 1e-9
      end
      code = LibGSL.gsl_integration_qagp(pointerof(f), points, points.size, epsabs, epsrel, limit, workspace, out result, out abserr)
      GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_qagp")
      return result, abserr
    end
  end

  def self.qawc(function : Proc(Float64, Float64), a : Float64, b : Float64, c : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, limit = 1000)
    @@workspace.use do |workspace|
      workspace.resize(limit)
      f = GSL.wrap_function(function)
      if epsabs.zero? && epsrel.zero?
        epsabs = 1e-9
      end
      code = LibGSL.gsl_integration_qawc(pointerof(f), a, b, c, epsabs, epsrel, limit, workspace, out result, out abserr)
      GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_qawc")
      return result, abserr
    end
  end

  @@cquad_workspace = SimplePool(Workspace(LibGSL::Gsl_integration_cquad_workspace)).new(0)

  def self.cquad(function : Proc(Float64, Float64), a : Float64, b : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, limit = 1000)
    @@cquad_workspace.use do |workspace|
      workspace.resize(limit)
      f = GSL.wrap_function(function)
      if epsabs.zero? && epsrel.zero?
        epsabs = 1e-9
      end
      code = LibGSL.gsl_integration_cquad(pointerof(f), a, b, epsabs, epsrel, workspace, out result, out abserr, out neval)
      GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_cquad")
      return result, abserr, neval
    end
  end

  @@romberg_workspace = SimplePool(Workspace(LibGSL::Gsl_integration_romberg_workspace)).new(0)

  def self.romberg(function : Proc(Float64, Float64), a : Float64, b : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, limit = 1000)
    @@romberg_workspace.use do |workspace|
      workspace.resize(limit)
      f = GSL.wrap_function(function)
      if epsabs.zero? && epsrel.zero?
        epsabs = 1e-9
      end
      code = LibGSL.gsl_integration_romberg(pointerof(f), a, b, epsabs, epsrel, out result, out neval, workspace)
      GSL.check_return_code(LibGSL::Code.new(code), "gsl_integration_romberg")
      return result, neval
    end
  end

  enum Algorithm
    QNG
    QAG_GAUSS15
    QAG_GAUSS21
    QAG_GAUSS31
    QAG_GAUSS41
    QAG_GAUSS51
    QAG_GAUSS61
    QAGS
    CQUAD
    ROMBERG
  end

  def self.integrate(function : Proc(Float64, Float64), a : Float64, b : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, limit = 1000, algorithm : Algorithm = Algorithm::CQUAD)
    algorithm = Algorithm::QAGS if a.infinite? || b.infinite?
    case algorithm
    in .qng?
      return qng(function, a, b, epsabs: epsabs, epsrel: epsrel)[0]
    in .qag_gauss15?
      return qag(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit, key: QAGKey::GSL_INTEG_GAUSS15)[0]
    in .qag_gauss21?
      return qag(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit, key: QAGKey::GSL_INTEG_GAUSS21)[0]
    in .qag_gauss31?
      return qag(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit, key: QAGKey::GSL_INTEG_GAUSS31)[0]
    in .qag_gauss41?
      return qag(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit, key: QAGKey::GSL_INTEG_GAUSS41)[0]
    in .qag_gauss51?
      return qag(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit, key: QAGKey::GSL_INTEG_GAUSS51)[0]
    in .qag_gauss61?
      return qag(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit, key: QAGKey::GSL_INTEG_GAUSS61)[0]
    in .qags?
      return qags(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit)[0]
    in .cquad?
      return cquad(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit)[0]
    in .romberg?
      return romberg(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit)[0]
    end
  end

  def self.integrate(a : Float64, b : Float64, *, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, limit = 1000, algorithm : Algorithm = Algorithm::CQUAD, &function : Proc(Float64, Float64))
    integrate(function, a, b, epsabs: epsabs, epsrel: epsrel, limit: limit, algorithm: algorithm)
  end
end
