# This module implements [Series Acceleration using the Levin u-transform](https://www.gnu.org/software/gsl/doc/html/sum.html)
#
# Usage example:
# ```
# n = 20
# exact = Math::PI * Math::PI / 6.0
# v = (1..n).map { |i| 1 / (i*i) }
# result, err_est = GSL::Sum.accelerate(v)
# puts "exact value is #{exact}"
# puts "sum of #{n} members is #{v.sum} (error #{v.sum - exact})"
# puts "accelerated sum #{result} (estimated error #{err_est}, actual error #{result - exact})"
# ```
module GSL::Sum
  # Extrapolate sum of values with precise error estimate.
  #
  # Returns sum and error estimate
  #
  # Precise error estimation is a O(N^2) process.
  #
  # `values` could be a Slice(Float64) or Array(Float64)
  #
  def self.accelerate(values)
    w = LibGSL.gsl_sum_levin_u_alloc(values.size)
    LibGSL.gsl_sum_levin_u_accel(values, values.size, w, out sum, out abserr)
    LibGSL.gsl_sum_levin_u_free(w)
    return sum, abserr
  end

  # Extrapolate sum of values without precise error estimate.
  #
  # Returns sum and error estimate
  #
  # `values` could be a Slice(Float64) or Array(Float64)
  #
  def self.accelerate_trunc(values)
    w = LibGSL.gsl_sum_levin_utrunc_alloc(values.size)
    LibGSL.gsl_sum_levin_utrunc_accel(values, values.size, w, out sum, out abserr)
    LibGSL.gsl_sum_levin_utrunc_free(w)
    return sum, abserr
  end
end
