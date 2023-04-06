require "./spec_helper"

describe GSL do
  describe "functions defined with def_function" do
    it "must return the correct value" do
      x = GSL.lngamma(0.1)
      x.should eq 2.2527126517342047
      x = GSL.chi(-1)
      x.should eq 0.8378669409802082409
    end
  end

  describe "functions defined with def_function_with_mode" do
    it "must return the correct value" do
      x = GSL.airy_Ai(-500, precision: :approx)
      x.should be_close 0.0725901201040411396, 1e-7
      x = GSL.airy_Ai(-5)
      x.should be_close 0.3507610090241142, 1e-14
    end
  end

  describe "functions defined with def_function_with_args" do
    it "must return the correct value" do
      x = GSL.airy_zero_Ai(2)
      x.should eq -4.087949444130970617
      x = GSL.bessel_Jn(5, 2.0)
      x.should be_close 0.007039629755871685484, 1e-14
    end
  end

  describe "functions defined with def_function_complex" do
    it "must return the correct value" do
      x = GSL.dilog(0.5.i)
      x.should be_close Complex.new(-0.05897507442156586346, 0.48722235829452235710), 1e-14
    end
  end

  describe "functions defined with def_function_array" do
    it "must return the correct value" do
      x = GSL.bessel_Jn(3, 38, 1.0)
      x.size.should eq(38 - 3 + 1)
      x[0].should be_close 0.0195633539826684059190, 1e-14
      x[1].should be_close 0.0024766389641099550438, 1e-14
      x[10].should be_close 1.9256167644801728904e-14, 1e-24
      x[35].should be_close 6.911232970971626272e-57, 1e-64
    end
  end
end
