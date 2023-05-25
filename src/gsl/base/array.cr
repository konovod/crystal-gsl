class Array(T)
  # Returns GSL::Vector with same data.
  # Elements are converted to Float64 if needed.
  def to_vector
    {% if T == Float64 %}
      GSL::Vector.new self
    {% else %}
      GSL::Vector.new self.map { |x| x.to_f }
    {% end %}
  end

  # Builds GSL::DenseMatrix from array of arrays (row-major order).
  def to_matrix
    row = self.size
    column = self.first.size
    temp = GSL::DenseMatrix.new row, column
    self.each_with_index do |x, ind|
      x.each_with_index do |y, index|
        temp[ind, index] = y.to_f
      end
    end
    temp
  end
end
