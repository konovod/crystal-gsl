describe GSL::Interpolate1D do
  it "should be created from x and y array" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.map { |v| Math.sin(v) }
    int = GSL::Interpolate1D.new(:steffen, x, y)
    int.size.should eq 10
    int.x.to_a.should eq x
    int.y.to_a.should eq y
  end

  it "should check size of arrays" do
    x = (1..10).to_a.map { |v| v / 10 }
    expect_raises(Exception) { GSL::Interpolate1D.new(:steffen, x, x[1..]) }
    expect_raises(Exception) { GSL::Interpolate1D.new(:akima, [1.0, 2.0, 3.0], [1.0, 2.0, 3.0]) }
    GSL::Interpolate1D.new(:linear, [1.0, 2.0, 3.0], [1.0, 2.0, 3.0])
  end

  it "should evaluate exact y at exact x" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.map { |v| Math.sin(v) }
    int = GSL::Interpolate1D.new(:steffen, x, y)
    int.eval(x[3]).should eq y[3]
  end

  it "should evaluate approximate y at given x" do
    x = (1..100).to_a.map { |v| v / 10 }
    y = x.map { |v| Math.sin(v) }
    int = GSL::Interpolate1D.new(:steffen, x, y)
    int.eval(Math::PI/2).should be_close 1.0, 1e-3
  end

  it "should raise when value is outside range" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.map { |v| Math.sin(v) }
    int = GSL::Interpolate1D.new(:steffen, x, y)
    expect_raises(GSL::Exception) { int.eval(-0.5) }
    expect_raises(GSL::Exception) { int.eval(20) }
  end

  it "should evaluate direvatives at given x" do
    x = (1..100).to_a.map { |v| v / 100 }
    y = x.map { |v| Math.sin(v) }
    int = GSL::Interpolate1D.new(:steffen, x, y)
    int.eval(0.3333, :first_derivative).should be_close Math.cos(0.3333), 1e-3
    int.eval(0.3333, :second_derivative).should be_close -Math.sin(0.3333), 1e-2
  end

  it "should evaluate direvatives on given range" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.map { |v| Math.sin(v) }
    int = GSL::Interpolate1D.new(:steffen, x, y)
    int.integrate(0.3333, 0.6667).should be_close (Math.cos(0.3333) - Math.cos(0.6667)), 1e-3
  end

  it "should find nearest x point" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.map { |v| Math.sin(v) }
    int = GSL::Interpolate1D.new(:steffen, x, y)
    int.x_index(0.45).should eq 3
    int.x_index(-1.45).should eq 0 # TODO - should it raise?
    # int.x_index(100) TODO - should it raise?
  end
end

describe GSL::Interpolate2D do
  it "should be created from x, y and z array" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.clone
    z = Slice(Float64).new(x.size*y.size, 0.0)
    x.each_with_index do |x_value, i|
      y.each_with_index do |y_value, j|
        z[j*x.size + i] = Math.cos(x_value) * Math.sin(y_value)
      end
    end
    int = GSL::Interpolate2D.new(GSL::Interpolate2D::Type::Bicubic, x, y, z)
    int.size.should eq({10, 10})
    int.x.to_a.should eq x
    int.y.to_a.should eq y
  end

  it "should check size of array" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.clone
    z = Slice(Float64).new(x.size*y.size - 1, 0.0)
    expect_raises(Exception) { GSL::Interpolate2D.new(GSL::Interpolate2D::Type::Bicubic, x, y, z) }

    z = Slice(Float64).new(x.size*y.size + 1, 0.0)
    expect_raises(Exception) { GSL::Interpolate2D.new(GSL::Interpolate2D::Type::Bicubic, x, y, z) }

    x = (1..10).to_a.map { |v| v / 10 }
    y = [1.0, 2.0, 3.0]
    z = Slice(Float64).new(x.size*y.size, 0.0)
    expect_raises(Exception) { GSL::Interpolate2D.new(GSL::Interpolate2D::Type::Bicubic, x, y, z) }
    GSL::Interpolate2D.new(GSL::Interpolate2D::Type::Bilinear, x, y, z)
  end

  it "should evaluate exact z at exact x, y" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.clone
    z = Slice(Float64).new(x.size*y.size, 0.0)
    x.each_with_index do |x_value, i|
      y.each_with_index do |y_value, j|
        z[j*x.size + i] = Math.cos(x_value) * Math.sin(y_value)
      end
    end
    int = GSL::Interpolate2D.new(GSL::Interpolate2D::Type::Bicubic, x, y, z)
    int.eval(0.3, 0.7).should eq Math.cos(0.3) * Math.sin(0.7)
  end
end
