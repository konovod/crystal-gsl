require "./spec_helper"

describe GSL do
  describe "One Dimensional Minimization" do
    it "performs minimization using high-level interface" do
      result, xm, fm = GSL::Min.find_min(0, 6) do |x|
        Math.cos(x)
      end
      result.success?.should be_true
      xm.should be_close Math::PI, 1e-5
    end

    it "use guess parameter to avoid bracketing search" do
      _, xm, fm = GSL::Min.find_min(-2, 10, 1e-9, guess: -0.5) do |x|
        x**4
      end
      xm.should be_close 0.0, 1e-5
    end

    it "finds correct minimum even when middle of interval isn't lower than bounds" do
      _, xm, fm = GSL::Min.find_min(-2, 10, 1e-9, 0) do |x|
        x**4
      end
      xm.should be_close 0.0, 1e-5
    end

    it "have enough precision with guess from example" do
      _, xm, fm = GSL::Min.find_min(0, 6, 1e-6, guess: 2) do |x|
        Math.cos(x)
      end
      xm.should be_close Math::PI, 1e-6
    end

    it "works correctly when target function raises" do
      expect_raises(Exception) do
        GSL::Min.find_min(0, 6, 1e-6, guess: 2) do |x|
          raise Exception.new("incorrect value")
        end
      end
    end
  end
end
