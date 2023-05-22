require "./spec_helper"

describe GSL do
  describe GSL::LinearRegression do
    it "should be created from two vectors" do
      x = Statistics.linspace(0, 10, 100)
      lin_reg = GSL::LinearRegression.new(x, x.map { |v| v*2 })
      lin_reg.c0.should eq 0
      lin_reg.c1.should eq 2.0
      expect_raises(ArgumentError) { GSL::LinearRegression.new(x, Statistics.linspace(0, 10, 101)) }
    end

    it "Support different types of arguments" do
      xa = [1.0, 2.0, 3.0, 4.0]
      xv = GSL::Vector.new(xa)
      xs = xa.to_unsafe.to_slice(xa.size)

      {xa, xs, xv}.each do |x1|
        {xa, xs, xv}.each do |x2|
          lin_reg = GSL::LinearRegression.new(x1, x2)
          lin_reg.c1.should eq 1.0
        end
      end
    end

    it "could be created with weighted inputs" do
      x = Statistics.linspace(0, 10, 100)
      y = x.map { |v| v*2 + 1 }
      w = Array.new(x.size, 1.0)
      w2 = w.clone
      y[2] = -20.0
      w2[2] = 0.01
      lin1 = GSL.linreg(x, y, w)
      lin2 = GSL.linreg(x, y, w2)
      y1, err1 = lin1.estimate(100.0)
      y2, err2 = lin2.estimate(100.0)
      y1.should be_close 201, 20
      y2.should be_close 201, 1
    end

    it "could be created with zero c0" do
      x = Statistics.linspace(0, 10, 100)
      y = x.map { |v| v*2 + 1 }
      lin1 = GSL.linreg(x, y)
      lin2 = GSL.linreg(x, y, no_const: true)
      y1, err1 = lin1.estimate(10.0)
      y2, err2 = lin2.estimate(10.0)
      y2.should be_close y1, 1.0
      err2.should be > err1
    end

    it "could be created with zero c0 and weighted inputs" do
      x = Statistics.linspace(0, 10, 100)
      y = x.map { |v| v*2 + 1 }
      lin1 = GSL.linreg(x, y, no_const: true)
      y[2] = 20.0
      w = Array.new(x.size, 1.0)
      w[2] = 100.0
      lin2 = GSL.linreg(x, y, w, no_const: true)
      y1, err1 = lin1.estimate(10.0)
      y2, err2 = lin2.estimate(10.0)
      y2.should be_close y1, 2.0
      err2.should be > err1
    end
  end
end
