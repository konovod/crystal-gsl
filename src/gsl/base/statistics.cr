module Statistics
  def self.mean(data : Array(Float64)) : Float64
    return data.sum / data.size
  end

  def self.cumulative_sum(data : Array(Float64)) : Array(Float64)
    cumsum = data.clone
    (1..cumsum.size - 1).each { |i| cumsum[i] += cumsum[i - 1] }
    return cumsum
  end

  def self.normalise(data : Array(Float64)) : Array(Float64)
    sum = data.sum
    return data.map { |x| x / sum }
  end

  # returns an equally space interval starting from *s* and ending in *e* (inclusive)
  #
  # ```
  # linspace(1.0, 10.0, 10) # => [1.0, 2.0, 3.0, 4.0, 5.0, 6.0, 7.0, 8.0, 9.0, 10.0]
  # ```
  def self.linspace(s : Float64, e : Float64, num : Int) : Array(Float64)
    delta = (e - s)/(num - 1.0)
    return Array.new(num) { |i| s + i * delta }
  end
end
