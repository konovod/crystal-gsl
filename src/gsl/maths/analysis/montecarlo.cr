module GSL::MonteCarlo
  def self.integrate_plain(function : Proc(Slice(Float64), Float64), xl : Slice(Float64), xu : Slice(Float64), calls : Int32, random = Random::DEFAULT)
    raise ArgumentError.new("xl.size != xu.size (#{xl.size} != #{xu.size})") unless xl.size == xu.size
    dim = xl.size
    workspace = LibGSL.gsl_monte_plain_alloc(dim)
    rng = GSL.wrap_rng(random)
    f = GSL.wrap_function_monte(function, dim)
    LibGSL.gsl_monte_plain_integrate(pointerof(f), xl, xu, dim, calls, pointerof(rng), workspace, out result, out err)
    LibGSL.gsl_monte_plain_free(workspace)
    return result, err
  end

  record MiserParams,
    estimate_frac : Float64 = 0.1,
    min_calls : Int32? = nil,
    min_calls_per_bisection : Int32? = nil,
    alpha : Float64 = 2.0,
    dither : Float64 = 0.0 do
    def to_unsafe(dimensions = 1)
      min_calls = self.min_calls || 16*dimensions
      min_calls_per_bisection = self.min_calls_per_bisection || 32*min_calls
      LibGSL::Gsl_monte_miser_params.new(
        estimate_frac: estimate_frac,
        min_calls: min_calls,
        min_calls_per_bisection: min_calls_per_bisection,
        alpha: alpha,
        dither: dither)
    end
  end

  def self.integrate_miser(function : Proc(Slice(Float64), Float64), xl : Slice(Float64), xu : Slice(Float64), calls : Int32, random = Random::DEFAULT, params : MiserParams? = nil)
    raise ArgumentError.new("xl.size != xu.size (#{xl.size} != #{xu.size})") unless xl.size == xu.size
    dim = xl.size
    workspace = LibGSL.gsl_monte_miser_alloc(dim)
    rng = GSL.wrap_rng(random)
    f = GSL.wrap_function_monte(function, dim)
    if params
      aparams = params.to_unsafe(dim)
      LibGSL.gsl_monte_miser_params_set(workspace, pointerof(aparams))
    end
    LibGSL.gsl_monte_miser_integrate(pointerof(f), xl, xu, dim, calls, pointerof(rng), workspace, out result, out err)
    LibGSL.gsl_monte_miser_free(workspace)
    return result, err
  end

  # state->stage = 0;
  # state->alpha = 1.5;
  # state->verbose = -1;
  # state->iterations = 5;
  # state->mode = GSL_VEGAS_MODE_;
  # state->chisq = 0;

  enum VegasSampling
    Importance     =  1
    ImportanceOnly =  0
    Stratified     = -1
  end

  enum VegasStage
    NewRun      = 0
    KeepGrid    = 1
    KeepAverage = 2
    KeepAll     = 3
  end

  record VegasParams,
    alpha : Float64 = 1.5,
    iterations : Int32 = 5,
    stage : VegasStage = VegasStage::NewRun,
    sampling : VegasSampling = VegasSampling::Importance do
    def to_unsafe
      LibGSL::Gsl_monte_vegas_params.new(
        alpha: alpha,
        iterations: iterations,
        stage: stage.to_i,
        mode: sampling.to_i,
        verbose: -1,
        ostream: Pointer(LibGSL::File).null
      )
    end
  end

  def self.integrate_vegas(function : Proc(Slice(Float64), Float64), xl : Slice(Float64), xu : Slice(Float64), calls : Int32, random = Random::DEFAULT, params : VegasParams? = nil)
    raise ArgumentError.new("xl.size != xu.size (#{xl.size} != #{xu.size})") unless xl.size == xu.size
    dim = xl.size
    workspace = LibGSL.gsl_monte_vegas_alloc(dim)
    rng = GSL.wrap_rng(random)
    f = GSL.wrap_function_monte(function, dim)
    if params
      aparams = params.to_unsafe
      LibGSL.gsl_monte_vegas_params_set(workspace, pointerof(aparams))
    end
    LibGSL.gsl_monte_vegas_integrate(pointerof(f), xl, xu, dim, calls, pointerof(rng), workspace, out result, out err)
    LibGSL.gsl_monte_vegas_free(workspace)
    return result, err
  end

  enum Algorithm
    Plain
    Miser
    Vegas
  end

  def self.integrate(algorithm : Algorithm, function : Proc(Slice(Float64), Float64), xl : Slice(Float64), xu : Slice(Float64), calls : Int32, random = Random::DEFAULT)
    case algorithm
    in .plain?
      integrate_plain(function, xl, xu, calls, random)
    in .miser?
      integrate_miser(function, xl, xu, calls, random)
    in .vegas?
      integrate_vegas(function, xl, xu, calls, random)
    end
  end
end
