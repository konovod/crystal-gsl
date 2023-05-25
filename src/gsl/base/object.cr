module GSL
  # Basic class of high-level wrapping objects that holds pointers to GSL objects.
  # Must implement `#lib_free`
  abstract class Object
    # pointer to internal GSL object
    getter pointer

    # returns pointer for calling `LibGSL` functions
    def to_unsafe
      pointer
    end

    # This function must call corresponding gsl_*_free to free internal pointer
    protected abstract def lib_free

    # Manually free internal object. Sets `#pointer` to null to prevent second free
    def free
      # to prevent second free (e.g. during finalize)
      return if @pointer.null?
      lib_free
      @pointer = typeof(@pointer).null
    end

    # Called by GC. frees internal object if it wasnt' manually `#free`d before.
    def finalize
      free
    end
  end
end
