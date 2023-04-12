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
      x, err = GSL::MonteCarlo.integrate_miser(f, lower, upper, 100000, alpha: 1.5, dither: 0.05, min_calls: 100)
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
      x, err = GSL::MonteCarlo.integrate_vegas(f, lower, upper, 100000, alpha: 1.3, iterations: 10, sampling: :stratified)
      err.should be < 1.0
      x.should be_close exact, err*5
    end

    it "can be run with control of convergence" do
      a = 1.0 / (Math::PI * Math::PI * Math::PI)
      f = ->(k : Slice(Float64)) { a / (1.0 - Math.cos(k[0]) * Math.cos(k[1]) * Math.cos(k[2])) }

      x, err = GSL::MonteCarlo.integrate_vegas(f, lower, upper, alpha: 1.3, iterations: 10, sampling: :stratified) do |v|
        # Warm up
        v.perform(1000)
        v.perform(10000, stage: :keep_average)
        v.params(alpha: 1.0)
        loop do
          v.perform(20000, iterations: 5)
          # printf "%6.3f, %6.3f, %6.3f\n", v.result, v.err_estimate, v.chisq
          break if (v.chisq - 1.0).abs < 0.5
        end
      end
      err.should be < 0.1
      x.should be_close exact, err*5
    end
  end
end
