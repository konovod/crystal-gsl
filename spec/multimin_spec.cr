describe GSL do
  describe "MultiDimensional Minimization" do
    pending "finds minimum in simple example from GSL docs" do
      center = {1.0, 2.0}
      scale = {10.0, 20.0}
      height = 30.0

      result, min_x, min_f = GSL::MultiMin.find_min(initial: GSL::Vector.new([5.0, 7.0]), initial_step: 1.0, eps_abs: 1e-2, max_iter: 100) do |x|
        scale[0]*Math.sqr(x[0] - center[0]) + scale[1]*Math.sqr(x[1] - center[1]) + height
      end

      result.should eq GSL::Result::Success
      min_x.should eq GSL::Vector.new([1.0, 2.0])
      min_f.should eq 30.0
    end
    pending "finds minimum in simple example from GSL docs using derivatives information " do
      center = {1.0, 2.0}
      scale = {10.0, 20.0}
      height = 30.0

      result, min_x, min_f = GSL::MultiMin.find_min(initial: GSL::Vector.new([5.0, 7.0]), initial_step: 1.0, eps_abs: 1e-2, max_iter: 100) do |x, y, dy|
        if y
          y.value = scale[0]*Math.sqr(x[0] - center[0]) + scale[1]*Math.sqr(x[1] - center[1]) + height
        end
        if dy
          dy[0] = 2.0*scale[0]*(x[0] - center[0])
          dy[1] = 2.0*scale[1]*(x[1] - center[1])
        end
      end

      result.should eq GSL::Result::Success
      min_x.should eq GSL::Vector.new([1.0, 2.0])
      min_f.should eq 30.0
    end
  end
end
