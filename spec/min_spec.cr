require "./spec_helper"

describe GSL do
  describe "One Dimensional Minimization" do
    it "creates and free minimizer" do
      fmin = GSL::Min::FMinimizer.new(GSL::Min::Type::GoldenSection)
      fmin.free
    end
  end
end
