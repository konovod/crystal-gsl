require "./spec_helper"

describe GSL do
  describe "MultiDimensional Root Finding" do
    it "finds root in simple example from GSL docs" do
      a = 1.0
      b = 10.0
      result, root_value = GSL::MultiRoot.find_root(initial: GSL::Vector.new([-10.0, -5.0]), eps_f: 1e-7, max_iter: 1000) do |x, y|
        y[0] = a * (1 - x[0])
        y[1] = b * (x[1] - x[0] * x[0])
        pp! x, y
      end
      result.should eq GSL::Result::Success
      root_value.should eq GSL::Vector.new([1.0, 1.0])
    end

    it "finds root in simple example from GSL docs using derivatives information" do
      a = 1.0
      b = 10.0
      result, root_value = GSL::MultiRoot.find_root_fdf(initial: GSL::Vector.new([-10.0, -5.0]), eps_f: 1e-7, max_iter: 1000) do |x, y, j|
        if y
          y[0] = a * (1 - x[0])
          y[1] = b * (x[1] - x[0] * x[0])
        end
        if j
          j[0, 0] = -a
          j[0, 1] = 0
          j[1, 0] = -2 * b * x[0]
          j[1, 1] = b
        end
      end
      result.should eq GSL::Result::Success
      root_value.should eq GSL::Vector.new([1.0, 1.0])
    end
  end
end
