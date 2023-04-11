describe GSL do
  it "should wrap Random to work with gsl functions" do
    rng1 = GSL.wrap_rng(Random::DEFAULT)
    rng2 = GSL.wrap_rng(Random::Secure)

    String.new(LibGSL.gsl_rng_name(pointerof(rng1))).should eq "Crystal Random wrapper"
    String.new(LibGSL.gsl_rng_name(pointerof(rng2))).should eq "Crystal Random wrapper"
    LibGSL.gsl_rng_uniform(pointerof(rng1)).should be_close 0.5, 0.5
    LibGSL.gsl_rng_uniform(pointerof(rng2)).should be_close 0.5, 0.5
    v1 = LibGSL.gsl_rng_uniform_int(pointerof(rng1), 10)
    (0...10).includes?(v1).should be_true
    v2 = LibGSL.gsl_rng_uniform_int(pointerof(rng2), 10)
    (0...10).includes?(v2).should be_true
  end
end
