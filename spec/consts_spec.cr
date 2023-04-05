require "./spec_helper"

describe GSL::Consts do
  p GSL::Consts::SPEED_OF_LIGHT

  it "has speed of light (mksa)" do
    c = GSL::Consts::SPEED_OF_LIGHT
    eps = GSL::Consts::VACUUM_PERMITTIVITY
    mu = GSL::Consts::VACUUM_PERMEABILITY
    c_eval = (1.0/Math.sqrt(eps*mu))
    c.should be_close(c_eval, 1e-6*c_eval)
  end

  it "has light year (cgsm)" do
    ly = GSL::Consts::CGSM::LIGHT_YEAR
    c = GSL::Consts::CGSM::SPEED_OF_LIGHT
    y = 365.2425 * GSL::Consts::CGSM::DAY
    ly_eval = c*y
    ly.should be_close(ly_eval, 1e-6*ly_eval)
  end

  it "has kilo (mega/kilo, 1/(micro*kilo))" do
    micro = GSL::Consts::MICRO
    mega = GSL::Consts::MEGA
    kilo = GSL::Consts::KILO
    (mega / kilo).should be_close(1/(micro*kilo), 1e-10)
  end

  it "has debye (esu)" do
    d = GSL::Consts::DEBYE
    c = GSL::Consts::SPEED_OF_LIGHT
    desu = d * c * 1000.0
    desu.should be_close(1e-18, 1e-28)
  end

  it "has stefan boltzmann constant" do
    k = GSL::Consts::BOLTZMANN
    c = GSL::Consts::SPEED_OF_LIGHT
    h = GSL::Consts::PLANCKS_CONSTANT_H
    sigma_eval = 2 * (Math::PI ** 5.0) * (k ** 4.0) / (15 * (c ** 2.0) * (h ** 3.0))
    sigma = GSL::Consts::STEFAN_BOLTZMANN_CONSTANT
    sigma.should be_close(sigma_eval, sigma_eval*1e-10)
  end
end
