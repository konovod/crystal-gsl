require "./spec_helper"

describe Statistics do
  describe "Binomial" do
    it "must return the correct number of elements" do
      samples = Statistics::Binomial.sample(100, 0.5, 1_u32)
      samples.size.should eq 100
    end

    it "must return samples within the number of trials" do
      samples = Statistics::Binomial.sample(100, 0.5, 1_u32)
      samples.all? { |x| x == 0 || x == 1 }.should eq true
    end
  end

  describe "ChiSquare" do
    it "must return the correct number of elements" do
      samples = Statistics::ChiSquare.sample(100, 5.0)
      samples.size.should eq 100
    end
  end

  describe "DiscreteUniform" do
    it "must be within the min and max" do
      uniforms = (1..1000).map { |i| Statistics::DiscreteUniform.sample(0, 1) }
      uniforms.all? { |x| x >= 0 && x <= 1 }.should eq true
    end

    it "has the expected number of samples" do
      uniforms = Statistics::DiscreteUniform.sample(1000, 0, 1)
      uniforms.size.should eq 1000
    end

    expect_raises(ArgumentError) do
      Statistics::DiscreteUniform.sample(1, 0)
    end
  end

  describe "Normal" do
    it "has the expected number of samples" do
      normal = Statistics::Normal.new 0.0, 1.0
      n = 100
      samples = normal.sample(n)
      samples.size.should eq n
    end

    it "has the expected mean" do
      normal = Statistics::Normal.new 0.0, 1.0
      n = 100000
      samples = normal.sample(n)
      mean = Statistics.mean(samples)
      mean.should be_close(0.0, 1e-2)
    end
  end

  describe "Poisson" do
    it "should have the correct mean" do
      samples = Statistics::Poisson.sample(1000000, 2.3)
      mean = Statistics.mean(samples.map { |sample| sample.to_f })
      mean.should be_close(2.3, 1e-2)
    end
  end

  describe "Uniform" do
    it "should return an array of the correct dimension" do
      xs = Statistics::Uniform.sample(100, 0.0, 1.0)
      xs.size.should eq 100
    end

    it "should be within support" do
      xs = Statistics::Uniform.sample(100, 0.0, 1.0)
      xs.all? { |x| x > 0.0 && x < 1.0 }.should eq true
    end
  end

  describe "InverseGamma" do
    it "should return the correct pdf" do
      pdf = Statistics::InverseGamma.pdf(10.0, 2.0, 2.0)
      pdf.should eq 0.0032749230123119252
    end

    it "should return the correct log-pdf" do
      pdf = Statistics::InverseGamma.log_pdf(10.0, 2.0, 2.0)
      pdf.should eq -5.7214609178622471
    end
  end

  describe "Cauchy" do
    it "has the expected number of samples" do
      cauchy = Statistics::Cauchy.new 1.0
      n = 100
      samples = cauchy.sample(n)
      samples.size.should eq n
    end

    it "should return correct cdf and pdf" do
      cauchy = Statistics::Cauchy.new 1.0
      cauchy.cdf(0.0).should eq 0.5
      cauchy.pdf(0.0).should be_close 1/Math::PI, 1e-9
    end

    it "should support sampling using given rng" do
      cauchy = Statistics::Cauchy.new 1.0
      rng1 = Random::PCG32.new(1u64)
      rng2 = Random::PCG32.new(1u64)
      Statistics::Cauchy.sample(1.0, rng1).should eq cauchy.sample(rng2)
      Statistics::Cauchy.sample(1.0).should_not eq cauchy.sample(rng2)
    end
  end

  describe "Linear space" do
    it "should return the correct size" do
      items = 10
      l = Statistics.linspace(1.0, 10.0, items)
      l.size.should eq items
    end
  end

  describe "correlation" do
    it "should perform pearson correlation" do
      GSL::Stats.correlation([1, 2, 3, 4, 5].to_vector, [2, 3, 4, 99, 6].to_vector).round(2).should eq 0.39
    end

    it "should return the ranked vector" do
      a = [4, 4, 2, 3, 5, 2, 1].to_vector
      a.ranked.should eq(GSL::Vector.new [7.0, 4.5, 4.0, 1.5, 5.0])
    end

    it "should perform spearman correlation" do
      GSL::Stats.spearman([1, 2, 3, 4, 5].to_vector, [2, 3, 4, 99, 6].to_vector).round(2).should eq 0.9
    end
  end
end
