record CartesianPos < GSL::Siman::Configuration, x : Float64 do
  # This function type should return the energy of a configuration:
  def energy : Float64
    Math.exp(-((@x - 1.0)**2.0))*Math.sin(8*@x)
  end

  def step(rng : Random, step_size : Float64) : CartesianPos
    delta = rng.rand
    CartesianPos.new(@x + delta*2*step_size - step_size)
  end

  # This function type should return the distance between two configurations xp and yp:
  def distance(other) : Float64
    (self.x - other.x).abs
  end
end

describe GSL::Siman do
  it "should find global minimum starting from local minimum (trivial case)" do
    params = GSL::Siman::Params.new(
      n_tries: 20,
      iters_fixed_t: 50,
      step_size: 1.0,
      k: 1.0,
      t_initial: 0.008,
      mu_t: 1.003,
      t_min: 2.0e-6
    )
    GSL::Siman.solve(CartesianPos.new(15.5), params, false).x.should be_close 1.36313, 1e-4
  end
end

# TODO - second, complex spec
