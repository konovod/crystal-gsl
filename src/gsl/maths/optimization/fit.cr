require "../../base/*"

module GSL
  class LinearRegression
    getter c0 : Float64
    getter c1 : Float64
    getter cov00 : Float64
    getter cov01 : Float64
    getter cov11 : Float64
    getter sumsq : Float64

    def initialize(x, y, weight = nil, @no_const : Bool = false)
      @c0 = 0
      @c1 = 0
      @cov00 = 0
      @cov01 = 0
      @cov11 = 0
      @sumsq = 0
      x = GSL::Vector.new(unsafe_from: x) unless x.is_a? GSL::Vector
      y = GSL::Vector.new(unsafe_from: y) unless y.is_a? GSL::Vector
      raise ArgumentError.new("x and y must have same size (#{x.size} != #{y.size})") if x.size != y.size
      if weight
        weight = GSL::Vector.new(unsafe_from: weight) unless weight.is_a? GSL::Vector
        raise ArgumentError.new("x and weight must have same size (#{x.size} != #{weight.size})") if x.size != weight.size
        if @no_const
          LibGSL.gsl_fit_wmul(x.raw.data, x.raw.stride, weight.raw.data, weight.raw.stride, y.raw.data, y.raw.stride, x.size, pointerof(@c1), pointerof(@cov11), pointerof(@sumsq))
        else
          LibGSL.gsl_fit_wlinear(x.raw.data, x.raw.stride, weight.raw.data, weight.raw.stride, y.raw.data, y.raw.stride, x.size, pointerof(@c0),
            pointerof(@c1), pointerof(@cov00), pointerof(@cov01), pointerof(@cov11), pointerof(@sumsq))
        end
      else
        if no_const
          LibGSL.gsl_fit_mul(x.raw.data, x.raw.stride, y.raw.data, y.raw.stride, x.size, pointerof(@c1), pointerof(@cov11), pointerof(@sumsq))
        else
          LibGSL.gsl_fit_linear(x.raw.data, x.raw.stride, y.raw.data, y.raw.stride, x.size, pointerof(@c0),
            pointerof(@c1), pointerof(@cov00), pointerof(@cov01), pointerof(@cov11), pointerof(@sumsq))
        end
      end
    end

    def estimate(x : Float64)
      y = uninitialized Float64
      y_err = uninitialized Float64
      if @no_const
        LibGSL.gsl_fit_mul_est(x, @c1, @cov11, pointerof(y), pointerof(y_err))
      else
        LibGSL.gsl_fit_linear_est(x, @c0, @c1, @cov00, @cov01, @cov11, pointerof(y), pointerof(y_err))
      end
      return y, y_err
    end
  end

  def self.linreg(x, y, weight = nil, no_const : Bool = false)
    LinearRegression.new(x, y, weight, no_const)
  end
end
