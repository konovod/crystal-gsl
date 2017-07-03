require "./libgsl.cr"

module GSL
  class Permutation(T)
    include Iterator(Array(T))
    @n : Int32

    def initialize(@data : Array(T))
      @n = @data.size
      @permutation = LibGSL.permutation_calloc(@n)
    end

    def next
      if LibGSL.permutation_next(@permutation) == 0
        return (0...@n).map { |i|
          @data[LibGSL.permutation_get(@permutation, i)]
        }
      else
        stop
      end
    end

    def rewind
      @permutation = LibGSL.permutation_calloc(@n)
      self
    end

    def previous : Array(T)
      LibGSL.permutation_prev(@permutation)
      return (0...@n).map { |i|
        @data[LibGSL.permutation_get(@permutation, i)]
      }
    end
  end
end
