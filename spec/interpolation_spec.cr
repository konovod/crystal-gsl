describe GSL::Interpolate1D do
  it "should be created from x and y array" do
    x = (1..10).to_a.map { |v| v / 10 }
    y = x.map { |v| Math.sin(v) }
    int = GSL::Interpolate1D.new(:steffen, x, y)
    int.size.should eq 10
    int.x.to_a.should eq x
    int.y.to_a.should eq y
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
