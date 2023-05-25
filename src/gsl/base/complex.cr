require "complex"

struct Complex
  # Casts `Complex` to `LibGSL::Gsl_complex`
  def to_gsl
    self.unsafe_as(LibGSL::Gsl_complex)
  end

  # Casts `LibGSL::Gsl_complex` to `Complex`
  def self.from_gsl(gsl : LibGSL::Gsl_complex)
    gsl.unsafe_as(self)
  end
end
