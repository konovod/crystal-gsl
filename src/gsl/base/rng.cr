module GSL
  private RNG_WRAPPER = LibGSL::Gsl_rng_type.new(
    name: "Crystal Random wrapper",
    max: UInt64::MAX,
    min: 0,
    size: sizeof(LibC::SizeT),
    set: ->(ptr : Void*, seed : LibC::ULong) {},
    get: ->(ptr : Void*) do
      v = ptr.as(Box(Random)).object.next_int
      pointerof(v).as(UInt32*).value
    end,
    get_double: ->(ptr : Void*) { ptr.as(Box(Random)).object.next_float }
  )

  def self.wrap_rng(random : Random) : LibGSL::Gsl_rng
    LibGSL::Gsl_rng.new(
      type: pointerof(RNG_WRAPPER),
      state: Box(Random).new(random).as(Void*)
    )
  end
end
