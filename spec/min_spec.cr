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
      fmin.test_interval(eps).should eq LibGSL::Code::GSL_SUCCESS
      fmin.x_minimum.should be_close Math::PI, eps
    end

    it "performs minimization using high-level interface" do
      xm, fm = GSL::Min.find_min(0, 6, 1e-6) do |x|
        Math.cos(x)
      end
      xm.should be_close Math::PI, 1e-6
    end

    it "use guess parameter to avoid bracketing search" do
      xm, fm = GSL::Min.find_min(-2, 10, 1e-6, guess: -0.5) do |x|
        x**4
      end
      xm.should be_close 0.0, 1e-6
    end

    it "finds correct minimum even when middle of interval isn't lower than bounds" do
      xm, fm = GSL::Min.find_min(-2, 10, 1e-6) do |x|
        x**4
      end
      xm.should be_close 0.0, 1e-6
    end
  end
end
