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

  def self.integrate_miser(function : Proc(Slice(Float64), Float64), xl : Slice(Float64), xu : Slice(Float64), calls : Int32, random = Random::DEFAULT)
    raise ArgumentError.new("xl.size != xu.size (#{xl.size} != #{xu.size})") unless xl.size == xu.size
    dim = xl.size
    workspace = LibGSL.gsl_monte_miser_alloc(dim)
    rng = GSL.wrap_rng(random)
    f = GSL.wrap_function_monte(function, dim)
    LibGSL.gsl_monte_miser_integrate(pointerof(f), xl, xu, dim, calls, pointerof(rng), workspace, out result, out err)
    LibGSL.gsl_monte_miser_free(workspace)
    return result, err
  end

  def self.integrate_vegas(function : Proc(Slice(Float64), Float64), xl : Slice(Float64), xu : Slice(Float64), calls : Int32, random = Random::DEFAULT)
    raise ArgumentError.new("xl.size != xu.size (#{xl.size} != #{xu.size})") unless xl.size == xu.size
    dim = xl.size
    workspace = LibGSL.gsl_monte_vegas_alloc(dim)
    rng = GSL.wrap_rng(random)
    f = GSL.wrap_function_monte(function, dim)
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
