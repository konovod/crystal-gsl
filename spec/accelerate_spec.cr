describe GSL::Sum do
  it "can extrapolate sum of series" do
    n = 20
    exact = Math::PI * Math::PI / 6.0
    v = (1..n).map { |i| 1 / (i*i) }
    result, err_est = GSL::Sum.accelerate(v)
    err_est.should be < 1e-9
    result.should be_close exact, err_est
  end
  it "can extrapolate sum of series without precise error estimate" do
    n = 20
    exact = Math::PI * Math::PI / 6.0
    v = (1..n).map { |i| 1 / (i*i) }
    result, err_est = GSL::Sum.accelerate_trunc(v)
    err_est.should be < 1e-9
    result.should be_close exact, err_est
  end
end
