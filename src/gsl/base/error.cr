module GSL
  class LengthException < ::Exception
  end

  class NonIdenticalHistograms < ::Exception
  end

  class Exception < ::Exception
  end

  protected def self.check_return_code(code : LibGSL::Code, function_name : String)
    unless code == LibGSL::Code::GSL_SUCCESS
      raise GSL::Exception.new("#{function_name} returned #{code}")
    end
  end

  class InternalException < ::Exception
    getter reason : String
    getter file : String
    getter line : Int32
    getter gsl_errno : LibGSL::Code

    def initialize(@reason, @file, @line, @gsl_errno)
      super("#{reason} at #{file}: #{line} (code is #{gsl_errno})")
    end
  end

  private def self.update_error_handler
    handler = ->(reason : LibC::Char*, file : LibC::Char*, line : LibC::Int, gsl_errno : LibC::Int) : Nil do
      raise GSL::InternalException.new(String.new(reason), String.new(file), line, LibGSL::Code.new(gsl_errno))
    end
    LibGSL.gsl_set_error_handler(handler)
  end

  update_error_handler
end
