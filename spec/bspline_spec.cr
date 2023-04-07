describe GSL::BSpline do
  it "should be initialized from a knots" do
    bspline = GSL::BSpline.new(4, [1, 2, 3, 4])
    bspline.size.should eq 6
    bspline.order.should eq 4
  end

  it "should be initialized from a uniform range" do
    bspline = GSL::BSpline.new(4, 10, 1..10)
    bspline.size.should eq 12
    bspline.order.should eq 4
  end

  it "should evaluate at point" do
    bspline = GSL::BSpline.new(4, 10, 1..10)
    bspline.eval(4.1).to_a.map(&.round(6)).should eq [0.0, 0.0, 0.0, 0.1215, 0.657167, 0.221167, 0.000167, 0.0, 0.0, 0.0, 0.0, 0.0]
  end

  pending "should evaluate nonzero values at point" do
    bspline = GSL::BSpline.new(4, 10, 1..10)
    v, istart, iend = bspline.eval_nonzero(4.1)
    v.to_a.map(&.round(6)).should eq [0.1215, 0.657167, 0.221167, 0.000167]
    istart.should eq 3
    iend.should eq 6
  end

  it "should evaluate derivatives at point" do
    bspline = GSL::BSpline.new(4, 10, 1..10)
    matrix = bspline.deriv(4.1, 3)
    matrix.ncols.should eq 4
    matrix.nrows.should eq 12
    matrix.row(1).to_a.should eq [0, 0, 0, 0]
    matrix.row(3).to_a.map(&.round(6)).should eq [0.1215, -0.405, 0.9, -1.0]
  end

  pending "should evaluate nonzero derivatives at point" do
    bspline = GSL::BSpline.new(4, 10, 1..10)
    matrix = bspline.deriv_nonzero(4.1, 3)
    matrix.ncols.should eq 4
    matrix.nrows.should eq 4
    matrix.row(0).to_a.map(&.round(6)).should eq [0.1215, -0.405, 0.9, -1.0]
  end

  it "should evaluate greville abscissa" do
    bspline = GSL::BSpline.new(4, 10, 1..10)
    bspline.greville_abscissa(0).should eq 1
    bspline.greville_abscissa(1).should be_close 1.33333, 1e-4
    bspline.greville_abscissa(2).should eq 2
  end
end
