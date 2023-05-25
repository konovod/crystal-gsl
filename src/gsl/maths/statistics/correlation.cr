module GSL
  module Stats
    # computes the Pearson correlation coefficient between the datasets `vector1` and `vector2` which must both be of the same length.
    def self.correlation(vector1 : GSL::Vector, vector2 : GSL::Vector)
      raise "vectors must have same size (#{vector1.size} != #{vector2.size})" unless vector1.size == vector2.size
      LibGSL.gsl_stats_correlation(vector1.raw.data, vector1.raw.stride, vector2.raw.data, vector1.raw.stride, vector1.size)
    end

    # computes the  Spearman rank correlation coefficient between the datasets `vector1` and `vector2` which must both be of the same length.
    def self.spearman(vector1 : GSL::Vector, vector2 : GSL::Vector)
      raise "vectors must have same size (#{vector1.size} != #{vector2.size})" unless vector1.size == vector2.size
      n = vector1.size
      LibGSL.gsl_stats_spearman(vector1.raw.data, vector1.raw.stride, vector2.raw.data, vector1.raw.stride, n, Slice(Float64).new(n))
    end
  end
end
