module GSL::Stats
  def self.dir_2d(rng : Random? = nil, *, trig_method : Bool = true) : {Float64, Float64}
    if rng
      rng_value = GSL.wrap_rng(rng)
      rng = pointerof(rng_value)
    else
      rng = GSL::RNG
    end
    if trig_method
      LibGSL.gsl_ran_dir_2d_trig_method(rng, out ax, out ay)
      return {ax, ay}
    else
      LibGSL.gsl_ran_dir_2d(rng, out x, out y)
      return {x, y}
    end
  end

  def self.dir_3d(rng : Random? = nil) : {Float64, Float64, Float64}
    if rng
      rng_value = GSL.wrap_rng(rng)
      rng = pointerof(rng_value)
    else
      rng = GSL::RNG
    end
    LibGSL.gsl_ran_dir_3d(rng, out x, out y, out z)
    return {x, y, z}
  end

  def self.dir_nd(n : Int, *, cache : Array(Float64)? = nil, rng : Random? = nil) : Array(Float64)
    if rng
      rng_value = GSL.wrap_rng(rng)
      rng = pointerof(rng_value)
    else
      rng = GSL::RNG
    end
    results = if cache && cache.size >= n
                cache
              else
                Array(Float64).new(n, 0.0)
              end
    LibGSL.gsl_ran_dir_nd(rng, n, results)
    results
  end
end
