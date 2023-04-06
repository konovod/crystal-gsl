describe GSL::Chebyshev do
  it "should be initialized from a function" do
    f = ->(x : Float64) { Math.sin(x) }
    cheb = GSL::Chebyshev.new(40, f, -Math::PI..Math::PI)

    cheb.range.should eq -Math::PI..Math::PI
    cheb.order.should eq 40
    cheb.size.should eq 41
    cheb.coeffs[0].should be_close 0.0, 1e-14
    cheb.coeffs[1].should be_close 5.69230686359506e-01, 1e-14
    cheb.coeffs[2].should be_close 0.0, 1e-14
    cheb.coeffs[3].should be_close -6.66916672405979e-01, 1e-14
    cheb.coeffs[4].should be_close 0.0, 1e-14
    cheb.coeffs[5].should be_close 1.04282368734237e-01, 1e-14
  end

  it "should evaluate values" do
    f = ->(x : Float64) { Math.sin(x) }
    cheb = GSL::Chebyshev.new(40, f, -Math::PI..Math::PI)
    x = 0.5
    cheb.eval(x).should be_close Math.sin(x), 1e-14
  end

  it "should evaluate values with error estimate" do
    f = ->(x : Float64) { x < 0.5 ? 1.0 : 2.0 }
    cheb = GSL::Chebyshev.new(40, f, 0.0..1.0)
    v, err = cheb.eval_err(0.25)
    v.should be_close(1.0, err)
  end

  it "should evaluate values with limited order" do
    f = ->(x : Float64) { Math.cos(x) }
    cheb = GSL::Chebyshev.new(40, f, -Math::PI..Math::PI)
    x = 0.5
    cheb.eval(x, order: 10).should be_close Math.cos(x), 1e-5
    v, err = cheb.eval_err(x, order: 10)
    v.should be_close(Math.cos(x), err)
  end

  it "should derivate to correct result" do
    f = ->(x : Float64) { Math.sin(x) }
    cheb = GSL::Chebyshev.new(40, f, 0.0..2*Math::PI)
    cheb_deriv = cheb.deriv
    cheb_deriv.range.should eq 0.0..2*Math::PI
    cheb_deriv.order.should eq 40
    x = 0.5
    cheb_deriv.eval(x).should be_close Math.cos(x), 1e-9
  end

  it "should integrate to correct result" do
    f = ->(x : Float64) { Math.sin(x) }
    cheb = GSL::Chebyshev.new(40, f, 0.0..2*Math::PI)
    cheb_integ = cheb.integrate
    cheb_integ.range.should eq 0.0..2*Math::PI
    cheb_integ.order.should eq 40
    x = 0.5
    cheb_integ.eval(x).should be_close 1 - Math.cos(x), 1e-9
  end
end
