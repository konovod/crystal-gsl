module GSL
  alias Function = (Float64 -> Float64)

  def self.wrap_function(object, &function : (Float64, Void* -> Float64))
    result = uninitialized LibGSL::Function
    result.function = function
    result.params = object.as(Void*)
    result
  end
end
