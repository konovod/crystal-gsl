module GSL
  abstract class Object
    getter pointer

    def to_unsafe
      pointer
    end

    protected abstract def lib_free

    def free
      # to prevent second free (e.g. during finalize)
      return if @pointer.null?
      lib_free
      @pointer = typeof(@pointer).null
    end

    def finalize
      free
    end
  end
end
