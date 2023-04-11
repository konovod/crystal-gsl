def example_function(k : Slice(Float64))
  a = 1.0 / (Math::PI * Math::PI * Math::PI)
  return a / (1.0 - Math.cos(k[0]) * Math.cos(k[1]) * Math.cos(k[2]))
end

lower = Slice(Float64).new(3, 0.0)
upper = Slice(Float64).new(3, Math::PI)
exact = 1.3932039296856768591842462603255

describe GSL::MonteCarlo do
  describe "Plain" do
    it "should give correct result" do
      a = 1.0 / (Math::PI * Math::PI * Math::PI)
      f = ->(k : Slice(Float64)) { a / (1.0 - Math.cos(k[0]) * Math.cos(k[1]) * Math.cos(k[2])) }
      x, err = GSL::MonteCarlo.integrate_plain(f, lower, upper, 100000)
      err.should be < 1.0
      x.should be_close exact, err*5
    end
  end
  describe "Miser" do
    it "should give correct result" do
      a = 1.0 / (Math::PI * Math::PI * Math::PI)
      f = ->(k : Slice(Float64)) { a / (1.0 - Math.cos(k[0]) * Math.cos(k[1]) * Math.cos(k[2])) }
      x, err = GSL::MonteCarlo.integrate_miser(f, lower, upper, 100000)
      err.should be < 1.0
      x.should be_close exact, err*5
    end

    it "can be configured" do
      a = 1.0 / (Math::PI * Math::PI * Math::PI)
      f = ->(k : Slice(Float64)) { a / (1.0 - Math.cos(k[0]) * Math.cos(k[1]) * Math.cos(k[2])) }
      x, err = GSL::MonteCarlo.integrate_miser(f, lower, upper, 100000, params: GSL::MonteCarlo::MiserParams.new(alpha: 1.5, dither: 0.05, min_calls: 100))
      err.should be < 1.0
      x.should be_close exact, err*5
    end
  end
  describe "Vegas" do
    it "should give correct result" do
      a = 1.0 / (Math::PI * Math::PI * Math::PI)
      f = ->(k : Slice(Float64)) { a / (1.0 - Math.cos(k[0]) * Math.cos(k[1]) * Math.cos(k[2])) }
      x, err = GSL::MonteCarlo.integrate_vegas(f, lower, upper, 100000)
      err.should be < 1.0
      x.should be_close exact, err*10
    end

    it "can be configured" do
      a = 1.0 / (Math::PI * Math::PI * Math::PI)
      f = ->(k : Slice(Float64)) { a / (1.0 - Math.cos(k[0]) * Math.cos(k[1]) * Math.cos(k[2])) }
      params = GSL::MonteCarlo::VegasParams.new(alpha: 1.3, iterations: 10, sampling: :stratified)
      x, err = GSL::MonteCarlo.integrate_vegas(f, lower, upper, 100000, params: params)
      err.should be < 1.0
      x.should be_close exact, err*5
    end
  end
end
