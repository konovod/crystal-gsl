require "./spec_helper"

describe GSL do
  describe "One Dimensional Minimization" do
    it "creates and frees minimizer" do
      fmin = GSL::Min::FMinimizer.new(GSL::Min::Type::GoldenSection)
      fmin.name.should eq "goldensection"
      fmin.free
    end

    it "performs minimization using low-level interface" do
      # example from https://www.gnu.org/software/gsl/doc/html/min.html
      fmin = GSL::Min::FMinimizer.new(GSL::Min::Type::Brent)
      max_iter = 100
      m = 2.0
      a = 0.0
      b = 6.0
      eps = 0.001
      fmin.setup(m, a, b) do |x|
        Math.cos(x) + 1.0
      end
      6.times { fmin.iterate }
      a = fmin.raw.value.x_lower
      b = fmin.raw.value.x_upper
      LibGSL.min_test_interval(a, b, eps, 0.0).should eq LibGSL::Code::GSL_SUCCESS.to_i
      a.should be_close Math::PI, eps
    end
  end
end
