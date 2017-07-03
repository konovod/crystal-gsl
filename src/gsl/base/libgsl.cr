@[Link("gsl")]
@[Link("cblas")]
lib LibGSL
  # GSL codes
  enum Code
    GSL_SUCCESS  =  0
    GSL_FAILURE  = -1
    GSL_CONTINUE = -2 # iteration has not converged
    GSL_EDOM     =  1 # input domain error, e.g sqrt(-1)
    GSL_ERANGE   =  2 # output range error, e.g. exp(1e100)
    GSL_EFAULT   =  3 # invalid pointer
    GSL_EINVAL   =  4 # invalid argument supplied by user
    GSL_EFAILED  =  5 # generic failure
    GSL_EFACTOR  =  6 # factorization failed
    GSL_ESANITY  =  7 # sanity check failed - shouldn't happen
    GSL_ENOMEM   =  8 # malloc failed
    GSL_EBADFUNC =  9 # problem with user-supplied function
    GSL_ERUNAWAY = 10 # iterative process is out of control
    GSL_EMAXITER = 11 # exceeded max number of iterations
    GSL_EZERODIV = 12 # tried to divide by zero
    GSL_EBADTOL  = 13 # user specified an invalid tolerance
    GSL_ETOL     = 14 # failed to reach the specified tolerance
    GSL_EUNDRFLW = 15 # underflow
    GSL_EOVRFLW  = 16 # overflow
    GSL_ELOSS    = 17 # loss of accuracy
    GSL_EROUND   = 18 # failed because of roundoff error
    GSL_EBADLEN  = 19 # matrix, vector lengths are not conformant
    GSL_ENOTSQR  = 20 # matrix not square
    GSL_ESING    = 21 # apparent singularity detected
    GSL_EDIVERGE = 22 # integral or series is divergent
    GSL_EUNSUP   = 23 # requested feature is not supported by the hardware
    GSL_EUNIMPL  = 24 # requested feature not (yet) implemented
    GSL_ECACHE   = 25 # cache table limit exceeded
    GSL_ENOPROG  = 26 # iteration is not making progress towards solution
    GSL_ENOPROGJ = 27 # jacobian evaluations are not improving the solution
  end

  fun error = gsl_error(reason : LibC::Char*, file : LibC::Char*, line : LibC::Int, errno : LibC::Int)
  fun stream_printf = gsl_stream_printf(label : LibC::Char*, file : LibC::Char*, line : LibC::Int, reason : LibC::Char*)
  fun strerror = gsl_strerror(errno : LibC::Int) : LibC::Char*
  fun set_error_handler = gsl_set_error_handler(new_handler : (LibC::Char*, LibC::Char*, LibC::Int, LibC::Int -> Void)) : (LibC::Char*, LibC::Char*, LibC::Int, LibC::Int -> Void)
  fun set_error_handler_off = gsl_set_error_handler_off : (LibC::Char*, LibC::Char*, LibC::Int, LibC::Int -> Void)
  fun set_stream_handler = gsl_set_stream_handler(new_handler : (LibC::Char*, LibC::Char*, LibC::Int, LibC::Char* -> Void)) : (LibC::Char*, LibC::Char*, LibC::Int, LibC::Char* -> Void)
  fun set_stream = gsl_set_stream(new_stream : File*) : File*

  struct X_IoFile
    _flags : LibC::Int
    _io_read_ptr : LibC::Char*
    _io_read_end : LibC::Char*
    _io_read_base : LibC::Char*
    _io_write_base : LibC::Char*
    _io_write_ptr : LibC::Char*
    _io_write_end : LibC::Char*
    _io_buf_base : LibC::Char*
    _io_buf_end : LibC::Char*
    _io_save_base : LibC::Char*
    _io_backup_base : LibC::Char*
    _io_save_end : LibC::Char*
    _markers : X_IoMarker*
    _chain : X_IoFile*
    _fileno : LibC::Int
    _flags2 : LibC::Int
    _old_offset : X__OffT
    _cur_column : LibC::UShort
    _vtable_offset : LibC::Char
    _shortbuf : LibC::Char[1]
    _lock : X_IoLockT*
    _offset : X__Off64T
    __pad1 : Void*
    __pad2 : Void*
    __pad3 : Void*
    __pad4 : Void*
    __pad5 : LibC::SizeT
    _mode : LibC::Int
    _unused2 : LibC::Char[28]
  end

  type File = X_IoFile

  struct X_IoMarker
    _next : X_IoMarker*
    _sbuf : X_IoFile*
    _pos : LibC::Int
  end

  alias X__OffT = LibC::Long
  alias X_IoLockT = Void
  alias X__Off64T = LibC::Long

  # struct BlockLongDoubleStruct
  #   size : LibC::SizeT
  #   data : LibC::LongDouble*
  # end
  #
  # fun block_long_double_alloc = gsl_block_long_double_alloc(n : LibC::SizeT) : BlockLongDouble*
  # type BlockLongDouble = BlockLongDoubleStruct
  # fun block_long_double_calloc = gsl_block_long_double_calloc(n : LibC::SizeT) : BlockLongDouble*
  # fun block_long_double_free = gsl_block_long_double_free(b : BlockLongDouble*)
  # fun block_long_double_fread = gsl_block_long_double_fread(stream : File*, b : BlockLongDouble*) : LibC::Int
  # fun block_long_double_fwrite = gsl_block_long_double_fwrite(stream : File*, b : BlockLongDouble*) : LibC::Int
  # fun block_long_double_fscanf = gsl_block_long_double_fscanf(stream : File*, b : BlockLongDouble*) : LibC::Int
  # fun block_long_double_fprintf = gsl_block_long_double_fprintf(stream : File*, b : BlockLongDouble*, format : LibC::Char*) : LibC::Int
  # fun block_long_double_raw_fread = gsl_block_long_double_raw_fread(stream : File*, b : LibC::LongDouble*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  # fun block_long_double_raw_fwrite = gsl_block_long_double_raw_fwrite(stream : File*, b : LibC::LongDouble*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  # fun block_long_double_raw_fscanf = gsl_block_long_double_raw_fscanf(stream : File*, b : LibC::LongDouble*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  # fun block_long_double_raw_fprintf = gsl_block_long_double_raw_fprintf(stream : File*, b : LibC::LongDouble*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  # fun block_long_double_size = gsl_block_long_double_size(b : BlockLongDouble*) : LibC::SizeT
  # fun block_long_double_data = gsl_block_long_double_data(b : BlockLongDouble*) : LibC::LongDouble*
  # fun vector_long_double_alloc = gsl_vector_long_double_alloc(n : LibC::SizeT) : VectorLongDouble*
  #
  # struct VectorLongDouble
  #   size : LibC::SizeT
  #   stride : LibC::SizeT
  #   data : LibC::LongDouble*
  #   block : BlockLongDouble*
  #   owner : LibC::Int
  # end
  #
  # fun vector_long_double_calloc = gsl_vector_long_double_calloc(n : LibC::SizeT) : VectorLongDouble*
  # fun vector_long_double_alloc_from_block = gsl_vector_long_double_alloc_from_block(b : BlockLongDouble*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorLongDouble*
  # fun vector_long_double_alloc_from_vector = gsl_vector_long_double_alloc_from_vector(v : VectorLongDouble*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorLongDouble*
  # fun vector_long_double_free = gsl_vector_long_double_free(v : VectorLongDouble*)
  # fun vector_long_double_view_array = gsl_vector_long_double_view_array(v : LibC::LongDouble*, n : LibC::SizeT) : X_GslVectorLongDoubleView
  #
  # struct X_GslVectorLongDoubleView
  #   vector : VectorLongDouble
  # end
  #
  # fun vector_long_double_view_array_with_stride = gsl_vector_long_double_view_array_with_stride(base : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun vector_long_double_const_view_array = gsl_vector_long_double_const_view_array(v : LibC::LongDouble*, n : LibC::SizeT) : X_GslVectorLongDoubleConstView
  #
  # struct X_GslVectorLongDoubleConstView
  #   vector : VectorLongDouble
  # end
  #
  # fun vector_long_double_const_view_array_with_stride = gsl_vector_long_double_const_view_array_with_stride(base : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun vector_long_double_subvector = gsl_vector_long_double_subvector(v : VectorLongDouble*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun vector_long_double_subvector_with_stride = gsl_vector_long_double_subvector_with_stride(v : VectorLongDouble*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun vector_long_double_const_subvector = gsl_vector_long_double_const_subvector(v : VectorLongDouble*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun vector_long_double_const_subvector_with_stride = gsl_vector_long_double_const_subvector_with_stride(v : VectorLongDouble*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun vector_long_double_set_zero = gsl_vector_long_double_set_zero(v : VectorLongDouble*)
  # fun vector_long_double_set_all = gsl_vector_long_double_set_all(v : VectorLongDouble*, x : LibC::LongDouble)
  # fun vector_long_double_set_basis = gsl_vector_long_double_set_basis(v : VectorLongDouble*, i : LibC::SizeT) : LibC::Int
  # fun vector_long_double_fread = gsl_vector_long_double_fread(stream : File*, v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_fwrite = gsl_vector_long_double_fwrite(stream : File*, v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_fscanf = gsl_vector_long_double_fscanf(stream : File*, v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_fprintf = gsl_vector_long_double_fprintf(stream : File*, v : VectorLongDouble*, format : LibC::Char*) : LibC::Int
  # fun vector_long_double_memcpy = gsl_vector_long_double_memcpy(dest : VectorLongDouble*, src : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_reverse = gsl_vector_long_double_reverse(v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_swap = gsl_vector_long_double_swap(v : VectorLongDouble*, w : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_swap_elements = gsl_vector_long_double_swap_elements(v : VectorLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  # fun vector_long_double_max = gsl_vector_long_double_max(v : VectorLongDouble*) : LibC::LongDouble
  # fun vector_long_double_min = gsl_vector_long_double_min(v : VectorLongDouble*) : LibC::LongDouble
  # fun vector_long_double_minmax = gsl_vector_long_double_minmax(v : VectorLongDouble*, min_out : LibC::LongDouble*, max_out : LibC::LongDouble*)
  # fun vector_long_double_max_index = gsl_vector_long_double_max_index(v : VectorLongDouble*) : LibC::SizeT
  # fun vector_long_double_min_index = gsl_vector_long_double_min_index(v : VectorLongDouble*) : LibC::SizeT
  # fun vector_long_double_minmax_index = gsl_vector_long_double_minmax_index(v : VectorLongDouble*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  # fun vector_long_double_add = gsl_vector_long_double_add(a : VectorLongDouble*, b : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_sub = gsl_vector_long_double_sub(a : VectorLongDouble*, b : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_mul = gsl_vector_long_double_mul(a : VectorLongDouble*, b : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_div = gsl_vector_long_double_div(a : VectorLongDouble*, b : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_scale = gsl_vector_long_double_scale(a : VectorLongDouble*, x : LibC::Double) : LibC::Int
  # fun vector_long_double_add_constant = gsl_vector_long_double_add_constant(a : VectorLongDouble*, x : LibC::Double) : LibC::Int
  # fun vector_long_double_equal = gsl_vector_long_double_equal(u : VectorLongDouble*, v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_isnull = gsl_vector_long_double_isnull(v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_ispos = gsl_vector_long_double_ispos(v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_isneg = gsl_vector_long_double_isneg(v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_isnonneg = gsl_vector_long_double_isnonneg(v : VectorLongDouble*) : LibC::Int
  # fun vector_long_double_get = gsl_vector_long_double_get(v : VectorLongDouble*, i : LibC::SizeT) : LibC::LongDouble
  # fun vector_long_double_set = gsl_vector_long_double_set(v : VectorLongDouble*, i : LibC::SizeT, x : LibC::LongDouble)
  # fun vector_long_double_ptr = gsl_vector_long_double_ptr(v : VectorLongDouble*, i : LibC::SizeT) : LibC::LongDouble*
  # fun vector_long_double_const_ptr = gsl_vector_long_double_const_ptr(v : VectorLongDouble*, i : LibC::SizeT) : LibC::LongDouble*
  #
  # struct BlockComplexLongDoubleStruct
  #   size : LibC::SizeT
  #   data : LibC::LongDouble*
  # end
  #
  # fun block_complex_long_double_alloc = gsl_block_complex_long_double_alloc(n : LibC::SizeT) : BlockComplexLongDouble*
  # type BlockComplexLongDouble = BlockComplexLongDoubleStruct
  # fun block_complex_long_double_calloc = gsl_block_complex_long_double_calloc(n : LibC::SizeT) : BlockComplexLongDouble*
  # fun block_complex_long_double_free = gsl_block_complex_long_double_free(b : BlockComplexLongDouble*)
  # fun block_complex_long_double_fread = gsl_block_complex_long_double_fread(stream : File*, b : BlockComplexLongDouble*) : LibC::Int
  # fun block_complex_long_double_fwrite = gsl_block_complex_long_double_fwrite(stream : File*, b : BlockComplexLongDouble*) : LibC::Int
  # fun block_complex_long_double_fscanf = gsl_block_complex_long_double_fscanf(stream : File*, b : BlockComplexLongDouble*) : LibC::Int
  # fun block_complex_long_double_fprintf = gsl_block_complex_long_double_fprintf(stream : File*, b : BlockComplexLongDouble*, format : LibC::Char*) : LibC::Int
  # fun block_complex_long_double_raw_fread = gsl_block_complex_long_double_raw_fread(stream : File*, b : LibC::LongDouble*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  # fun block_complex_long_double_raw_fwrite = gsl_block_complex_long_double_raw_fwrite(stream : File*, b : LibC::LongDouble*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  # fun block_complex_long_double_raw_fscanf = gsl_block_complex_long_double_raw_fscanf(stream : File*, b : LibC::LongDouble*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  # fun block_complex_long_double_raw_fprintf = gsl_block_complex_long_double_raw_fprintf(stream : File*, b : LibC::LongDouble*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  # fun block_complex_long_double_size = gsl_block_complex_long_double_size(b : BlockComplexLongDouble*) : LibC::SizeT
  # fun block_complex_long_double_data = gsl_block_complex_long_double_data(b : BlockComplexLongDouble*) : LibC::LongDouble*
  # fun vector_complex_long_double_alloc = gsl_vector_complex_long_double_alloc(n : LibC::SizeT) : VectorComplexLongDouble*
  #
  # struct VectorComplexLongDouble
  #   size : LibC::SizeT
  #   stride : LibC::SizeT
  #   data : LibC::LongDouble*
  #   block : BlockComplexLongDouble*
  #   owner : LibC::Int
  # end
  #
  # fun vector_complex_long_double_calloc = gsl_vector_complex_long_double_calloc(n : LibC::SizeT) : VectorComplexLongDouble*
  # fun vector_complex_long_double_alloc_from_block = gsl_vector_complex_long_double_alloc_from_block(b : BlockComplexLongDouble*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorComplexLongDouble*
  # fun vector_complex_long_double_alloc_from_vector = gsl_vector_complex_long_double_alloc_from_vector(v : VectorComplexLongDouble*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorComplexLongDouble*
  # fun vector_complex_long_double_free = gsl_vector_complex_long_double_free(v : VectorComplexLongDouble*)
  # fun vector_complex_long_double_view_array = gsl_vector_complex_long_double_view_array(base : LibC::LongDouble*, n : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  #
  # struct X_GslVectorComplexLongDoubleView
  #   vector : VectorComplexLongDouble
  # end
  #
  # fun vector_complex_long_double_view_array_with_stride = gsl_vector_complex_long_double_view_array_with_stride(base : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun vector_complex_long_double_const_view_array = gsl_vector_complex_long_double_const_view_array(base : LibC::LongDouble*, n : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  #
  # struct X_GslVectorComplexLongDoubleConstView
  #   vector : VectorComplexLongDouble
  # end
  #
  # fun vector_complex_long_double_const_view_array_with_stride = gsl_vector_complex_long_double_const_view_array_with_stride(base : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun vector_complex_long_double_subvector = gsl_vector_complex_long_double_subvector(base : VectorComplexLongDouble*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun vector_complex_long_double_subvector_with_stride = gsl_vector_complex_long_double_subvector_with_stride(v : VectorComplexLongDouble*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun vector_complex_long_double_const_subvector = gsl_vector_complex_long_double_const_subvector(base : VectorComplexLongDouble*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun vector_complex_long_double_const_subvector_with_stride = gsl_vector_complex_long_double_const_subvector_with_stride(v : VectorComplexLongDouble*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun vector_complex_long_double_real = gsl_vector_complex_long_double_real(v : VectorComplexLongDouble*) : X_GslVectorLongDoubleView
  # fun vector_complex_long_double_imag = gsl_vector_complex_long_double_imag(v : VectorComplexLongDouble*) : X_GslVectorLongDoubleView
  # fun vector_complex_long_double_const_real = gsl_vector_complex_long_double_const_real(v : VectorComplexLongDouble*) : X_GslVectorLongDoubleConstView
  # fun vector_complex_long_double_const_imag = gsl_vector_complex_long_double_const_imag(v : VectorComplexLongDouble*) : X_GslVectorLongDoubleConstView
  # fun vector_complex_long_double_set_zero = gsl_vector_complex_long_double_set_zero(v : VectorComplexLongDouble*)
  # fun vector_complex_long_double_set_all = gsl_vector_complex_long_double_set_all(v : VectorComplexLongDouble*, z : ComplexLongDouble)
  #
  # struct ComplexLongDouble
  #   dat : LibC::LongDouble[2]
  # end
  #
  # fun vector_complex_long_double_set_basis = gsl_vector_complex_long_double_set_basis(v : VectorComplexLongDouble*, i : LibC::SizeT) : LibC::Int
  # fun vector_complex_long_double_fread = gsl_vector_complex_long_double_fread(stream : File*, v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_fwrite = gsl_vector_complex_long_double_fwrite(stream : File*, v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_fscanf = gsl_vector_complex_long_double_fscanf(stream : File*, v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_fprintf = gsl_vector_complex_long_double_fprintf(stream : File*, v : VectorComplexLongDouble*, format : LibC::Char*) : LibC::Int
  # fun vector_complex_long_double_memcpy = gsl_vector_complex_long_double_memcpy(dest : VectorComplexLongDouble*, src : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_reverse = gsl_vector_complex_long_double_reverse(v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_swap = gsl_vector_complex_long_double_swap(v : VectorComplexLongDouble*, w : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_swap_elements = gsl_vector_complex_long_double_swap_elements(v : VectorComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  # fun vector_complex_long_double_equal = gsl_vector_complex_long_double_equal(u : VectorComplexLongDouble*, v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_isnull = gsl_vector_complex_long_double_isnull(v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_ispos = gsl_vector_complex_long_double_ispos(v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_isneg = gsl_vector_complex_long_double_isneg(v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_isnonneg = gsl_vector_complex_long_double_isnonneg(v : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_add = gsl_vector_complex_long_double_add(a : VectorComplexLongDouble*, b : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_sub = gsl_vector_complex_long_double_sub(a : VectorComplexLongDouble*, b : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_mul = gsl_vector_complex_long_double_mul(a : VectorComplexLongDouble*, b : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_div = gsl_vector_complex_long_double_div(a : VectorComplexLongDouble*, b : VectorComplexLongDouble*) : LibC::Int
  # fun vector_complex_long_double_scale = gsl_vector_complex_long_double_scale(a : VectorComplexLongDouble*, x : ComplexLongDouble) : LibC::Int
  # fun vector_complex_long_double_add_constant = gsl_vector_complex_long_double_add_constant(a : VectorComplexLongDouble*, x : ComplexLongDouble) : LibC::Int
  # fun vector_complex_long_double_get = gsl_vector_complex_long_double_get(v : VectorComplexLongDouble*, i : LibC::SizeT) : ComplexLongDouble
  # fun vector_complex_long_double_set = gsl_vector_complex_long_double_set(v : VectorComplexLongDouble*, i : LibC::SizeT, z : ComplexLongDouble)
  # fun vector_complex_long_double_ptr = gsl_vector_complex_long_double_ptr(v : VectorComplexLongDouble*, i : LibC::SizeT) : ComplexLongDouble*
  # fun vector_complex_long_double_const_ptr = gsl_vector_complex_long_double_const_ptr(v : VectorComplexLongDouble*, i : LibC::SizeT) : ComplexLongDouble*

  struct BlockStruct
    size : LibC::SizeT
    data : LibC::Double*
  end

  fun block_alloc = gsl_block_alloc(n : LibC::SizeT) : Block*
  type Block = BlockStruct
  fun block_calloc = gsl_block_calloc(n : LibC::SizeT) : Block*
  fun block_free = gsl_block_free(b : Block*)
  fun block_fread = gsl_block_fread(stream : File*, b : Block*) : LibC::Int
  fun block_fwrite = gsl_block_fwrite(stream : File*, b : Block*) : LibC::Int
  fun block_fscanf = gsl_block_fscanf(stream : File*, b : Block*) : LibC::Int
  fun block_fprintf = gsl_block_fprintf(stream : File*, b : Block*, format : LibC::Char*) : LibC::Int
  fun block_raw_fread = gsl_block_raw_fread(stream : File*, b : LibC::Double*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_raw_fwrite = gsl_block_raw_fwrite(stream : File*, b : LibC::Double*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_raw_fscanf = gsl_block_raw_fscanf(stream : File*, b : LibC::Double*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_raw_fprintf = gsl_block_raw_fprintf(stream : File*, b : LibC::Double*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_size = gsl_block_size(b : Block*) : LibC::SizeT
  fun block_data = gsl_block_data(b : Block*) : LibC::Double*
  fun vector_alloc = gsl_vector_alloc(n : LibC::SizeT) : Vector*

  struct Vector
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::Double*
    block : Block*
    owner : LibC::Int
  end

  fun vector_calloc = gsl_vector_calloc(n : LibC::SizeT) : Vector*
  fun vector_alloc_from_block = gsl_vector_alloc_from_block(b : Block*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : Vector*
  fun vector_alloc_from_vector = gsl_vector_alloc_from_vector(v : Vector*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : Vector*
  fun vector_free = gsl_vector_free(v : Vector*)
  fun vector_view_array = gsl_vector_view_array(v : LibC::Double*, n : LibC::SizeT) : X_GslVectorView

  struct X_GslVectorView
    vector : Vector
  end

  fun vector_view_array_with_stride = gsl_vector_view_array_with_stride(base : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorView
  fun vector_const_view_array = gsl_vector_const_view_array(v : LibC::Double*, n : LibC::SizeT) : X_GslVectorConstView

  struct X_GslVectorConstView
    vector : Vector
  end

  fun vector_const_view_array_with_stride = gsl_vector_const_view_array_with_stride(base : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorConstView
  fun vector_subvector = gsl_vector_subvector(v : Vector*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorView
  fun vector_subvector_with_stride = gsl_vector_subvector_with_stride(v : Vector*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorView
  fun vector_const_subvector = gsl_vector_const_subvector(v : Vector*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorConstView
  fun vector_const_subvector_with_stride = gsl_vector_const_subvector_with_stride(v : Vector*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorConstView
  fun vector_set_zero = gsl_vector_set_zero(v : Vector*)
  fun vector_set_all = gsl_vector_set_all(v : Vector*, x : LibC::Double)
  fun vector_set_basis = gsl_vector_set_basis(v : Vector*, i : LibC::SizeT) : LibC::Int
  fun vector_fread = gsl_vector_fread(stream : File*, v : Vector*) : LibC::Int
  fun vector_fwrite = gsl_vector_fwrite(stream : File*, v : Vector*) : LibC::Int
  fun vector_fscanf = gsl_vector_fscanf(stream : File*, v : Vector*) : LibC::Int
  fun vector_fprintf = gsl_vector_fprintf(stream : File*, v : Vector*, format : LibC::Char*) : LibC::Int
  fun vector_memcpy = gsl_vector_memcpy(dest : Vector*, src : Vector*) : LibC::Int
  fun vector_reverse = gsl_vector_reverse(v : Vector*) : LibC::Int
  fun vector_swap = gsl_vector_swap(v : Vector*, w : Vector*) : LibC::Int
  fun vector_swap_elements = gsl_vector_swap_elements(v : Vector*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_max = gsl_vector_max(v : Vector*) : LibC::Double
  fun vector_min = gsl_vector_min(v : Vector*) : LibC::Double
  fun vector_minmax = gsl_vector_minmax(v : Vector*, min_out : LibC::Double*, max_out : LibC::Double*)
  fun vector_max_index = gsl_vector_max_index(v : Vector*) : LibC::SizeT
  fun vector_min_index = gsl_vector_min_index(v : Vector*) : LibC::SizeT
  fun vector_minmax_index = gsl_vector_minmax_index(v : Vector*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_add = gsl_vector_add(a : Vector*, b : Vector*) : LibC::Int
  fun vector_sub = gsl_vector_sub(a : Vector*, b : Vector*) : LibC::Int
  fun vector_mul = gsl_vector_mul(a : Vector*, b : Vector*) : LibC::Int
  fun vector_div = gsl_vector_div(a : Vector*, b : Vector*) : LibC::Int
  fun vector_scale = gsl_vector_scale(a : Vector*, x : LibC::Double) : LibC::Int
  fun vector_add_constant = gsl_vector_add_constant(a : Vector*, x : LibC::Double) : LibC::Int
  fun vector_equal = gsl_vector_equal(u : Vector*, v : Vector*) : LibC::Int
  fun vector_isnull = gsl_vector_isnull(v : Vector*) : LibC::Int
  fun vector_ispos = gsl_vector_ispos(v : Vector*) : LibC::Int
  fun vector_isneg = gsl_vector_isneg(v : Vector*) : LibC::Int
  fun vector_isnonneg = gsl_vector_isnonneg(v : Vector*) : LibC::Int
  fun vector_get = gsl_vector_get(v : Vector*, i : LibC::SizeT) : LibC::Double
  fun vector_set = gsl_vector_set(v : Vector*, i : LibC::SizeT, x : LibC::Double)
  fun vector_ptr = gsl_vector_ptr(v : Vector*, i : LibC::SizeT) : LibC::Double*
  fun vector_const_ptr = gsl_vector_const_ptr(v : Vector*, i : LibC::SizeT) : LibC::Double*

  struct BlockComplexStruct
    size : LibC::SizeT
    data : LibC::Double*
  end

  fun block_complex_alloc = gsl_block_complex_alloc(n : LibC::SizeT) : BlockComplex*
  type BlockComplex = BlockComplexStruct
  fun block_complex_calloc = gsl_block_complex_calloc(n : LibC::SizeT) : BlockComplex*
  fun block_complex_free = gsl_block_complex_free(b : BlockComplex*)
  fun block_complex_fread = gsl_block_complex_fread(stream : File*, b : BlockComplex*) : LibC::Int
  fun block_complex_fwrite = gsl_block_complex_fwrite(stream : File*, b : BlockComplex*) : LibC::Int
  fun block_complex_fscanf = gsl_block_complex_fscanf(stream : File*, b : BlockComplex*) : LibC::Int
  fun block_complex_fprintf = gsl_block_complex_fprintf(stream : File*, b : BlockComplex*, format : LibC::Char*) : LibC::Int
  fun block_complex_raw_fread = gsl_block_complex_raw_fread(stream : File*, b : LibC::Double*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_complex_raw_fwrite = gsl_block_complex_raw_fwrite(stream : File*, b : LibC::Double*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_complex_raw_fscanf = gsl_block_complex_raw_fscanf(stream : File*, b : LibC::Double*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_complex_raw_fprintf = gsl_block_complex_raw_fprintf(stream : File*, b : LibC::Double*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_complex_size = gsl_block_complex_size(b : BlockComplex*) : LibC::SizeT
  fun block_complex_data = gsl_block_complex_data(b : BlockComplex*) : LibC::Double*
  fun vector_complex_alloc = gsl_vector_complex_alloc(n : LibC::SizeT) : VectorComplex*

  struct VectorComplex
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::Double*
    block : BlockComplex*
    owner : LibC::Int
  end

  fun vector_complex_calloc = gsl_vector_complex_calloc(n : LibC::SizeT) : VectorComplex*
  fun vector_complex_alloc_from_block = gsl_vector_complex_alloc_from_block(b : BlockComplex*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorComplex*
  fun vector_complex_alloc_from_vector = gsl_vector_complex_alloc_from_vector(v : VectorComplex*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorComplex*
  fun vector_complex_free = gsl_vector_complex_free(v : VectorComplex*)
  fun vector_complex_view_array = gsl_vector_complex_view_array(base : LibC::Double*, n : LibC::SizeT) : X_GslVectorComplexView

  struct X_GslVectorComplexView
    vector : VectorComplex
  end

  fun vector_complex_view_array_with_stride = gsl_vector_complex_view_array_with_stride(base : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexView
  fun vector_complex_const_view_array = gsl_vector_complex_const_view_array(base : LibC::Double*, n : LibC::SizeT) : X_GslVectorComplexConstView

  struct X_GslVectorComplexConstView
    vector : VectorComplex
  end

  fun vector_complex_const_view_array_with_stride = gsl_vector_complex_const_view_array_with_stride(base : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexConstView
  fun vector_complex_subvector = gsl_vector_complex_subvector(base : VectorComplex*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexView
  fun vector_complex_subvector_with_stride = gsl_vector_complex_subvector_with_stride(v : VectorComplex*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexView
  fun vector_complex_const_subvector = gsl_vector_complex_const_subvector(base : VectorComplex*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexConstView
  fun vector_complex_const_subvector_with_stride = gsl_vector_complex_const_subvector_with_stride(v : VectorComplex*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexConstView
  fun vector_complex_real = gsl_vector_complex_real(v : VectorComplex*) : X_GslVectorView
  fun vector_complex_imag = gsl_vector_complex_imag(v : VectorComplex*) : X_GslVectorView
  fun vector_complex_const_real = gsl_vector_complex_const_real(v : VectorComplex*) : X_GslVectorConstView
  fun vector_complex_const_imag = gsl_vector_complex_const_imag(v : VectorComplex*) : X_GslVectorConstView
  fun vector_complex_set_zero = gsl_vector_complex_set_zero(v : VectorComplex*)
  fun vector_complex_set_all = gsl_vector_complex_set_all(v : VectorComplex*, z : Complex)

  struct Complex
    dat : LibC::Double[2]
  end

  fun vector_complex_set_basis = gsl_vector_complex_set_basis(v : VectorComplex*, i : LibC::SizeT) : LibC::Int
  fun vector_complex_fread = gsl_vector_complex_fread(stream : File*, v : VectorComplex*) : LibC::Int
  fun vector_complex_fwrite = gsl_vector_complex_fwrite(stream : File*, v : VectorComplex*) : LibC::Int
  fun vector_complex_fscanf = gsl_vector_complex_fscanf(stream : File*, v : VectorComplex*) : LibC::Int
  fun vector_complex_fprintf = gsl_vector_complex_fprintf(stream : File*, v : VectorComplex*, format : LibC::Char*) : LibC::Int
  fun vector_complex_memcpy = gsl_vector_complex_memcpy(dest : VectorComplex*, src : VectorComplex*) : LibC::Int
  fun vector_complex_reverse = gsl_vector_complex_reverse(v : VectorComplex*) : LibC::Int
  fun vector_complex_swap = gsl_vector_complex_swap(v : VectorComplex*, w : VectorComplex*) : LibC::Int
  fun vector_complex_swap_elements = gsl_vector_complex_swap_elements(v : VectorComplex*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_complex_equal = gsl_vector_complex_equal(u : VectorComplex*, v : VectorComplex*) : LibC::Int
  fun vector_complex_isnull = gsl_vector_complex_isnull(v : VectorComplex*) : LibC::Int
  fun vector_complex_ispos = gsl_vector_complex_ispos(v : VectorComplex*) : LibC::Int
  fun vector_complex_isneg = gsl_vector_complex_isneg(v : VectorComplex*) : LibC::Int
  fun vector_complex_isnonneg = gsl_vector_complex_isnonneg(v : VectorComplex*) : LibC::Int
  fun vector_complex_add = gsl_vector_complex_add(a : VectorComplex*, b : VectorComplex*) : LibC::Int
  fun vector_complex_sub = gsl_vector_complex_sub(a : VectorComplex*, b : VectorComplex*) : LibC::Int
  fun vector_complex_mul = gsl_vector_complex_mul(a : VectorComplex*, b : VectorComplex*) : LibC::Int
  fun vector_complex_div = gsl_vector_complex_div(a : VectorComplex*, b : VectorComplex*) : LibC::Int
  fun vector_complex_scale = gsl_vector_complex_scale(a : VectorComplex*, x : Complex) : LibC::Int
  fun vector_complex_add_constant = gsl_vector_complex_add_constant(a : VectorComplex*, x : Complex) : LibC::Int
  fun vector_complex_get = gsl_vector_complex_get(v : VectorComplex*, i : LibC::SizeT) : Complex
  fun vector_complex_set = gsl_vector_complex_set(v : VectorComplex*, i : LibC::SizeT, z : Complex)
  fun vector_complex_ptr = gsl_vector_complex_ptr(v : VectorComplex*, i : LibC::SizeT) : Complex*
  fun vector_complex_const_ptr = gsl_vector_complex_const_ptr(v : VectorComplex*, i : LibC::SizeT) : Complex*

  struct BlockFloatStruct
    size : LibC::SizeT
    data : LibC::Float*
  end

  fun block_float_alloc = gsl_block_float_alloc(n : LibC::SizeT) : BlockFloat*
  type BlockFloat = BlockFloatStruct
  fun block_float_calloc = gsl_block_float_calloc(n : LibC::SizeT) : BlockFloat*
  fun block_float_free = gsl_block_float_free(b : BlockFloat*)
  fun block_float_fread = gsl_block_float_fread(stream : File*, b : BlockFloat*) : LibC::Int
  fun block_float_fwrite = gsl_block_float_fwrite(stream : File*, b : BlockFloat*) : LibC::Int
  fun block_float_fscanf = gsl_block_float_fscanf(stream : File*, b : BlockFloat*) : LibC::Int
  fun block_float_fprintf = gsl_block_float_fprintf(stream : File*, b : BlockFloat*, format : LibC::Char*) : LibC::Int
  fun block_float_raw_fread = gsl_block_float_raw_fread(stream : File*, b : LibC::Float*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_float_raw_fwrite = gsl_block_float_raw_fwrite(stream : File*, b : LibC::Float*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_float_raw_fscanf = gsl_block_float_raw_fscanf(stream : File*, b : LibC::Float*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_float_raw_fprintf = gsl_block_float_raw_fprintf(stream : File*, b : LibC::Float*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_float_size = gsl_block_float_size(b : BlockFloat*) : LibC::SizeT
  fun block_float_data = gsl_block_float_data(b : BlockFloat*) : LibC::Float*
  fun vector_float_alloc = gsl_vector_float_alloc(n : LibC::SizeT) : VectorFloat*

  struct VectorFloat
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::Float*
    block : BlockFloat*
    owner : LibC::Int
  end

  fun vector_float_calloc = gsl_vector_float_calloc(n : LibC::SizeT) : VectorFloat*
  fun vector_float_alloc_from_block = gsl_vector_float_alloc_from_block(b : BlockFloat*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorFloat*
  fun vector_float_alloc_from_vector = gsl_vector_float_alloc_from_vector(v : VectorFloat*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorFloat*
  fun vector_float_free = gsl_vector_float_free(v : VectorFloat*)
  fun vector_float_view_array = gsl_vector_float_view_array(v : LibC::Float*, n : LibC::SizeT) : X_GslVectorFloatView

  struct X_GslVectorFloatView
    vector : VectorFloat
  end

  fun vector_float_view_array_with_stride = gsl_vector_float_view_array_with_stride(base : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatView
  fun vector_float_const_view_array = gsl_vector_float_const_view_array(v : LibC::Float*, n : LibC::SizeT) : X_GslVectorFloatConstView

  struct X_GslVectorFloatConstView
    vector : VectorFloat
  end

  fun vector_float_const_view_array_with_stride = gsl_vector_float_const_view_array_with_stride(base : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatConstView
  fun vector_float_subvector = gsl_vector_float_subvector(v : VectorFloat*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatView
  fun vector_float_subvector_with_stride = gsl_vector_float_subvector_with_stride(v : VectorFloat*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatView
  fun vector_float_const_subvector = gsl_vector_float_const_subvector(v : VectorFloat*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatConstView
  fun vector_float_const_subvector_with_stride = gsl_vector_float_const_subvector_with_stride(v : VectorFloat*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatConstView
  fun vector_float_set_zero = gsl_vector_float_set_zero(v : VectorFloat*)
  fun vector_float_set_all = gsl_vector_float_set_all(v : VectorFloat*, x : LibC::Float)
  fun vector_float_set_basis = gsl_vector_float_set_basis(v : VectorFloat*, i : LibC::SizeT) : LibC::Int
  fun vector_float_fread = gsl_vector_float_fread(stream : File*, v : VectorFloat*) : LibC::Int
  fun vector_float_fwrite = gsl_vector_float_fwrite(stream : File*, v : VectorFloat*) : LibC::Int
  fun vector_float_fscanf = gsl_vector_float_fscanf(stream : File*, v : VectorFloat*) : LibC::Int
  fun vector_float_fprintf = gsl_vector_float_fprintf(stream : File*, v : VectorFloat*, format : LibC::Char*) : LibC::Int
  fun vector_float_memcpy = gsl_vector_float_memcpy(dest : VectorFloat*, src : VectorFloat*) : LibC::Int
  fun vector_float_reverse = gsl_vector_float_reverse(v : VectorFloat*) : LibC::Int
  fun vector_float_swap = gsl_vector_float_swap(v : VectorFloat*, w : VectorFloat*) : LibC::Int
  fun vector_float_swap_elements = gsl_vector_float_swap_elements(v : VectorFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_float_max = gsl_vector_float_max(v : VectorFloat*) : LibC::Float
  fun vector_float_min = gsl_vector_float_min(v : VectorFloat*) : LibC::Float
  fun vector_float_minmax = gsl_vector_float_minmax(v : VectorFloat*, min_out : LibC::Float*, max_out : LibC::Float*)
  fun vector_float_max_index = gsl_vector_float_max_index(v : VectorFloat*) : LibC::SizeT
  fun vector_float_min_index = gsl_vector_float_min_index(v : VectorFloat*) : LibC::SizeT
  fun vector_float_minmax_index = gsl_vector_float_minmax_index(v : VectorFloat*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_float_add = gsl_vector_float_add(a : VectorFloat*, b : VectorFloat*) : LibC::Int
  fun vector_float_sub = gsl_vector_float_sub(a : VectorFloat*, b : VectorFloat*) : LibC::Int
  fun vector_float_mul = gsl_vector_float_mul(a : VectorFloat*, b : VectorFloat*) : LibC::Int
  fun vector_float_div = gsl_vector_float_div(a : VectorFloat*, b : VectorFloat*) : LibC::Int
  fun vector_float_scale = gsl_vector_float_scale(a : VectorFloat*, x : LibC::Double) : LibC::Int
  fun vector_float_add_constant = gsl_vector_float_add_constant(a : VectorFloat*, x : LibC::Double) : LibC::Int
  fun vector_float_equal = gsl_vector_float_equal(u : VectorFloat*, v : VectorFloat*) : LibC::Int
  fun vector_float_isnull = gsl_vector_float_isnull(v : VectorFloat*) : LibC::Int
  fun vector_float_ispos = gsl_vector_float_ispos(v : VectorFloat*) : LibC::Int
  fun vector_float_isneg = gsl_vector_float_isneg(v : VectorFloat*) : LibC::Int
  fun vector_float_isnonneg = gsl_vector_float_isnonneg(v : VectorFloat*) : LibC::Int
  fun vector_float_get = gsl_vector_float_get(v : VectorFloat*, i : LibC::SizeT) : LibC::Float
  fun vector_float_set = gsl_vector_float_set(v : VectorFloat*, i : LibC::SizeT, x : LibC::Float)
  fun vector_float_ptr = gsl_vector_float_ptr(v : VectorFloat*, i : LibC::SizeT) : LibC::Float*
  fun vector_float_const_ptr = gsl_vector_float_const_ptr(v : VectorFloat*, i : LibC::SizeT) : LibC::Float*

  struct BlockComplexFloatStruct
    size : LibC::SizeT
    data : LibC::Float*
  end

  fun block_complex_float_alloc = gsl_block_complex_float_alloc(n : LibC::SizeT) : BlockComplexFloat*
  type BlockComplexFloat = BlockComplexFloatStruct
  fun block_complex_float_calloc = gsl_block_complex_float_calloc(n : LibC::SizeT) : BlockComplexFloat*
  fun block_complex_float_free = gsl_block_complex_float_free(b : BlockComplexFloat*)
  fun block_complex_float_fread = gsl_block_complex_float_fread(stream : File*, b : BlockComplexFloat*) : LibC::Int
  fun block_complex_float_fwrite = gsl_block_complex_float_fwrite(stream : File*, b : BlockComplexFloat*) : LibC::Int
  fun block_complex_float_fscanf = gsl_block_complex_float_fscanf(stream : File*, b : BlockComplexFloat*) : LibC::Int
  fun block_complex_float_fprintf = gsl_block_complex_float_fprintf(stream : File*, b : BlockComplexFloat*, format : LibC::Char*) : LibC::Int
  fun block_complex_float_raw_fread = gsl_block_complex_float_raw_fread(stream : File*, b : LibC::Float*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_complex_float_raw_fwrite = gsl_block_complex_float_raw_fwrite(stream : File*, b : LibC::Float*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_complex_float_raw_fscanf = gsl_block_complex_float_raw_fscanf(stream : File*, b : LibC::Float*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_complex_float_raw_fprintf = gsl_block_complex_float_raw_fprintf(stream : File*, b : LibC::Float*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_complex_float_size = gsl_block_complex_float_size(b : BlockComplexFloat*) : LibC::SizeT
  fun block_complex_float_data = gsl_block_complex_float_data(b : BlockComplexFloat*) : LibC::Float*
  fun vector_complex_float_alloc = gsl_vector_complex_float_alloc(n : LibC::SizeT) : VectorComplexFloat*

  struct VectorComplexFloat
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::Float*
    block : BlockComplexFloat*
    owner : LibC::Int
  end

  fun vector_complex_float_calloc = gsl_vector_complex_float_calloc(n : LibC::SizeT) : VectorComplexFloat*
  fun vector_complex_float_alloc_from_block = gsl_vector_complex_float_alloc_from_block(b : BlockComplexFloat*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorComplexFloat*
  fun vector_complex_float_alloc_from_vector = gsl_vector_complex_float_alloc_from_vector(v : VectorComplexFloat*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorComplexFloat*
  fun vector_complex_float_free = gsl_vector_complex_float_free(v : VectorComplexFloat*)
  fun vector_complex_float_view_array = gsl_vector_complex_float_view_array(base : LibC::Float*, n : LibC::SizeT) : X_GslVectorComplexFloatView

  struct X_GslVectorComplexFloatView
    vector : VectorComplexFloat
  end

  fun vector_complex_float_view_array_with_stride = gsl_vector_complex_float_view_array_with_stride(base : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatView
  fun vector_complex_float_const_view_array = gsl_vector_complex_float_const_view_array(base : LibC::Float*, n : LibC::SizeT) : X_GslVectorComplexFloatConstView

  struct X_GslVectorComplexFloatConstView
    vector : VectorComplexFloat
  end

  fun vector_complex_float_const_view_array_with_stride = gsl_vector_complex_float_const_view_array_with_stride(base : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun vector_complex_float_subvector = gsl_vector_complex_float_subvector(base : VectorComplexFloat*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatView
  fun vector_complex_float_subvector_with_stride = gsl_vector_complex_float_subvector_with_stride(v : VectorComplexFloat*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatView
  fun vector_complex_float_const_subvector = gsl_vector_complex_float_const_subvector(base : VectorComplexFloat*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun vector_complex_float_const_subvector_with_stride = gsl_vector_complex_float_const_subvector_with_stride(v : VectorComplexFloat*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun vector_complex_float_real = gsl_vector_complex_float_real(v : VectorComplexFloat*) : X_GslVectorFloatView
  fun vector_complex_float_imag = gsl_vector_complex_float_imag(v : VectorComplexFloat*) : X_GslVectorFloatView
  fun vector_complex_float_const_real = gsl_vector_complex_float_const_real(v : VectorComplexFloat*) : X_GslVectorFloatConstView
  fun vector_complex_float_const_imag = gsl_vector_complex_float_const_imag(v : VectorComplexFloat*) : X_GslVectorFloatConstView
  fun vector_complex_float_set_zero = gsl_vector_complex_float_set_zero(v : VectorComplexFloat*)
  fun vector_complex_float_set_all = gsl_vector_complex_float_set_all(v : VectorComplexFloat*, z : ComplexFloat)

  struct ComplexFloat
    dat : LibC::Float[2]
  end

  fun vector_complex_float_set_basis = gsl_vector_complex_float_set_basis(v : VectorComplexFloat*, i : LibC::SizeT) : LibC::Int
  fun vector_complex_float_fread = gsl_vector_complex_float_fread(stream : File*, v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_fwrite = gsl_vector_complex_float_fwrite(stream : File*, v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_fscanf = gsl_vector_complex_float_fscanf(stream : File*, v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_fprintf = gsl_vector_complex_float_fprintf(stream : File*, v : VectorComplexFloat*, format : LibC::Char*) : LibC::Int
  fun vector_complex_float_memcpy = gsl_vector_complex_float_memcpy(dest : VectorComplexFloat*, src : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_reverse = gsl_vector_complex_float_reverse(v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_swap = gsl_vector_complex_float_swap(v : VectorComplexFloat*, w : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_swap_elements = gsl_vector_complex_float_swap_elements(v : VectorComplexFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_complex_float_equal = gsl_vector_complex_float_equal(u : VectorComplexFloat*, v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_isnull = gsl_vector_complex_float_isnull(v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_ispos = gsl_vector_complex_float_ispos(v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_isneg = gsl_vector_complex_float_isneg(v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_isnonneg = gsl_vector_complex_float_isnonneg(v : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_add = gsl_vector_complex_float_add(a : VectorComplexFloat*, b : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_sub = gsl_vector_complex_float_sub(a : VectorComplexFloat*, b : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_mul = gsl_vector_complex_float_mul(a : VectorComplexFloat*, b : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_div = gsl_vector_complex_float_div(a : VectorComplexFloat*, b : VectorComplexFloat*) : LibC::Int
  fun vector_complex_float_scale = gsl_vector_complex_float_scale(a : VectorComplexFloat*, x : ComplexFloat) : LibC::Int
  fun vector_complex_float_add_constant = gsl_vector_complex_float_add_constant(a : VectorComplexFloat*, x : ComplexFloat) : LibC::Int
  fun vector_complex_float_get = gsl_vector_complex_float_get(v : VectorComplexFloat*, i : LibC::SizeT) : ComplexFloat
  fun vector_complex_float_set = gsl_vector_complex_float_set(v : VectorComplexFloat*, i : LibC::SizeT, z : ComplexFloat)
  fun vector_complex_float_ptr = gsl_vector_complex_float_ptr(v : VectorComplexFloat*, i : LibC::SizeT) : ComplexFloat*
  fun vector_complex_float_const_ptr = gsl_vector_complex_float_const_ptr(v : VectorComplexFloat*, i : LibC::SizeT) : ComplexFloat*

  struct BlockUlongStruct
    size : LibC::SizeT
    data : LibC::ULong*
  end

  fun block_ulong_alloc = gsl_block_ulong_alloc(n : LibC::SizeT) : BlockUlong*
  type BlockUlong = BlockUlongStruct
  fun block_ulong_calloc = gsl_block_ulong_calloc(n : LibC::SizeT) : BlockUlong*
  fun block_ulong_free = gsl_block_ulong_free(b : BlockUlong*)
  fun block_ulong_fread = gsl_block_ulong_fread(stream : File*, b : BlockUlong*) : LibC::Int
  fun block_ulong_fwrite = gsl_block_ulong_fwrite(stream : File*, b : BlockUlong*) : LibC::Int
  fun block_ulong_fscanf = gsl_block_ulong_fscanf(stream : File*, b : BlockUlong*) : LibC::Int
  fun block_ulong_fprintf = gsl_block_ulong_fprintf(stream : File*, b : BlockUlong*, format : LibC::Char*) : LibC::Int
  fun block_ulong_raw_fread = gsl_block_ulong_raw_fread(stream : File*, b : LibC::ULong*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_ulong_raw_fwrite = gsl_block_ulong_raw_fwrite(stream : File*, b : LibC::ULong*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_ulong_raw_fscanf = gsl_block_ulong_raw_fscanf(stream : File*, b : LibC::ULong*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_ulong_raw_fprintf = gsl_block_ulong_raw_fprintf(stream : File*, b : LibC::ULong*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_ulong_size = gsl_block_ulong_size(b : BlockUlong*) : LibC::SizeT
  fun block_ulong_data = gsl_block_ulong_data(b : BlockUlong*) : LibC::ULong*
  fun vector_ulong_alloc = gsl_vector_ulong_alloc(n : LibC::SizeT) : VectorUlong*

  struct VectorUlong
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::ULong*
    block : BlockUlong*
    owner : LibC::Int
  end

  fun vector_ulong_calloc = gsl_vector_ulong_calloc(n : LibC::SizeT) : VectorUlong*
  fun vector_ulong_alloc_from_block = gsl_vector_ulong_alloc_from_block(b : BlockUlong*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorUlong*
  fun vector_ulong_alloc_from_vector = gsl_vector_ulong_alloc_from_vector(v : VectorUlong*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorUlong*
  fun vector_ulong_free = gsl_vector_ulong_free(v : VectorUlong*)
  fun vector_ulong_view_array = gsl_vector_ulong_view_array(v : LibC::ULong*, n : LibC::SizeT) : X_GslVectorUlongView

  struct X_GslVectorUlongView
    vector : VectorUlong
  end

  fun vector_ulong_view_array_with_stride = gsl_vector_ulong_view_array_with_stride(base : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongView
  fun vector_ulong_const_view_array = gsl_vector_ulong_const_view_array(v : LibC::ULong*, n : LibC::SizeT) : X_GslVectorUlongConstView

  struct X_GslVectorUlongConstView
    vector : VectorUlong
  end

  fun vector_ulong_const_view_array_with_stride = gsl_vector_ulong_const_view_array_with_stride(base : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongConstView
  fun vector_ulong_subvector = gsl_vector_ulong_subvector(v : VectorUlong*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongView
  fun vector_ulong_subvector_with_stride = gsl_vector_ulong_subvector_with_stride(v : VectorUlong*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongView
  fun vector_ulong_const_subvector = gsl_vector_ulong_const_subvector(v : VectorUlong*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongConstView
  fun vector_ulong_const_subvector_with_stride = gsl_vector_ulong_const_subvector_with_stride(v : VectorUlong*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongConstView
  fun vector_ulong_set_zero = gsl_vector_ulong_set_zero(v : VectorUlong*)
  fun vector_ulong_set_all = gsl_vector_ulong_set_all(v : VectorUlong*, x : LibC::ULong)
  fun vector_ulong_set_basis = gsl_vector_ulong_set_basis(v : VectorUlong*, i : LibC::SizeT) : LibC::Int
  fun vector_ulong_fread = gsl_vector_ulong_fread(stream : File*, v : VectorUlong*) : LibC::Int
  fun vector_ulong_fwrite = gsl_vector_ulong_fwrite(stream : File*, v : VectorUlong*) : LibC::Int
  fun vector_ulong_fscanf = gsl_vector_ulong_fscanf(stream : File*, v : VectorUlong*) : LibC::Int
  fun vector_ulong_fprintf = gsl_vector_ulong_fprintf(stream : File*, v : VectorUlong*, format : LibC::Char*) : LibC::Int
  fun vector_ulong_memcpy = gsl_vector_ulong_memcpy(dest : VectorUlong*, src : VectorUlong*) : LibC::Int
  fun vector_ulong_reverse = gsl_vector_ulong_reverse(v : VectorUlong*) : LibC::Int
  fun vector_ulong_swap = gsl_vector_ulong_swap(v : VectorUlong*, w : VectorUlong*) : LibC::Int
  fun vector_ulong_swap_elements = gsl_vector_ulong_swap_elements(v : VectorUlong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_ulong_max = gsl_vector_ulong_max(v : VectorUlong*) : LibC::ULong
  fun vector_ulong_min = gsl_vector_ulong_min(v : VectorUlong*) : LibC::ULong
  fun vector_ulong_minmax = gsl_vector_ulong_minmax(v : VectorUlong*, min_out : LibC::ULong*, max_out : LibC::ULong*)
  fun vector_ulong_max_index = gsl_vector_ulong_max_index(v : VectorUlong*) : LibC::SizeT
  fun vector_ulong_min_index = gsl_vector_ulong_min_index(v : VectorUlong*) : LibC::SizeT
  fun vector_ulong_minmax_index = gsl_vector_ulong_minmax_index(v : VectorUlong*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_ulong_add = gsl_vector_ulong_add(a : VectorUlong*, b : VectorUlong*) : LibC::Int
  fun vector_ulong_sub = gsl_vector_ulong_sub(a : VectorUlong*, b : VectorUlong*) : LibC::Int
  fun vector_ulong_mul = gsl_vector_ulong_mul(a : VectorUlong*, b : VectorUlong*) : LibC::Int
  fun vector_ulong_div = gsl_vector_ulong_div(a : VectorUlong*, b : VectorUlong*) : LibC::Int
  fun vector_ulong_scale = gsl_vector_ulong_scale(a : VectorUlong*, x : LibC::Double) : LibC::Int
  fun vector_ulong_add_constant = gsl_vector_ulong_add_constant(a : VectorUlong*, x : LibC::Double) : LibC::Int
  fun vector_ulong_equal = gsl_vector_ulong_equal(u : VectorUlong*, v : VectorUlong*) : LibC::Int
  fun vector_ulong_isnull = gsl_vector_ulong_isnull(v : VectorUlong*) : LibC::Int
  fun vector_ulong_ispos = gsl_vector_ulong_ispos(v : VectorUlong*) : LibC::Int
  fun vector_ulong_isneg = gsl_vector_ulong_isneg(v : VectorUlong*) : LibC::Int
  fun vector_ulong_isnonneg = gsl_vector_ulong_isnonneg(v : VectorUlong*) : LibC::Int
  fun vector_ulong_get = gsl_vector_ulong_get(v : VectorUlong*, i : LibC::SizeT) : LibC::ULong
  fun vector_ulong_set = gsl_vector_ulong_set(v : VectorUlong*, i : LibC::SizeT, x : LibC::ULong)
  fun vector_ulong_ptr = gsl_vector_ulong_ptr(v : VectorUlong*, i : LibC::SizeT) : LibC::ULong*
  fun vector_ulong_const_ptr = gsl_vector_ulong_const_ptr(v : VectorUlong*, i : LibC::SizeT) : LibC::ULong*

  struct BlockLongStruct
    size : LibC::SizeT
    data : LibC::Long*
  end

  fun block_long_alloc = gsl_block_long_alloc(n : LibC::SizeT) : BlockLong*
  type BlockLong = BlockLongStruct
  fun block_long_calloc = gsl_block_long_calloc(n : LibC::SizeT) : BlockLong*
  fun block_long_free = gsl_block_long_free(b : BlockLong*)
  fun block_long_fread = gsl_block_long_fread(stream : File*, b : BlockLong*) : LibC::Int
  fun block_long_fwrite = gsl_block_long_fwrite(stream : File*, b : BlockLong*) : LibC::Int
  fun block_long_fscanf = gsl_block_long_fscanf(stream : File*, b : BlockLong*) : LibC::Int
  fun block_long_fprintf = gsl_block_long_fprintf(stream : File*, b : BlockLong*, format : LibC::Char*) : LibC::Int
  fun block_long_raw_fread = gsl_block_long_raw_fread(stream : File*, b : LibC::Long*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_long_raw_fwrite = gsl_block_long_raw_fwrite(stream : File*, b : LibC::Long*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_long_raw_fscanf = gsl_block_long_raw_fscanf(stream : File*, b : LibC::Long*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_long_raw_fprintf = gsl_block_long_raw_fprintf(stream : File*, b : LibC::Long*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_long_size = gsl_block_long_size(b : BlockLong*) : LibC::SizeT
  fun block_long_data = gsl_block_long_data(b : BlockLong*) : LibC::Long*
  fun vector_long_alloc = gsl_vector_long_alloc(n : LibC::SizeT) : VectorLong*

  struct VectorLong
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::Long*
    block : BlockLong*
    owner : LibC::Int
  end

  fun vector_long_calloc = gsl_vector_long_calloc(n : LibC::SizeT) : VectorLong*
  fun vector_long_alloc_from_block = gsl_vector_long_alloc_from_block(b : BlockLong*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorLong*
  fun vector_long_alloc_from_vector = gsl_vector_long_alloc_from_vector(v : VectorLong*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorLong*
  fun vector_long_free = gsl_vector_long_free(v : VectorLong*)
  fun vector_long_view_array = gsl_vector_long_view_array(v : LibC::Long*, n : LibC::SizeT) : X_GslVectorLongView

  struct X_GslVectorLongView
    vector : VectorLong
  end

  fun vector_long_view_array_with_stride = gsl_vector_long_view_array_with_stride(base : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongView
  fun vector_long_const_view_array = gsl_vector_long_const_view_array(v : LibC::Long*, n : LibC::SizeT) : X_GslVectorLongConstView

  struct X_GslVectorLongConstView
    vector : VectorLong
  end

  fun vector_long_const_view_array_with_stride = gsl_vector_long_const_view_array_with_stride(base : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongConstView
  fun vector_long_subvector = gsl_vector_long_subvector(v : VectorLong*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongView
  fun vector_long_subvector_with_stride = gsl_vector_long_subvector_with_stride(v : VectorLong*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongView
  fun vector_long_const_subvector = gsl_vector_long_const_subvector(v : VectorLong*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongConstView
  fun vector_long_const_subvector_with_stride = gsl_vector_long_const_subvector_with_stride(v : VectorLong*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongConstView
  fun vector_long_set_zero = gsl_vector_long_set_zero(v : VectorLong*)
  fun vector_long_set_all = gsl_vector_long_set_all(v : VectorLong*, x : LibC::Long)
  fun vector_long_set_basis = gsl_vector_long_set_basis(v : VectorLong*, i : LibC::SizeT) : LibC::Int
  fun vector_long_fread = gsl_vector_long_fread(stream : File*, v : VectorLong*) : LibC::Int
  fun vector_long_fwrite = gsl_vector_long_fwrite(stream : File*, v : VectorLong*) : LibC::Int
  fun vector_long_fscanf = gsl_vector_long_fscanf(stream : File*, v : VectorLong*) : LibC::Int
  fun vector_long_fprintf = gsl_vector_long_fprintf(stream : File*, v : VectorLong*, format : LibC::Char*) : LibC::Int
  fun vector_long_memcpy = gsl_vector_long_memcpy(dest : VectorLong*, src : VectorLong*) : LibC::Int
  fun vector_long_reverse = gsl_vector_long_reverse(v : VectorLong*) : LibC::Int
  fun vector_long_swap = gsl_vector_long_swap(v : VectorLong*, w : VectorLong*) : LibC::Int
  fun vector_long_swap_elements = gsl_vector_long_swap_elements(v : VectorLong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_long_max = gsl_vector_long_max(v : VectorLong*) : LibC::Long
  fun vector_long_min = gsl_vector_long_min(v : VectorLong*) : LibC::Long
  fun vector_long_minmax = gsl_vector_long_minmax(v : VectorLong*, min_out : LibC::Long*, max_out : LibC::Long*)
  fun vector_long_max_index = gsl_vector_long_max_index(v : VectorLong*) : LibC::SizeT
  fun vector_long_min_index = gsl_vector_long_min_index(v : VectorLong*) : LibC::SizeT
  fun vector_long_minmax_index = gsl_vector_long_minmax_index(v : VectorLong*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_long_add = gsl_vector_long_add(a : VectorLong*, b : VectorLong*) : LibC::Int
  fun vector_long_sub = gsl_vector_long_sub(a : VectorLong*, b : VectorLong*) : LibC::Int
  fun vector_long_mul = gsl_vector_long_mul(a : VectorLong*, b : VectorLong*) : LibC::Int
  fun vector_long_div = gsl_vector_long_div(a : VectorLong*, b : VectorLong*) : LibC::Int
  fun vector_long_scale = gsl_vector_long_scale(a : VectorLong*, x : LibC::Double) : LibC::Int
  fun vector_long_add_constant = gsl_vector_long_add_constant(a : VectorLong*, x : LibC::Double) : LibC::Int
  fun vector_long_equal = gsl_vector_long_equal(u : VectorLong*, v : VectorLong*) : LibC::Int
  fun vector_long_isnull = gsl_vector_long_isnull(v : VectorLong*) : LibC::Int
  fun vector_long_ispos = gsl_vector_long_ispos(v : VectorLong*) : LibC::Int
  fun vector_long_isneg = gsl_vector_long_isneg(v : VectorLong*) : LibC::Int
  fun vector_long_isnonneg = gsl_vector_long_isnonneg(v : VectorLong*) : LibC::Int
  fun vector_long_get = gsl_vector_long_get(v : VectorLong*, i : LibC::SizeT) : LibC::Long
  fun vector_long_set = gsl_vector_long_set(v : VectorLong*, i : LibC::SizeT, x : LibC::Long)
  fun vector_long_ptr = gsl_vector_long_ptr(v : VectorLong*, i : LibC::SizeT) : LibC::Long*
  fun vector_long_const_ptr = gsl_vector_long_const_ptr(v : VectorLong*, i : LibC::SizeT) : LibC::Long*

  struct BlockUintStruct
    size : LibC::SizeT
    data : LibC::UInt*
  end

  fun block_uint_alloc = gsl_block_uint_alloc(n : LibC::SizeT) : BlockUint*
  type BlockUint = BlockUintStruct
  fun block_uint_calloc = gsl_block_uint_calloc(n : LibC::SizeT) : BlockUint*
  fun block_uint_free = gsl_block_uint_free(b : BlockUint*)
  fun block_uint_fread = gsl_block_uint_fread(stream : File*, b : BlockUint*) : LibC::Int
  fun block_uint_fwrite = gsl_block_uint_fwrite(stream : File*, b : BlockUint*) : LibC::Int
  fun block_uint_fscanf = gsl_block_uint_fscanf(stream : File*, b : BlockUint*) : LibC::Int
  fun block_uint_fprintf = gsl_block_uint_fprintf(stream : File*, b : BlockUint*, format : LibC::Char*) : LibC::Int
  fun block_uint_raw_fread = gsl_block_uint_raw_fread(stream : File*, b : LibC::UInt*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_uint_raw_fwrite = gsl_block_uint_raw_fwrite(stream : File*, b : LibC::UInt*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_uint_raw_fscanf = gsl_block_uint_raw_fscanf(stream : File*, b : LibC::UInt*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_uint_raw_fprintf = gsl_block_uint_raw_fprintf(stream : File*, b : LibC::UInt*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_uint_size = gsl_block_uint_size(b : BlockUint*) : LibC::SizeT
  fun block_uint_data = gsl_block_uint_data(b : BlockUint*) : LibC::UInt*
  fun vector_uint_alloc = gsl_vector_uint_alloc(n : LibC::SizeT) : VectorUint*

  struct VectorUint
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::UInt*
    block : BlockUint*
    owner : LibC::Int
  end

  fun vector_uint_calloc = gsl_vector_uint_calloc(n : LibC::SizeT) : VectorUint*
  fun vector_uint_alloc_from_block = gsl_vector_uint_alloc_from_block(b : BlockUint*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorUint*
  fun vector_uint_alloc_from_vector = gsl_vector_uint_alloc_from_vector(v : VectorUint*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorUint*
  fun vector_uint_free = gsl_vector_uint_free(v : VectorUint*)
  fun vector_uint_view_array = gsl_vector_uint_view_array(v : LibC::UInt*, n : LibC::SizeT) : X_GslVectorUintView

  struct X_GslVectorUintView
    vector : VectorUint
  end

  fun vector_uint_view_array_with_stride = gsl_vector_uint_view_array_with_stride(base : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintView
  fun vector_uint_const_view_array = gsl_vector_uint_const_view_array(v : LibC::UInt*, n : LibC::SizeT) : X_GslVectorUintConstView

  struct X_GslVectorUintConstView
    vector : VectorUint
  end

  fun vector_uint_const_view_array_with_stride = gsl_vector_uint_const_view_array_with_stride(base : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintConstView
  fun vector_uint_subvector = gsl_vector_uint_subvector(v : VectorUint*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintView
  fun vector_uint_subvector_with_stride = gsl_vector_uint_subvector_with_stride(v : VectorUint*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintView
  fun vector_uint_const_subvector = gsl_vector_uint_const_subvector(v : VectorUint*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintConstView
  fun vector_uint_const_subvector_with_stride = gsl_vector_uint_const_subvector_with_stride(v : VectorUint*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintConstView
  fun vector_uint_set_zero = gsl_vector_uint_set_zero(v : VectorUint*)
  fun vector_uint_set_all = gsl_vector_uint_set_all(v : VectorUint*, x : LibC::UInt)
  fun vector_uint_set_basis = gsl_vector_uint_set_basis(v : VectorUint*, i : LibC::SizeT) : LibC::Int
  fun vector_uint_fread = gsl_vector_uint_fread(stream : File*, v : VectorUint*) : LibC::Int
  fun vector_uint_fwrite = gsl_vector_uint_fwrite(stream : File*, v : VectorUint*) : LibC::Int
  fun vector_uint_fscanf = gsl_vector_uint_fscanf(stream : File*, v : VectorUint*) : LibC::Int
  fun vector_uint_fprintf = gsl_vector_uint_fprintf(stream : File*, v : VectorUint*, format : LibC::Char*) : LibC::Int
  fun vector_uint_memcpy = gsl_vector_uint_memcpy(dest : VectorUint*, src : VectorUint*) : LibC::Int
  fun vector_uint_reverse = gsl_vector_uint_reverse(v : VectorUint*) : LibC::Int
  fun vector_uint_swap = gsl_vector_uint_swap(v : VectorUint*, w : VectorUint*) : LibC::Int
  fun vector_uint_swap_elements = gsl_vector_uint_swap_elements(v : VectorUint*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_uint_max = gsl_vector_uint_max(v : VectorUint*) : LibC::UInt
  fun vector_uint_min = gsl_vector_uint_min(v : VectorUint*) : LibC::UInt
  fun vector_uint_minmax = gsl_vector_uint_minmax(v : VectorUint*, min_out : LibC::UInt*, max_out : LibC::UInt*)
  fun vector_uint_max_index = gsl_vector_uint_max_index(v : VectorUint*) : LibC::SizeT
  fun vector_uint_min_index = gsl_vector_uint_min_index(v : VectorUint*) : LibC::SizeT
  fun vector_uint_minmax_index = gsl_vector_uint_minmax_index(v : VectorUint*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_uint_add = gsl_vector_uint_add(a : VectorUint*, b : VectorUint*) : LibC::Int
  fun vector_uint_sub = gsl_vector_uint_sub(a : VectorUint*, b : VectorUint*) : LibC::Int
  fun vector_uint_mul = gsl_vector_uint_mul(a : VectorUint*, b : VectorUint*) : LibC::Int
  fun vector_uint_div = gsl_vector_uint_div(a : VectorUint*, b : VectorUint*) : LibC::Int
  fun vector_uint_scale = gsl_vector_uint_scale(a : VectorUint*, x : LibC::Double) : LibC::Int
  fun vector_uint_add_constant = gsl_vector_uint_add_constant(a : VectorUint*, x : LibC::Double) : LibC::Int
  fun vector_uint_equal = gsl_vector_uint_equal(u : VectorUint*, v : VectorUint*) : LibC::Int
  fun vector_uint_isnull = gsl_vector_uint_isnull(v : VectorUint*) : LibC::Int
  fun vector_uint_ispos = gsl_vector_uint_ispos(v : VectorUint*) : LibC::Int
  fun vector_uint_isneg = gsl_vector_uint_isneg(v : VectorUint*) : LibC::Int
  fun vector_uint_isnonneg = gsl_vector_uint_isnonneg(v : VectorUint*) : LibC::Int
  fun vector_uint_get = gsl_vector_uint_get(v : VectorUint*, i : LibC::SizeT) : LibC::UInt
  fun vector_uint_set = gsl_vector_uint_set(v : VectorUint*, i : LibC::SizeT, x : LibC::UInt)
  fun vector_uint_ptr = gsl_vector_uint_ptr(v : VectorUint*, i : LibC::SizeT) : LibC::UInt*
  fun vector_uint_const_ptr = gsl_vector_uint_const_ptr(v : VectorUint*, i : LibC::SizeT) : LibC::UInt*

  struct BlockIntStruct
    size : LibC::SizeT
    data : LibC::Int*
  end

  fun block_int_alloc = gsl_block_int_alloc(n : LibC::SizeT) : BlockInt*
  type BlockInt = BlockIntStruct
  fun block_int_calloc = gsl_block_int_calloc(n : LibC::SizeT) : BlockInt*
  fun block_int_free = gsl_block_int_free(b : BlockInt*)
  fun block_int_fread = gsl_block_int_fread(stream : File*, b : BlockInt*) : LibC::Int
  fun block_int_fwrite = gsl_block_int_fwrite(stream : File*, b : BlockInt*) : LibC::Int
  fun block_int_fscanf = gsl_block_int_fscanf(stream : File*, b : BlockInt*) : LibC::Int
  fun block_int_fprintf = gsl_block_int_fprintf(stream : File*, b : BlockInt*, format : LibC::Char*) : LibC::Int
  fun block_int_raw_fread = gsl_block_int_raw_fread(stream : File*, b : LibC::Int*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_int_raw_fwrite = gsl_block_int_raw_fwrite(stream : File*, b : LibC::Int*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_int_raw_fscanf = gsl_block_int_raw_fscanf(stream : File*, b : LibC::Int*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_int_raw_fprintf = gsl_block_int_raw_fprintf(stream : File*, b : LibC::Int*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_int_size = gsl_block_int_size(b : BlockInt*) : LibC::SizeT
  fun block_int_data = gsl_block_int_data(b : BlockInt*) : LibC::Int*
  fun vector_int_alloc = gsl_vector_int_alloc(n : LibC::SizeT) : VectorInt*

  struct VectorInt
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::Int*
    block : BlockInt*
    owner : LibC::Int
  end

  fun vector_int_calloc = gsl_vector_int_calloc(n : LibC::SizeT) : VectorInt*
  fun vector_int_alloc_from_block = gsl_vector_int_alloc_from_block(b : BlockInt*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorInt*
  fun vector_int_alloc_from_vector = gsl_vector_int_alloc_from_vector(v : VectorInt*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorInt*
  fun vector_int_free = gsl_vector_int_free(v : VectorInt*)
  fun vector_int_view_array = gsl_vector_int_view_array(v : LibC::Int*, n : LibC::SizeT) : X_GslVectorIntView

  struct X_GslVectorIntView
    vector : VectorInt
  end

  fun vector_int_view_array_with_stride = gsl_vector_int_view_array_with_stride(base : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntView
  fun vector_int_const_view_array = gsl_vector_int_const_view_array(v : LibC::Int*, n : LibC::SizeT) : X_GslVectorIntConstView

  struct X_GslVectorIntConstView
    vector : VectorInt
  end

  fun vector_int_const_view_array_with_stride = gsl_vector_int_const_view_array_with_stride(base : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntConstView
  fun vector_int_subvector = gsl_vector_int_subvector(v : VectorInt*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntView
  fun vector_int_subvector_with_stride = gsl_vector_int_subvector_with_stride(v : VectorInt*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntView
  fun vector_int_const_subvector = gsl_vector_int_const_subvector(v : VectorInt*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntConstView
  fun vector_int_const_subvector_with_stride = gsl_vector_int_const_subvector_with_stride(v : VectorInt*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntConstView
  fun vector_int_set_zero = gsl_vector_int_set_zero(v : VectorInt*)
  fun vector_int_set_all = gsl_vector_int_set_all(v : VectorInt*, x : LibC::Int)
  fun vector_int_set_basis = gsl_vector_int_set_basis(v : VectorInt*, i : LibC::SizeT) : LibC::Int
  fun vector_int_fread = gsl_vector_int_fread(stream : File*, v : VectorInt*) : LibC::Int
  fun vector_int_fwrite = gsl_vector_int_fwrite(stream : File*, v : VectorInt*) : LibC::Int
  fun vector_int_fscanf = gsl_vector_int_fscanf(stream : File*, v : VectorInt*) : LibC::Int
  fun vector_int_fprintf = gsl_vector_int_fprintf(stream : File*, v : VectorInt*, format : LibC::Char*) : LibC::Int
  fun vector_int_memcpy = gsl_vector_int_memcpy(dest : VectorInt*, src : VectorInt*) : LibC::Int
  fun vector_int_reverse = gsl_vector_int_reverse(v : VectorInt*) : LibC::Int
  fun vector_int_swap = gsl_vector_int_swap(v : VectorInt*, w : VectorInt*) : LibC::Int
  fun vector_int_swap_elements = gsl_vector_int_swap_elements(v : VectorInt*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_int_max = gsl_vector_int_max(v : VectorInt*) : LibC::Int
  fun vector_int_min = gsl_vector_int_min(v : VectorInt*) : LibC::Int
  fun vector_int_minmax = gsl_vector_int_minmax(v : VectorInt*, min_out : LibC::Int*, max_out : LibC::Int*)
  fun vector_int_max_index = gsl_vector_int_max_index(v : VectorInt*) : LibC::SizeT
  fun vector_int_min_index = gsl_vector_int_min_index(v : VectorInt*) : LibC::SizeT
  fun vector_int_minmax_index = gsl_vector_int_minmax_index(v : VectorInt*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_int_add = gsl_vector_int_add(a : VectorInt*, b : VectorInt*) : LibC::Int
  fun vector_int_sub = gsl_vector_int_sub(a : VectorInt*, b : VectorInt*) : LibC::Int
  fun vector_int_mul = gsl_vector_int_mul(a : VectorInt*, b : VectorInt*) : LibC::Int
  fun vector_int_div = gsl_vector_int_div(a : VectorInt*, b : VectorInt*) : LibC::Int
  fun vector_int_scale = gsl_vector_int_scale(a : VectorInt*, x : LibC::Double) : LibC::Int
  fun vector_int_add_constant = gsl_vector_int_add_constant(a : VectorInt*, x : LibC::Double) : LibC::Int
  fun vector_int_equal = gsl_vector_int_equal(u : VectorInt*, v : VectorInt*) : LibC::Int
  fun vector_int_isnull = gsl_vector_int_isnull(v : VectorInt*) : LibC::Int
  fun vector_int_ispos = gsl_vector_int_ispos(v : VectorInt*) : LibC::Int
  fun vector_int_isneg = gsl_vector_int_isneg(v : VectorInt*) : LibC::Int
  fun vector_int_isnonneg = gsl_vector_int_isnonneg(v : VectorInt*) : LibC::Int
  fun vector_int_get = gsl_vector_int_get(v : VectorInt*, i : LibC::SizeT) : LibC::Int
  fun vector_int_set = gsl_vector_int_set(v : VectorInt*, i : LibC::SizeT, x : LibC::Int)
  fun vector_int_ptr = gsl_vector_int_ptr(v : VectorInt*, i : LibC::SizeT) : LibC::Int*
  fun vector_int_const_ptr = gsl_vector_int_const_ptr(v : VectorInt*, i : LibC::SizeT) : LibC::Int*

  struct BlockUshortStruct
    size : LibC::SizeT
    data : LibC::UShort*
  end

  fun block_ushort_alloc = gsl_block_ushort_alloc(n : LibC::SizeT) : BlockUshort*
  type BlockUshort = BlockUshortStruct
  fun block_ushort_calloc = gsl_block_ushort_calloc(n : LibC::SizeT) : BlockUshort*
  fun block_ushort_free = gsl_block_ushort_free(b : BlockUshort*)
  fun block_ushort_fread = gsl_block_ushort_fread(stream : File*, b : BlockUshort*) : LibC::Int
  fun block_ushort_fwrite = gsl_block_ushort_fwrite(stream : File*, b : BlockUshort*) : LibC::Int
  fun block_ushort_fscanf = gsl_block_ushort_fscanf(stream : File*, b : BlockUshort*) : LibC::Int
  fun block_ushort_fprintf = gsl_block_ushort_fprintf(stream : File*, b : BlockUshort*, format : LibC::Char*) : LibC::Int
  fun block_ushort_raw_fread = gsl_block_ushort_raw_fread(stream : File*, b : LibC::UShort*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_ushort_raw_fwrite = gsl_block_ushort_raw_fwrite(stream : File*, b : LibC::UShort*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_ushort_raw_fscanf = gsl_block_ushort_raw_fscanf(stream : File*, b : LibC::UShort*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_ushort_raw_fprintf = gsl_block_ushort_raw_fprintf(stream : File*, b : LibC::UShort*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_ushort_size = gsl_block_ushort_size(b : BlockUshort*) : LibC::SizeT
  fun block_ushort_data = gsl_block_ushort_data(b : BlockUshort*) : LibC::UShort*
  fun vector_ushort_alloc = gsl_vector_ushort_alloc(n : LibC::SizeT) : VectorUshort*

  struct VectorUshort
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::UShort*
    block : BlockUshort*
    owner : LibC::Int
  end

  fun vector_ushort_calloc = gsl_vector_ushort_calloc(n : LibC::SizeT) : VectorUshort*
  fun vector_ushort_alloc_from_block = gsl_vector_ushort_alloc_from_block(b : BlockUshort*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorUshort*
  fun vector_ushort_alloc_from_vector = gsl_vector_ushort_alloc_from_vector(v : VectorUshort*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorUshort*
  fun vector_ushort_free = gsl_vector_ushort_free(v : VectorUshort*)
  fun vector_ushort_view_array = gsl_vector_ushort_view_array(v : LibC::UShort*, n : LibC::SizeT) : X_GslVectorUshortView

  struct X_GslVectorUshortView
    vector : VectorUshort
  end

  fun vector_ushort_view_array_with_stride = gsl_vector_ushort_view_array_with_stride(base : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortView
  fun vector_ushort_const_view_array = gsl_vector_ushort_const_view_array(v : LibC::UShort*, n : LibC::SizeT) : X_GslVectorUshortConstView

  struct X_GslVectorUshortConstView
    vector : VectorUshort
  end

  fun vector_ushort_const_view_array_with_stride = gsl_vector_ushort_const_view_array_with_stride(base : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortConstView
  fun vector_ushort_subvector = gsl_vector_ushort_subvector(v : VectorUshort*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortView
  fun vector_ushort_subvector_with_stride = gsl_vector_ushort_subvector_with_stride(v : VectorUshort*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortView
  fun vector_ushort_const_subvector = gsl_vector_ushort_const_subvector(v : VectorUshort*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortConstView
  fun vector_ushort_const_subvector_with_stride = gsl_vector_ushort_const_subvector_with_stride(v : VectorUshort*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortConstView
  fun vector_ushort_set_zero = gsl_vector_ushort_set_zero(v : VectorUshort*)
  fun vector_ushort_set_all = gsl_vector_ushort_set_all(v : VectorUshort*, x : LibC::UShort)
  fun vector_ushort_set_basis = gsl_vector_ushort_set_basis(v : VectorUshort*, i : LibC::SizeT) : LibC::Int
  fun vector_ushort_fread = gsl_vector_ushort_fread(stream : File*, v : VectorUshort*) : LibC::Int
  fun vector_ushort_fwrite = gsl_vector_ushort_fwrite(stream : File*, v : VectorUshort*) : LibC::Int
  fun vector_ushort_fscanf = gsl_vector_ushort_fscanf(stream : File*, v : VectorUshort*) : LibC::Int
  fun vector_ushort_fprintf = gsl_vector_ushort_fprintf(stream : File*, v : VectorUshort*, format : LibC::Char*) : LibC::Int
  fun vector_ushort_memcpy = gsl_vector_ushort_memcpy(dest : VectorUshort*, src : VectorUshort*) : LibC::Int
  fun vector_ushort_reverse = gsl_vector_ushort_reverse(v : VectorUshort*) : LibC::Int
  fun vector_ushort_swap = gsl_vector_ushort_swap(v : VectorUshort*, w : VectorUshort*) : LibC::Int
  fun vector_ushort_swap_elements = gsl_vector_ushort_swap_elements(v : VectorUshort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_ushort_max = gsl_vector_ushort_max(v : VectorUshort*) : LibC::UShort
  fun vector_ushort_min = gsl_vector_ushort_min(v : VectorUshort*) : LibC::UShort
  fun vector_ushort_minmax = gsl_vector_ushort_minmax(v : VectorUshort*, min_out : LibC::UShort*, max_out : LibC::UShort*)
  fun vector_ushort_max_index = gsl_vector_ushort_max_index(v : VectorUshort*) : LibC::SizeT
  fun vector_ushort_min_index = gsl_vector_ushort_min_index(v : VectorUshort*) : LibC::SizeT
  fun vector_ushort_minmax_index = gsl_vector_ushort_minmax_index(v : VectorUshort*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_ushort_add = gsl_vector_ushort_add(a : VectorUshort*, b : VectorUshort*) : LibC::Int
  fun vector_ushort_sub = gsl_vector_ushort_sub(a : VectorUshort*, b : VectorUshort*) : LibC::Int
  fun vector_ushort_mul = gsl_vector_ushort_mul(a : VectorUshort*, b : VectorUshort*) : LibC::Int
  fun vector_ushort_div = gsl_vector_ushort_div(a : VectorUshort*, b : VectorUshort*) : LibC::Int
  fun vector_ushort_scale = gsl_vector_ushort_scale(a : VectorUshort*, x : LibC::Double) : LibC::Int
  fun vector_ushort_add_constant = gsl_vector_ushort_add_constant(a : VectorUshort*, x : LibC::Double) : LibC::Int
  fun vector_ushort_equal = gsl_vector_ushort_equal(u : VectorUshort*, v : VectorUshort*) : LibC::Int
  fun vector_ushort_isnull = gsl_vector_ushort_isnull(v : VectorUshort*) : LibC::Int
  fun vector_ushort_ispos = gsl_vector_ushort_ispos(v : VectorUshort*) : LibC::Int
  fun vector_ushort_isneg = gsl_vector_ushort_isneg(v : VectorUshort*) : LibC::Int
  fun vector_ushort_isnonneg = gsl_vector_ushort_isnonneg(v : VectorUshort*) : LibC::Int
  fun vector_ushort_get = gsl_vector_ushort_get(v : VectorUshort*, i : LibC::SizeT) : LibC::UShort
  fun vector_ushort_set = gsl_vector_ushort_set(v : VectorUshort*, i : LibC::SizeT, x : LibC::UShort)
  fun vector_ushort_ptr = gsl_vector_ushort_ptr(v : VectorUshort*, i : LibC::SizeT) : LibC::UShort*
  fun vector_ushort_const_ptr = gsl_vector_ushort_const_ptr(v : VectorUshort*, i : LibC::SizeT) : LibC::UShort*

  struct BlockShortStruct
    size : LibC::SizeT
    data : LibC::Short*
  end

  fun block_short_alloc = gsl_block_short_alloc(n : LibC::SizeT) : BlockShort*
  type BlockShort = BlockShortStruct
  fun block_short_calloc = gsl_block_short_calloc(n : LibC::SizeT) : BlockShort*
  fun block_short_free = gsl_block_short_free(b : BlockShort*)
  fun block_short_fread = gsl_block_short_fread(stream : File*, b : BlockShort*) : LibC::Int
  fun block_short_fwrite = gsl_block_short_fwrite(stream : File*, b : BlockShort*) : LibC::Int
  fun block_short_fscanf = gsl_block_short_fscanf(stream : File*, b : BlockShort*) : LibC::Int
  fun block_short_fprintf = gsl_block_short_fprintf(stream : File*, b : BlockShort*, format : LibC::Char*) : LibC::Int
  fun block_short_raw_fread = gsl_block_short_raw_fread(stream : File*, b : LibC::Short*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_short_raw_fwrite = gsl_block_short_raw_fwrite(stream : File*, b : LibC::Short*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_short_raw_fscanf = gsl_block_short_raw_fscanf(stream : File*, b : LibC::Short*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_short_raw_fprintf = gsl_block_short_raw_fprintf(stream : File*, b : LibC::Short*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_short_size = gsl_block_short_size(b : BlockShort*) : LibC::SizeT
  fun block_short_data = gsl_block_short_data(b : BlockShort*) : LibC::Short*
  fun vector_short_alloc = gsl_vector_short_alloc(n : LibC::SizeT) : VectorShort*

  struct VectorShort
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::Short*
    block : BlockShort*
    owner : LibC::Int
  end

  fun vector_short_calloc = gsl_vector_short_calloc(n : LibC::SizeT) : VectorShort*
  fun vector_short_alloc_from_block = gsl_vector_short_alloc_from_block(b : BlockShort*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorShort*
  fun vector_short_alloc_from_vector = gsl_vector_short_alloc_from_vector(v : VectorShort*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorShort*
  fun vector_short_free = gsl_vector_short_free(v : VectorShort*)
  fun vector_short_view_array = gsl_vector_short_view_array(v : LibC::Short*, n : LibC::SizeT) : X_GslVectorShortView

  struct X_GslVectorShortView
    vector : VectorShort
  end

  fun vector_short_view_array_with_stride = gsl_vector_short_view_array_with_stride(base : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortView
  fun vector_short_const_view_array = gsl_vector_short_const_view_array(v : LibC::Short*, n : LibC::SizeT) : X_GslVectorShortConstView

  struct X_GslVectorShortConstView
    vector : VectorShort
  end

  fun vector_short_const_view_array_with_stride = gsl_vector_short_const_view_array_with_stride(base : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortConstView
  fun vector_short_subvector = gsl_vector_short_subvector(v : VectorShort*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortView
  fun vector_short_subvector_with_stride = gsl_vector_short_subvector_with_stride(v : VectorShort*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortView
  fun vector_short_const_subvector = gsl_vector_short_const_subvector(v : VectorShort*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortConstView
  fun vector_short_const_subvector_with_stride = gsl_vector_short_const_subvector_with_stride(v : VectorShort*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortConstView
  fun vector_short_set_zero = gsl_vector_short_set_zero(v : VectorShort*)
  fun vector_short_set_all = gsl_vector_short_set_all(v : VectorShort*, x : LibC::Short)
  fun vector_short_set_basis = gsl_vector_short_set_basis(v : VectorShort*, i : LibC::SizeT) : LibC::Int
  fun vector_short_fread = gsl_vector_short_fread(stream : File*, v : VectorShort*) : LibC::Int
  fun vector_short_fwrite = gsl_vector_short_fwrite(stream : File*, v : VectorShort*) : LibC::Int
  fun vector_short_fscanf = gsl_vector_short_fscanf(stream : File*, v : VectorShort*) : LibC::Int
  fun vector_short_fprintf = gsl_vector_short_fprintf(stream : File*, v : VectorShort*, format : LibC::Char*) : LibC::Int
  fun vector_short_memcpy = gsl_vector_short_memcpy(dest : VectorShort*, src : VectorShort*) : LibC::Int
  fun vector_short_reverse = gsl_vector_short_reverse(v : VectorShort*) : LibC::Int
  fun vector_short_swap = gsl_vector_short_swap(v : VectorShort*, w : VectorShort*) : LibC::Int
  fun vector_short_swap_elements = gsl_vector_short_swap_elements(v : VectorShort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_short_max = gsl_vector_short_max(v : VectorShort*) : LibC::Short
  fun vector_short_min = gsl_vector_short_min(v : VectorShort*) : LibC::Short
  fun vector_short_minmax = gsl_vector_short_minmax(v : VectorShort*, min_out : LibC::Short*, max_out : LibC::Short*)
  fun vector_short_max_index = gsl_vector_short_max_index(v : VectorShort*) : LibC::SizeT
  fun vector_short_min_index = gsl_vector_short_min_index(v : VectorShort*) : LibC::SizeT
  fun vector_short_minmax_index = gsl_vector_short_minmax_index(v : VectorShort*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_short_add = gsl_vector_short_add(a : VectorShort*, b : VectorShort*) : LibC::Int
  fun vector_short_sub = gsl_vector_short_sub(a : VectorShort*, b : VectorShort*) : LibC::Int
  fun vector_short_mul = gsl_vector_short_mul(a : VectorShort*, b : VectorShort*) : LibC::Int
  fun vector_short_div = gsl_vector_short_div(a : VectorShort*, b : VectorShort*) : LibC::Int
  fun vector_short_scale = gsl_vector_short_scale(a : VectorShort*, x : LibC::Double) : LibC::Int
  fun vector_short_add_constant = gsl_vector_short_add_constant(a : VectorShort*, x : LibC::Double) : LibC::Int
  fun vector_short_equal = gsl_vector_short_equal(u : VectorShort*, v : VectorShort*) : LibC::Int
  fun vector_short_isnull = gsl_vector_short_isnull(v : VectorShort*) : LibC::Int
  fun vector_short_ispos = gsl_vector_short_ispos(v : VectorShort*) : LibC::Int
  fun vector_short_isneg = gsl_vector_short_isneg(v : VectorShort*) : LibC::Int
  fun vector_short_isnonneg = gsl_vector_short_isnonneg(v : VectorShort*) : LibC::Int
  fun vector_short_get = gsl_vector_short_get(v : VectorShort*, i : LibC::SizeT) : LibC::Short
  fun vector_short_set = gsl_vector_short_set(v : VectorShort*, i : LibC::SizeT, x : LibC::Short)
  fun vector_short_ptr = gsl_vector_short_ptr(v : VectorShort*, i : LibC::SizeT) : LibC::Short*
  fun vector_short_const_ptr = gsl_vector_short_const_ptr(v : VectorShort*, i : LibC::SizeT) : LibC::Short*

  struct BlockUcharStruct
    size : LibC::SizeT
    data : UInt8*
  end

  fun block_uchar_alloc = gsl_block_uchar_alloc(n : LibC::SizeT) : BlockUchar*
  type BlockUchar = BlockUcharStruct
  fun block_uchar_calloc = gsl_block_uchar_calloc(n : LibC::SizeT) : BlockUchar*
  fun block_uchar_free = gsl_block_uchar_free(b : BlockUchar*)
  fun block_uchar_fread = gsl_block_uchar_fread(stream : File*, b : BlockUchar*) : LibC::Int
  fun block_uchar_fwrite = gsl_block_uchar_fwrite(stream : File*, b : BlockUchar*) : LibC::Int
  fun block_uchar_fscanf = gsl_block_uchar_fscanf(stream : File*, b : BlockUchar*) : LibC::Int
  fun block_uchar_fprintf = gsl_block_uchar_fprintf(stream : File*, b : BlockUchar*, format : LibC::Char*) : LibC::Int
  fun block_uchar_raw_fread = gsl_block_uchar_raw_fread(stream : File*, b : UInt8*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_uchar_raw_fwrite = gsl_block_uchar_raw_fwrite(stream : File*, b : UInt8*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_uchar_raw_fscanf = gsl_block_uchar_raw_fscanf(stream : File*, b : UInt8*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_uchar_raw_fprintf = gsl_block_uchar_raw_fprintf(stream : File*, b : UInt8*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_uchar_size = gsl_block_uchar_size(b : BlockUchar*) : LibC::SizeT
  fun block_uchar_data = gsl_block_uchar_data(b : BlockUchar*) : UInt8*
  fun vector_uchar_alloc = gsl_vector_uchar_alloc(n : LibC::SizeT) : VectorUchar*

  struct VectorUchar
    size : LibC::SizeT
    stride : LibC::SizeT
    data : UInt8*
    block : BlockUchar*
    owner : LibC::Int
  end

  fun vector_uchar_calloc = gsl_vector_uchar_calloc(n : LibC::SizeT) : VectorUchar*
  fun vector_uchar_alloc_from_block = gsl_vector_uchar_alloc_from_block(b : BlockUchar*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorUchar*
  fun vector_uchar_alloc_from_vector = gsl_vector_uchar_alloc_from_vector(v : VectorUchar*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorUchar*
  fun vector_uchar_free = gsl_vector_uchar_free(v : VectorUchar*)
  fun vector_uchar_view_array = gsl_vector_uchar_view_array(v : UInt8*, n : LibC::SizeT) : X_GslVectorUcharView

  struct X_GslVectorUcharView
    vector : VectorUchar
  end

  fun vector_uchar_view_array_with_stride = gsl_vector_uchar_view_array_with_stride(base : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharView
  fun vector_uchar_const_view_array = gsl_vector_uchar_const_view_array(v : UInt8*, n : LibC::SizeT) : X_GslVectorUcharConstView

  struct X_GslVectorUcharConstView
    vector : VectorUchar
  end

  fun vector_uchar_const_view_array_with_stride = gsl_vector_uchar_const_view_array_with_stride(base : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharConstView
  fun vector_uchar_subvector = gsl_vector_uchar_subvector(v : VectorUchar*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharView
  fun vector_uchar_subvector_with_stride = gsl_vector_uchar_subvector_with_stride(v : VectorUchar*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharView
  fun vector_uchar_const_subvector = gsl_vector_uchar_const_subvector(v : VectorUchar*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharConstView
  fun vector_uchar_const_subvector_with_stride = gsl_vector_uchar_const_subvector_with_stride(v : VectorUchar*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharConstView
  fun vector_uchar_set_zero = gsl_vector_uchar_set_zero(v : VectorUchar*)
  fun vector_uchar_set_all = gsl_vector_uchar_set_all(v : VectorUchar*, x : UInt8)
  fun vector_uchar_set_basis = gsl_vector_uchar_set_basis(v : VectorUchar*, i : LibC::SizeT) : LibC::Int
  fun vector_uchar_fread = gsl_vector_uchar_fread(stream : File*, v : VectorUchar*) : LibC::Int
  fun vector_uchar_fwrite = gsl_vector_uchar_fwrite(stream : File*, v : VectorUchar*) : LibC::Int
  fun vector_uchar_fscanf = gsl_vector_uchar_fscanf(stream : File*, v : VectorUchar*) : LibC::Int
  fun vector_uchar_fprintf = gsl_vector_uchar_fprintf(stream : File*, v : VectorUchar*, format : LibC::Char*) : LibC::Int
  fun vector_uchar_memcpy = gsl_vector_uchar_memcpy(dest : VectorUchar*, src : VectorUchar*) : LibC::Int
  fun vector_uchar_reverse = gsl_vector_uchar_reverse(v : VectorUchar*) : LibC::Int
  fun vector_uchar_swap = gsl_vector_uchar_swap(v : VectorUchar*, w : VectorUchar*) : LibC::Int
  fun vector_uchar_swap_elements = gsl_vector_uchar_swap_elements(v : VectorUchar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_uchar_max = gsl_vector_uchar_max(v : VectorUchar*) : UInt8
  fun vector_uchar_min = gsl_vector_uchar_min(v : VectorUchar*) : UInt8
  fun vector_uchar_minmax = gsl_vector_uchar_minmax(v : VectorUchar*, min_out : UInt8*, max_out : UInt8*)
  fun vector_uchar_max_index = gsl_vector_uchar_max_index(v : VectorUchar*) : LibC::SizeT
  fun vector_uchar_min_index = gsl_vector_uchar_min_index(v : VectorUchar*) : LibC::SizeT
  fun vector_uchar_minmax_index = gsl_vector_uchar_minmax_index(v : VectorUchar*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_uchar_add = gsl_vector_uchar_add(a : VectorUchar*, b : VectorUchar*) : LibC::Int
  fun vector_uchar_sub = gsl_vector_uchar_sub(a : VectorUchar*, b : VectorUchar*) : LibC::Int
  fun vector_uchar_mul = gsl_vector_uchar_mul(a : VectorUchar*, b : VectorUchar*) : LibC::Int
  fun vector_uchar_div = gsl_vector_uchar_div(a : VectorUchar*, b : VectorUchar*) : LibC::Int
  fun vector_uchar_scale = gsl_vector_uchar_scale(a : VectorUchar*, x : LibC::Double) : LibC::Int
  fun vector_uchar_add_constant = gsl_vector_uchar_add_constant(a : VectorUchar*, x : LibC::Double) : LibC::Int
  fun vector_uchar_equal = gsl_vector_uchar_equal(u : VectorUchar*, v : VectorUchar*) : LibC::Int
  fun vector_uchar_isnull = gsl_vector_uchar_isnull(v : VectorUchar*) : LibC::Int
  fun vector_uchar_ispos = gsl_vector_uchar_ispos(v : VectorUchar*) : LibC::Int
  fun vector_uchar_isneg = gsl_vector_uchar_isneg(v : VectorUchar*) : LibC::Int
  fun vector_uchar_isnonneg = gsl_vector_uchar_isnonneg(v : VectorUchar*) : LibC::Int
  fun vector_uchar_get = gsl_vector_uchar_get(v : VectorUchar*, i : LibC::SizeT) : UInt8
  fun vector_uchar_set = gsl_vector_uchar_set(v : VectorUchar*, i : LibC::SizeT, x : UInt8)
  fun vector_uchar_ptr = gsl_vector_uchar_ptr(v : VectorUchar*, i : LibC::SizeT) : UInt8*
  fun vector_uchar_const_ptr = gsl_vector_uchar_const_ptr(v : VectorUchar*, i : LibC::SizeT) : UInt8*

  struct BlockCharStruct
    size : LibC::SizeT
    data : LibC::Char*
  end

  fun block_char_alloc = gsl_block_char_alloc(n : LibC::SizeT) : BlockChar*
  type BlockChar = BlockCharStruct
  fun block_char_calloc = gsl_block_char_calloc(n : LibC::SizeT) : BlockChar*
  fun block_char_free = gsl_block_char_free(b : BlockChar*)
  fun block_char_fread = gsl_block_char_fread(stream : File*, b : BlockChar*) : LibC::Int
  fun block_char_fwrite = gsl_block_char_fwrite(stream : File*, b : BlockChar*) : LibC::Int
  fun block_char_fscanf = gsl_block_char_fscanf(stream : File*, b : BlockChar*) : LibC::Int
  fun block_char_fprintf = gsl_block_char_fprintf(stream : File*, b : BlockChar*, format : LibC::Char*) : LibC::Int
  fun block_char_raw_fread = gsl_block_char_raw_fread(stream : File*, b : LibC::Char*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_char_raw_fwrite = gsl_block_char_raw_fwrite(stream : File*, b : LibC::Char*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_char_raw_fscanf = gsl_block_char_raw_fscanf(stream : File*, b : LibC::Char*, n : LibC::SizeT, stride : LibC::SizeT) : LibC::Int
  fun block_char_raw_fprintf = gsl_block_char_raw_fprintf(stream : File*, b : LibC::Char*, n : LibC::SizeT, stride : LibC::SizeT, format : LibC::Char*) : LibC::Int
  fun block_char_size = gsl_block_char_size(b : BlockChar*) : LibC::SizeT
  fun block_char_data = gsl_block_char_data(b : BlockChar*) : LibC::Char*
  fun vector_char_alloc = gsl_vector_char_alloc(n : LibC::SizeT) : VectorChar*

  struct VectorChar
    size : LibC::SizeT
    stride : LibC::SizeT
    data : LibC::Char*
    block : BlockChar*
    owner : LibC::Int
  end

  fun vector_char_calloc = gsl_vector_char_calloc(n : LibC::SizeT) : VectorChar*
  fun vector_char_alloc_from_block = gsl_vector_char_alloc_from_block(b : BlockChar*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorChar*
  fun vector_char_alloc_from_vector = gsl_vector_char_alloc_from_vector(v : VectorChar*, offset : LibC::SizeT, n : LibC::SizeT, stride : LibC::SizeT) : VectorChar*
  fun vector_char_free = gsl_vector_char_free(v : VectorChar*)
  fun vector_char_view_array = gsl_vector_char_view_array(v : LibC::Char*, n : LibC::SizeT) : X_GslVectorCharView

  struct X_GslVectorCharView
    vector : VectorChar
  end

  fun vector_char_view_array_with_stride = gsl_vector_char_view_array_with_stride(base : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharView
  fun vector_char_const_view_array = gsl_vector_char_const_view_array(v : LibC::Char*, n : LibC::SizeT) : X_GslVectorCharConstView

  struct X_GslVectorCharConstView
    vector : VectorChar
  end

  fun vector_char_const_view_array_with_stride = gsl_vector_char_const_view_array_with_stride(base : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharConstView
  fun vector_char_subvector = gsl_vector_char_subvector(v : VectorChar*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharView
  fun vector_char_subvector_with_stride = gsl_vector_char_subvector_with_stride(v : VectorChar*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharView
  fun vector_char_const_subvector = gsl_vector_char_const_subvector(v : VectorChar*, i : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharConstView
  fun vector_char_const_subvector_with_stride = gsl_vector_char_const_subvector_with_stride(v : VectorChar*, i : LibC::SizeT, stride : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharConstView
  fun vector_char_set_zero = gsl_vector_char_set_zero(v : VectorChar*)
  fun vector_char_set_all = gsl_vector_char_set_all(v : VectorChar*, x : LibC::Char)
  fun vector_char_set_basis = gsl_vector_char_set_basis(v : VectorChar*, i : LibC::SizeT) : LibC::Int
  fun vector_char_fread = gsl_vector_char_fread(stream : File*, v : VectorChar*) : LibC::Int
  fun vector_char_fwrite = gsl_vector_char_fwrite(stream : File*, v : VectorChar*) : LibC::Int
  fun vector_char_fscanf = gsl_vector_char_fscanf(stream : File*, v : VectorChar*) : LibC::Int
  fun vector_char_fprintf = gsl_vector_char_fprintf(stream : File*, v : VectorChar*, format : LibC::Char*) : LibC::Int
  fun vector_char_memcpy = gsl_vector_char_memcpy(dest : VectorChar*, src : VectorChar*) : LibC::Int
  fun vector_char_reverse = gsl_vector_char_reverse(v : VectorChar*) : LibC::Int
  fun vector_char_swap = gsl_vector_char_swap(v : VectorChar*, w : VectorChar*) : LibC::Int
  fun vector_char_swap_elements = gsl_vector_char_swap_elements(v : VectorChar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun vector_char_max = gsl_vector_char_max(v : VectorChar*) : LibC::Char
  fun vector_char_min = gsl_vector_char_min(v : VectorChar*) : LibC::Char
  fun vector_char_minmax = gsl_vector_char_minmax(v : VectorChar*, min_out : LibC::Char*, max_out : LibC::Char*)
  fun vector_char_max_index = gsl_vector_char_max_index(v : VectorChar*) : LibC::SizeT
  fun vector_char_min_index = gsl_vector_char_min_index(v : VectorChar*) : LibC::SizeT
  fun vector_char_minmax_index = gsl_vector_char_minmax_index(v : VectorChar*, imin : LibC::SizeT*, imax : LibC::SizeT*)
  fun vector_char_add = gsl_vector_char_add(a : VectorChar*, b : VectorChar*) : LibC::Int
  fun vector_char_sub = gsl_vector_char_sub(a : VectorChar*, b : VectorChar*) : LibC::Int
  fun vector_char_mul = gsl_vector_char_mul(a : VectorChar*, b : VectorChar*) : LibC::Int
  fun vector_char_div = gsl_vector_char_div(a : VectorChar*, b : VectorChar*) : LibC::Int
  fun vector_char_scale = gsl_vector_char_scale(a : VectorChar*, x : LibC::Double) : LibC::Int
  fun vector_char_add_constant = gsl_vector_char_add_constant(a : VectorChar*, x : LibC::Double) : LibC::Int
  fun vector_char_equal = gsl_vector_char_equal(u : VectorChar*, v : VectorChar*) : LibC::Int
  fun vector_char_isnull = gsl_vector_char_isnull(v : VectorChar*) : LibC::Int
  fun vector_char_ispos = gsl_vector_char_ispos(v : VectorChar*) : LibC::Int
  fun vector_char_isneg = gsl_vector_char_isneg(v : VectorChar*) : LibC::Int
  fun vector_char_isnonneg = gsl_vector_char_isnonneg(v : VectorChar*) : LibC::Int
  fun vector_char_get = gsl_vector_char_get(v : VectorChar*, i : LibC::SizeT) : LibC::Char
  fun vector_char_set = gsl_vector_char_set(v : VectorChar*, i : LibC::SizeT, x : LibC::Char)
  fun vector_char_ptr = gsl_vector_char_ptr(v : VectorChar*, i : LibC::SizeT) : LibC::Char*
  fun vector_char_const_ptr = gsl_vector_char_const_ptr(v : VectorChar*, i : LibC::SizeT) : LibC::Char*
  # fun matrix_complex_long_double_alloc = gsl_matrix_complex_long_double_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplexLongDouble*
  #
  # struct MatrixComplexLongDouble
  #   size1 : LibC::SizeT
  #   size2 : LibC::SizeT
  #   tda : LibC::SizeT
  #   data : LibC::LongDouble*
  #   block : BlockComplexLongDouble*
  #   owner : LibC::Int
  # end
  #
  # fun matrix_complex_long_double_calloc = gsl_matrix_complex_long_double_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplexLongDouble*
  # fun matrix_complex_long_double_alloc_from_block = gsl_matrix_complex_long_double_alloc_from_block(b : BlockComplexLongDouble*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixComplexLongDouble*
  # fun matrix_complex_long_double_alloc_from_matrix = gsl_matrix_complex_long_double_alloc_from_matrix(b : MatrixComplexLongDouble*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplexLongDouble*
  # fun vector_complex_long_double_alloc_row_from_matrix = gsl_vector_complex_long_double_alloc_row_from_matrix(m : MatrixComplexLongDouble*, i : LibC::SizeT) : VectorComplexLongDouble*
  # fun vector_complex_long_double_alloc_col_from_matrix = gsl_vector_complex_long_double_alloc_col_from_matrix(m : MatrixComplexLongDouble*, j : LibC::SizeT) : VectorComplexLongDouble*
  # fun matrix_complex_long_double_free = gsl_matrix_complex_long_double_free(m : MatrixComplexLongDouble*)
  # fun matrix_complex_long_double_submatrix = gsl_matrix_complex_long_double_submatrix(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexLongDoubleView
  #
  # struct X_GslMatrixComplexLongDoubleView
  #   matrix : MatrixComplexLongDouble
  # end
  #
  # fun matrix_complex_long_double_row = gsl_matrix_complex_long_double_row(m : MatrixComplexLongDouble*, i : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun matrix_complex_long_double_column = gsl_matrix_complex_long_double_column(m : MatrixComplexLongDouble*, j : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun matrix_complex_long_double_diagonal = gsl_matrix_complex_long_double_diagonal(m : MatrixComplexLongDouble*) : X_GslVectorComplexLongDoubleView
  # fun matrix_complex_long_double_subdiagonal = gsl_matrix_complex_long_double_subdiagonal(m : MatrixComplexLongDouble*, k : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun matrix_complex_long_double_superdiagonal = gsl_matrix_complex_long_double_superdiagonal(m : MatrixComplexLongDouble*, k : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun matrix_complex_long_double_subrow = gsl_matrix_complex_long_double_subrow(m : MatrixComplexLongDouble*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun matrix_complex_long_double_subcolumn = gsl_matrix_complex_long_double_subcolumn(m : MatrixComplexLongDouble*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleView
  # fun matrix_complex_long_double_view_array = gsl_matrix_complex_long_double_view_array(base : LibC::LongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexLongDoubleView
  # fun matrix_complex_long_double_view_array_with_tda = gsl_matrix_complex_long_double_view_array_with_tda(base : LibC::LongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexLongDoubleView
  # fun matrix_complex_long_double_view_vector = gsl_matrix_complex_long_double_view_vector(v : VectorComplexLongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexLongDoubleView
  # fun matrix_complex_long_double_view_vector_with_tda = gsl_matrix_complex_long_double_view_vector_with_tda(v : VectorComplexLongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexLongDoubleView
  # fun matrix_complex_long_double_const_submatrix = gsl_matrix_complex_long_double_const_submatrix(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexLongDoubleConstView
  #
  # struct X_GslMatrixComplexLongDoubleConstView
  #   matrix : MatrixComplexLongDouble
  # end
  #
  # fun matrix_complex_long_double_const_row = gsl_matrix_complex_long_double_const_row(m : MatrixComplexLongDouble*, i : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_column = gsl_matrix_complex_long_double_const_column(m : MatrixComplexLongDouble*, j : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_diagonal = gsl_matrix_complex_long_double_const_diagonal(m : MatrixComplexLongDouble*) : X_GslVectorComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_subdiagonal = gsl_matrix_complex_long_double_const_subdiagonal(m : MatrixComplexLongDouble*, k : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_superdiagonal = gsl_matrix_complex_long_double_const_superdiagonal(m : MatrixComplexLongDouble*, k : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_subrow = gsl_matrix_complex_long_double_const_subrow(m : MatrixComplexLongDouble*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_subcolumn = gsl_matrix_complex_long_double_const_subcolumn(m : MatrixComplexLongDouble*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_view_array = gsl_matrix_complex_long_double_const_view_array(base : LibC::LongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_view_array_with_tda = gsl_matrix_complex_long_double_const_view_array_with_tda(base : LibC::LongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_view_vector = gsl_matrix_complex_long_double_const_view_vector(v : VectorComplexLongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexLongDoubleConstView
  # fun matrix_complex_long_double_const_view_vector_with_tda = gsl_matrix_complex_long_double_const_view_vector_with_tda(v : VectorComplexLongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexLongDoubleConstView
  # fun matrix_complex_long_double_set_zero = gsl_matrix_complex_long_double_set_zero(m : MatrixComplexLongDouble*)
  # fun matrix_complex_long_double_set_identity = gsl_matrix_complex_long_double_set_identity(m : MatrixComplexLongDouble*)
  # fun matrix_complex_long_double_set_all = gsl_matrix_complex_long_double_set_all(m : MatrixComplexLongDouble*, x : ComplexLongDouble)
  # fun matrix_complex_long_double_fread = gsl_matrix_complex_long_double_fread(stream : File*, m : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_fwrite = gsl_matrix_complex_long_double_fwrite(stream : File*, m : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_fscanf = gsl_matrix_complex_long_double_fscanf(stream : File*, m : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_fprintf = gsl_matrix_complex_long_double_fprintf(stream : File*, m : MatrixComplexLongDouble*, format : LibC::Char*) : LibC::Int
  # fun matrix_complex_long_double_memcpy = gsl_matrix_complex_long_double_memcpy(dest : MatrixComplexLongDouble*, src : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_swap = gsl_matrix_complex_long_double_swap(m1 : MatrixComplexLongDouble*, m2 : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_tricpy = gsl_matrix_complex_long_double_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixComplexLongDouble*, src : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_swap_rows = gsl_matrix_complex_long_double_swap_rows(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  # fun matrix_complex_long_double_swap_columns = gsl_matrix_complex_long_double_swap_columns(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  # fun matrix_complex_long_double_swap_rowcol = gsl_matrix_complex_long_double_swap_rowcol(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  # fun matrix_complex_long_double_transpose = gsl_matrix_complex_long_double_transpose(m : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_transpose_memcpy = gsl_matrix_complex_long_double_transpose_memcpy(dest : MatrixComplexLongDouble*, src : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_transpose_tricpy = gsl_matrix_complex_long_double_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixComplexLongDouble*, src : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_equal = gsl_matrix_complex_long_double_equal(a : MatrixComplexLongDouble*, b : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_isnull = gsl_matrix_complex_long_double_isnull(m : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_ispos = gsl_matrix_complex_long_double_ispos(m : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_isneg = gsl_matrix_complex_long_double_isneg(m : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_isnonneg = gsl_matrix_complex_long_double_isnonneg(m : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_add = gsl_matrix_complex_long_double_add(a : MatrixComplexLongDouble*, b : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_sub = gsl_matrix_complex_long_double_sub(a : MatrixComplexLongDouble*, b : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_mul_elements = gsl_matrix_complex_long_double_mul_elements(a : MatrixComplexLongDouble*, b : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_div_elements = gsl_matrix_complex_long_double_div_elements(a : MatrixComplexLongDouble*, b : MatrixComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_scale = gsl_matrix_complex_long_double_scale(a : MatrixComplexLongDouble*, x : ComplexLongDouble) : LibC::Int
  # fun matrix_complex_long_double_add_constant = gsl_matrix_complex_long_double_add_constant(a : MatrixComplexLongDouble*, x : ComplexLongDouble) : LibC::Int
  # fun matrix_complex_long_double_add_diagonal = gsl_matrix_complex_long_double_add_diagonal(a : MatrixComplexLongDouble*, x : ComplexLongDouble) : LibC::Int
  # fun matrix_complex_long_double_get_row = gsl_matrix_complex_long_double_get_row(v : VectorComplexLongDouble*, m : MatrixComplexLongDouble*, i : LibC::SizeT) : LibC::Int
  # fun matrix_complex_long_double_get_col = gsl_matrix_complex_long_double_get_col(v : VectorComplexLongDouble*, m : MatrixComplexLongDouble*, j : LibC::SizeT) : LibC::Int
  # fun matrix_complex_long_double_set_row = gsl_matrix_complex_long_double_set_row(m : MatrixComplexLongDouble*, i : LibC::SizeT, v : VectorComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_set_col = gsl_matrix_complex_long_double_set_col(m : MatrixComplexLongDouble*, j : LibC::SizeT, v : VectorComplexLongDouble*) : LibC::Int
  # fun matrix_complex_long_double_get = gsl_matrix_complex_long_double_get(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : ComplexLongDouble
  # fun matrix_complex_long_double_set = gsl_matrix_complex_long_double_set(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT, x : ComplexLongDouble)
  # fun matrix_complex_long_double_ptr = gsl_matrix_complex_long_double_ptr(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : ComplexLongDouble*
  # fun matrix_complex_long_double_const_ptr = gsl_matrix_complex_long_double_const_ptr(m : MatrixComplexLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : ComplexLongDouble*
  fun matrix_complex_alloc = gsl_matrix_complex_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplex*

  struct MatrixComplex
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::Double*
    block : BlockComplex*
    owner : LibC::Int
  end

  fun matrix_complex_calloc = gsl_matrix_complex_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplex*
  fun matrix_complex_alloc_from_block = gsl_matrix_complex_alloc_from_block(b : BlockComplex*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixComplex*
  fun matrix_complex_alloc_from_matrix = gsl_matrix_complex_alloc_from_matrix(b : MatrixComplex*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplex*
  fun vector_complex_alloc_row_from_matrix = gsl_vector_complex_alloc_row_from_matrix(m : MatrixComplex*, i : LibC::SizeT) : VectorComplex*
  fun vector_complex_alloc_col_from_matrix = gsl_vector_complex_alloc_col_from_matrix(m : MatrixComplex*, j : LibC::SizeT) : VectorComplex*
  fun matrix_complex_free = gsl_matrix_complex_free(m : MatrixComplex*)
  fun matrix_complex_submatrix = gsl_matrix_complex_submatrix(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexView

  struct X_GslMatrixComplexView
    matrix : MatrixComplex
  end

  fun matrix_complex_row = gsl_matrix_complex_row(m : MatrixComplex*, i : LibC::SizeT) : X_GslVectorComplexView
  fun matrix_complex_column = gsl_matrix_complex_column(m : MatrixComplex*, j : LibC::SizeT) : X_GslVectorComplexView
  fun matrix_complex_diagonal = gsl_matrix_complex_diagonal(m : MatrixComplex*) : X_GslVectorComplexView
  fun matrix_complex_subdiagonal = gsl_matrix_complex_subdiagonal(m : MatrixComplex*, k : LibC::SizeT) : X_GslVectorComplexView
  fun matrix_complex_superdiagonal = gsl_matrix_complex_superdiagonal(m : MatrixComplex*, k : LibC::SizeT) : X_GslVectorComplexView
  fun matrix_complex_subrow = gsl_matrix_complex_subrow(m : MatrixComplex*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexView
  fun matrix_complex_subcolumn = gsl_matrix_complex_subcolumn(m : MatrixComplex*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexView
  fun matrix_complex_view_array = gsl_matrix_complex_view_array(base : LibC::Double*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexView
  fun matrix_complex_view_array_with_tda = gsl_matrix_complex_view_array_with_tda(base : LibC::Double*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexView
  fun matrix_complex_view_vector = gsl_matrix_complex_view_vector(v : VectorComplex*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexView
  fun matrix_complex_view_vector_with_tda = gsl_matrix_complex_view_vector_with_tda(v : VectorComplex*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexView
  fun matrix_complex_const_submatrix = gsl_matrix_complex_const_submatrix(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexConstView

  struct X_GslMatrixComplexConstView
    matrix : MatrixComplex
  end

  fun matrix_complex_const_row = gsl_matrix_complex_const_row(m : MatrixComplex*, i : LibC::SizeT) : X_GslVectorComplexConstView
  fun matrix_complex_const_column = gsl_matrix_complex_const_column(m : MatrixComplex*, j : LibC::SizeT) : X_GslVectorComplexConstView
  fun matrix_complex_const_diagonal = gsl_matrix_complex_const_diagonal(m : MatrixComplex*) : X_GslVectorComplexConstView
  fun matrix_complex_const_subdiagonal = gsl_matrix_complex_const_subdiagonal(m : MatrixComplex*, k : LibC::SizeT) : X_GslVectorComplexConstView
  fun matrix_complex_const_superdiagonal = gsl_matrix_complex_const_superdiagonal(m : MatrixComplex*, k : LibC::SizeT) : X_GslVectorComplexConstView
  fun matrix_complex_const_subrow = gsl_matrix_complex_const_subrow(m : MatrixComplex*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexConstView
  fun matrix_complex_const_subcolumn = gsl_matrix_complex_const_subcolumn(m : MatrixComplex*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexConstView
  fun matrix_complex_const_view_array = gsl_matrix_complex_const_view_array(base : LibC::Double*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexConstView
  fun matrix_complex_const_view_array_with_tda = gsl_matrix_complex_const_view_array_with_tda(base : LibC::Double*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexConstView
  fun matrix_complex_const_view_vector = gsl_matrix_complex_const_view_vector(v : VectorComplex*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexConstView
  fun matrix_complex_const_view_vector_with_tda = gsl_matrix_complex_const_view_vector_with_tda(v : VectorComplex*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexConstView
  fun matrix_complex_set_zero = gsl_matrix_complex_set_zero(m : MatrixComplex*)
  fun matrix_complex_set_identity = gsl_matrix_complex_set_identity(m : MatrixComplex*)
  fun matrix_complex_set_all = gsl_matrix_complex_set_all(m : MatrixComplex*, x : Complex)
  fun matrix_complex_fread = gsl_matrix_complex_fread(stream : File*, m : MatrixComplex*) : LibC::Int
  fun matrix_complex_fwrite = gsl_matrix_complex_fwrite(stream : File*, m : MatrixComplex*) : LibC::Int
  fun matrix_complex_fscanf = gsl_matrix_complex_fscanf(stream : File*, m : MatrixComplex*) : LibC::Int
  fun matrix_complex_fprintf = gsl_matrix_complex_fprintf(stream : File*, m : MatrixComplex*, format : LibC::Char*) : LibC::Int
  fun matrix_complex_memcpy = gsl_matrix_complex_memcpy(dest : MatrixComplex*, src : MatrixComplex*) : LibC::Int
  fun matrix_complex_swap = gsl_matrix_complex_swap(m1 : MatrixComplex*, m2 : MatrixComplex*) : LibC::Int
  fun matrix_complex_tricpy = gsl_matrix_complex_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixComplex*, src : MatrixComplex*) : LibC::Int
  fun matrix_complex_swap_rows = gsl_matrix_complex_swap_rows(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_complex_swap_columns = gsl_matrix_complex_swap_columns(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_complex_swap_rowcol = gsl_matrix_complex_swap_rowcol(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_complex_transpose = gsl_matrix_complex_transpose(m : MatrixComplex*) : LibC::Int
  fun matrix_complex_transpose_memcpy = gsl_matrix_complex_transpose_memcpy(dest : MatrixComplex*, src : MatrixComplex*) : LibC::Int
  fun matrix_complex_transpose_tricpy = gsl_matrix_complex_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixComplex*, src : MatrixComplex*) : LibC::Int
  fun matrix_complex_equal = gsl_matrix_complex_equal(a : MatrixComplex*, b : MatrixComplex*) : LibC::Int
  fun matrix_complex_isnull = gsl_matrix_complex_isnull(m : MatrixComplex*) : LibC::Int
  fun matrix_complex_ispos = gsl_matrix_complex_ispos(m : MatrixComplex*) : LibC::Int
  fun matrix_complex_isneg = gsl_matrix_complex_isneg(m : MatrixComplex*) : LibC::Int
  fun matrix_complex_isnonneg = gsl_matrix_complex_isnonneg(m : MatrixComplex*) : LibC::Int
  fun matrix_complex_add = gsl_matrix_complex_add(a : MatrixComplex*, b : MatrixComplex*) : LibC::Int
  fun matrix_complex_sub = gsl_matrix_complex_sub(a : MatrixComplex*, b : MatrixComplex*) : LibC::Int
  fun matrix_complex_mul_elements = gsl_matrix_complex_mul_elements(a : MatrixComplex*, b : MatrixComplex*) : LibC::Int
  fun matrix_complex_div_elements = gsl_matrix_complex_div_elements(a : MatrixComplex*, b : MatrixComplex*) : LibC::Int
  fun matrix_complex_scale = gsl_matrix_complex_scale(a : MatrixComplex*, x : Complex) : LibC::Int
  fun matrix_complex_add_constant = gsl_matrix_complex_add_constant(a : MatrixComplex*, x : Complex) : LibC::Int
  fun matrix_complex_add_diagonal = gsl_matrix_complex_add_diagonal(a : MatrixComplex*, x : Complex) : LibC::Int
  fun matrix_complex_get_row = gsl_matrix_complex_get_row(v : VectorComplex*, m : MatrixComplex*, i : LibC::SizeT) : LibC::Int
  fun matrix_complex_get_col = gsl_matrix_complex_get_col(v : VectorComplex*, m : MatrixComplex*, j : LibC::SizeT) : LibC::Int
  fun matrix_complex_set_row = gsl_matrix_complex_set_row(m : MatrixComplex*, i : LibC::SizeT, v : VectorComplex*) : LibC::Int
  fun matrix_complex_set_col = gsl_matrix_complex_set_col(m : MatrixComplex*, j : LibC::SizeT, v : VectorComplex*) : LibC::Int
  fun matrix_complex_get = gsl_matrix_complex_get(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT) : Complex
  fun matrix_complex_set = gsl_matrix_complex_set(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT, x : Complex)
  fun matrix_complex_ptr = gsl_matrix_complex_ptr(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT) : Complex*
  fun matrix_complex_const_ptr = gsl_matrix_complex_const_ptr(m : MatrixComplex*, i : LibC::SizeT, j : LibC::SizeT) : Complex*
  fun matrix_complex_float_alloc = gsl_matrix_complex_float_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplexFloat*

  struct MatrixComplexFloat
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::Float*
    block : BlockComplexFloat*
    owner : LibC::Int
  end

  fun matrix_complex_float_calloc = gsl_matrix_complex_float_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplexFloat*
  fun matrix_complex_float_alloc_from_block = gsl_matrix_complex_float_alloc_from_block(b : BlockComplexFloat*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixComplexFloat*
  fun matrix_complex_float_alloc_from_matrix = gsl_matrix_complex_float_alloc_from_matrix(b : MatrixComplexFloat*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixComplexFloat*
  fun vector_complex_float_alloc_row_from_matrix = gsl_vector_complex_float_alloc_row_from_matrix(m : MatrixComplexFloat*, i : LibC::SizeT) : VectorComplexFloat*
  fun vector_complex_float_alloc_col_from_matrix = gsl_vector_complex_float_alloc_col_from_matrix(m : MatrixComplexFloat*, j : LibC::SizeT) : VectorComplexFloat*
  fun matrix_complex_float_free = gsl_matrix_complex_float_free(m : MatrixComplexFloat*)
  fun matrix_complex_float_submatrix = gsl_matrix_complex_float_submatrix(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexFloatView

  struct X_GslMatrixComplexFloatView
    matrix : MatrixComplexFloat
  end

  fun matrix_complex_float_row = gsl_matrix_complex_float_row(m : MatrixComplexFloat*, i : LibC::SizeT) : X_GslVectorComplexFloatView
  fun matrix_complex_float_column = gsl_matrix_complex_float_column(m : MatrixComplexFloat*, j : LibC::SizeT) : X_GslVectorComplexFloatView
  fun matrix_complex_float_diagonal = gsl_matrix_complex_float_diagonal(m : MatrixComplexFloat*) : X_GslVectorComplexFloatView
  fun matrix_complex_float_subdiagonal = gsl_matrix_complex_float_subdiagonal(m : MatrixComplexFloat*, k : LibC::SizeT) : X_GslVectorComplexFloatView
  fun matrix_complex_float_superdiagonal = gsl_matrix_complex_float_superdiagonal(m : MatrixComplexFloat*, k : LibC::SizeT) : X_GslVectorComplexFloatView
  fun matrix_complex_float_subrow = gsl_matrix_complex_float_subrow(m : MatrixComplexFloat*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatView
  fun matrix_complex_float_subcolumn = gsl_matrix_complex_float_subcolumn(m : MatrixComplexFloat*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatView
  fun matrix_complex_float_view_array = gsl_matrix_complex_float_view_array(base : LibC::Float*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexFloatView
  fun matrix_complex_float_view_array_with_tda = gsl_matrix_complex_float_view_array_with_tda(base : LibC::Float*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexFloatView
  fun matrix_complex_float_view_vector = gsl_matrix_complex_float_view_vector(v : VectorComplexFloat*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexFloatView
  fun matrix_complex_float_view_vector_with_tda = gsl_matrix_complex_float_view_vector_with_tda(v : VectorComplexFloat*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexFloatView
  fun matrix_complex_float_const_submatrix = gsl_matrix_complex_float_const_submatrix(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexFloatConstView

  struct X_GslMatrixComplexFloatConstView
    matrix : MatrixComplexFloat
  end

  fun matrix_complex_float_const_row = gsl_matrix_complex_float_const_row(m : MatrixComplexFloat*, i : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun matrix_complex_float_const_column = gsl_matrix_complex_float_const_column(m : MatrixComplexFloat*, j : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun matrix_complex_float_const_diagonal = gsl_matrix_complex_float_const_diagonal(m : MatrixComplexFloat*) : X_GslVectorComplexFloatConstView
  fun matrix_complex_float_const_subdiagonal = gsl_matrix_complex_float_const_subdiagonal(m : MatrixComplexFloat*, k : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun matrix_complex_float_const_superdiagonal = gsl_matrix_complex_float_const_superdiagonal(m : MatrixComplexFloat*, k : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun matrix_complex_float_const_subrow = gsl_matrix_complex_float_const_subrow(m : MatrixComplexFloat*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun matrix_complex_float_const_subcolumn = gsl_matrix_complex_float_const_subcolumn(m : MatrixComplexFloat*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorComplexFloatConstView
  fun matrix_complex_float_const_view_array = gsl_matrix_complex_float_const_view_array(base : LibC::Float*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexFloatConstView
  fun matrix_complex_float_const_view_array_with_tda = gsl_matrix_complex_float_const_view_array_with_tda(base : LibC::Float*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexFloatConstView
  fun matrix_complex_float_const_view_vector = gsl_matrix_complex_float_const_view_vector(v : VectorComplexFloat*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixComplexFloatConstView
  fun matrix_complex_float_const_view_vector_with_tda = gsl_matrix_complex_float_const_view_vector_with_tda(v : VectorComplexFloat*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixComplexFloatConstView
  fun matrix_complex_float_set_zero = gsl_matrix_complex_float_set_zero(m : MatrixComplexFloat*)
  fun matrix_complex_float_set_identity = gsl_matrix_complex_float_set_identity(m : MatrixComplexFloat*)
  fun matrix_complex_float_set_all = gsl_matrix_complex_float_set_all(m : MatrixComplexFloat*, x : ComplexFloat)
  fun matrix_complex_float_fread = gsl_matrix_complex_float_fread(stream : File*, m : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_fwrite = gsl_matrix_complex_float_fwrite(stream : File*, m : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_fscanf = gsl_matrix_complex_float_fscanf(stream : File*, m : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_fprintf = gsl_matrix_complex_float_fprintf(stream : File*, m : MatrixComplexFloat*, format : LibC::Char*) : LibC::Int
  fun matrix_complex_float_memcpy = gsl_matrix_complex_float_memcpy(dest : MatrixComplexFloat*, src : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_swap = gsl_matrix_complex_float_swap(m1 : MatrixComplexFloat*, m2 : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_tricpy = gsl_matrix_complex_float_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixComplexFloat*, src : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_swap_rows = gsl_matrix_complex_float_swap_rows(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_complex_float_swap_columns = gsl_matrix_complex_float_swap_columns(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_complex_float_swap_rowcol = gsl_matrix_complex_float_swap_rowcol(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_complex_float_transpose = gsl_matrix_complex_float_transpose(m : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_transpose_memcpy = gsl_matrix_complex_float_transpose_memcpy(dest : MatrixComplexFloat*, src : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_transpose_tricpy = gsl_matrix_complex_float_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixComplexFloat*, src : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_equal = gsl_matrix_complex_float_equal(a : MatrixComplexFloat*, b : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_isnull = gsl_matrix_complex_float_isnull(m : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_ispos = gsl_matrix_complex_float_ispos(m : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_isneg = gsl_matrix_complex_float_isneg(m : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_isnonneg = gsl_matrix_complex_float_isnonneg(m : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_add = gsl_matrix_complex_float_add(a : MatrixComplexFloat*, b : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_sub = gsl_matrix_complex_float_sub(a : MatrixComplexFloat*, b : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_mul_elements = gsl_matrix_complex_float_mul_elements(a : MatrixComplexFloat*, b : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_div_elements = gsl_matrix_complex_float_div_elements(a : MatrixComplexFloat*, b : MatrixComplexFloat*) : LibC::Int
  fun matrix_complex_float_scale = gsl_matrix_complex_float_scale(a : MatrixComplexFloat*, x : ComplexFloat) : LibC::Int
  fun matrix_complex_float_add_constant = gsl_matrix_complex_float_add_constant(a : MatrixComplexFloat*, x : ComplexFloat) : LibC::Int
  fun matrix_complex_float_add_diagonal = gsl_matrix_complex_float_add_diagonal(a : MatrixComplexFloat*, x : ComplexFloat) : LibC::Int
  fun matrix_complex_float_get_row = gsl_matrix_complex_float_get_row(v : VectorComplexFloat*, m : MatrixComplexFloat*, i : LibC::SizeT) : LibC::Int
  fun matrix_complex_float_get_col = gsl_matrix_complex_float_get_col(v : VectorComplexFloat*, m : MatrixComplexFloat*, j : LibC::SizeT) : LibC::Int
  fun matrix_complex_float_set_row = gsl_matrix_complex_float_set_row(m : MatrixComplexFloat*, i : LibC::SizeT, v : VectorComplexFloat*) : LibC::Int
  fun matrix_complex_float_set_col = gsl_matrix_complex_float_set_col(m : MatrixComplexFloat*, j : LibC::SizeT, v : VectorComplexFloat*) : LibC::Int
  fun matrix_complex_float_get = gsl_matrix_complex_float_get(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT) : ComplexFloat
  fun matrix_complex_float_set = gsl_matrix_complex_float_set(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT, x : ComplexFloat)
  fun matrix_complex_float_ptr = gsl_matrix_complex_float_ptr(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT) : ComplexFloat*
  fun matrix_complex_float_const_ptr = gsl_matrix_complex_float_const_ptr(m : MatrixComplexFloat*, i : LibC::SizeT, j : LibC::SizeT) : ComplexFloat*
  # fun matrix_long_double_alloc = gsl_matrix_long_double_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixLongDouble*
  #
  # struct MatrixLongDouble
  #   size1 : LibC::SizeT
  #   size2 : LibC::SizeT
  #   tda : LibC::SizeT
  #   data : LibC::LongDouble*
  #   block : BlockLongDouble*
  #   owner : LibC::Int
  # end
  #
  # fun matrix_long_double_calloc = gsl_matrix_long_double_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixLongDouble*
  # fun matrix_long_double_alloc_from_block = gsl_matrix_long_double_alloc_from_block(b : BlockLongDouble*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixLongDouble*
  # fun matrix_long_double_alloc_from_matrix = gsl_matrix_long_double_alloc_from_matrix(m : MatrixLongDouble*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixLongDouble*
  # fun vector_long_double_alloc_row_from_matrix = gsl_vector_long_double_alloc_row_from_matrix(m : MatrixLongDouble*, i : LibC::SizeT) : VectorLongDouble*
  # fun vector_long_double_alloc_col_from_matrix = gsl_vector_long_double_alloc_col_from_matrix(m : MatrixLongDouble*, j : LibC::SizeT) : VectorLongDouble*
  # fun matrix_long_double_free = gsl_matrix_long_double_free(m : MatrixLongDouble*)
  # fun matrix_long_double_submatrix = gsl_matrix_long_double_submatrix(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongDoubleView
  #
  # struct X_GslMatrixLongDoubleView
  #   matrix : MatrixLongDouble
  # end
  #
  # fun matrix_long_double_row = gsl_matrix_long_double_row(m : MatrixLongDouble*, i : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun matrix_long_double_column = gsl_matrix_long_double_column(m : MatrixLongDouble*, j : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun matrix_long_double_diagonal = gsl_matrix_long_double_diagonal(m : MatrixLongDouble*) : X_GslVectorLongDoubleView
  # fun matrix_long_double_subdiagonal = gsl_matrix_long_double_subdiagonal(m : MatrixLongDouble*, k : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun matrix_long_double_superdiagonal = gsl_matrix_long_double_superdiagonal(m : MatrixLongDouble*, k : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun matrix_long_double_subrow = gsl_matrix_long_double_subrow(m : MatrixLongDouble*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun matrix_long_double_subcolumn = gsl_matrix_long_double_subcolumn(m : MatrixLongDouble*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleView
  # fun matrix_long_double_view_array = gsl_matrix_long_double_view_array(base : LibC::LongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongDoubleView
  # fun matrix_long_double_view_array_with_tda = gsl_matrix_long_double_view_array_with_tda(base : LibC::LongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixLongDoubleView
  # fun matrix_long_double_view_vector = gsl_matrix_long_double_view_vector(v : VectorLongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongDoubleView
  # fun matrix_long_double_view_vector_with_tda = gsl_matrix_long_double_view_vector_with_tda(v : VectorLongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixLongDoubleView
  # fun matrix_long_double_const_submatrix = gsl_matrix_long_double_const_submatrix(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongDoubleConstView
  #
  # struct X_GslMatrixLongDoubleConstView
  #   matrix : MatrixLongDouble
  # end
  #
  # fun matrix_long_double_const_row = gsl_matrix_long_double_const_row(m : MatrixLongDouble*, i : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun matrix_long_double_const_column = gsl_matrix_long_double_const_column(m : MatrixLongDouble*, j : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun matrix_long_double_const_diagonal = gsl_matrix_long_double_const_diagonal(m : MatrixLongDouble*) : X_GslVectorLongDoubleConstView
  # fun matrix_long_double_const_subdiagonal = gsl_matrix_long_double_const_subdiagonal(m : MatrixLongDouble*, k : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun matrix_long_double_const_superdiagonal = gsl_matrix_long_double_const_superdiagonal(m : MatrixLongDouble*, k : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun matrix_long_double_const_subrow = gsl_matrix_long_double_const_subrow(m : MatrixLongDouble*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun matrix_long_double_const_subcolumn = gsl_matrix_long_double_const_subcolumn(m : MatrixLongDouble*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongDoubleConstView
  # fun matrix_long_double_const_view_array = gsl_matrix_long_double_const_view_array(base : LibC::LongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongDoubleConstView
  # fun matrix_long_double_const_view_array_with_tda = gsl_matrix_long_double_const_view_array_with_tda(base : LibC::LongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixLongDoubleConstView
  # fun matrix_long_double_const_view_vector = gsl_matrix_long_double_const_view_vector(v : VectorLongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongDoubleConstView
  # fun matrix_long_double_const_view_vector_with_tda = gsl_matrix_long_double_const_view_vector_with_tda(v : VectorLongDouble*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixLongDoubleConstView
  # fun matrix_long_double_set_zero = gsl_matrix_long_double_set_zero(m : MatrixLongDouble*)
  # fun matrix_long_double_set_identity = gsl_matrix_long_double_set_identity(m : MatrixLongDouble*)
  # fun matrix_long_double_set_all = gsl_matrix_long_double_set_all(m : MatrixLongDouble*, x : LibC::LongDouble)
  # fun matrix_long_double_fread = gsl_matrix_long_double_fread(stream : File*, m : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_fwrite = gsl_matrix_long_double_fwrite(stream : File*, m : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_fscanf = gsl_matrix_long_double_fscanf(stream : File*, m : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_fprintf = gsl_matrix_long_double_fprintf(stream : File*, m : MatrixLongDouble*, format : LibC::Char*) : LibC::Int
  # fun matrix_long_double_memcpy = gsl_matrix_long_double_memcpy(dest : MatrixLongDouble*, src : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_swap = gsl_matrix_long_double_swap(m1 : MatrixLongDouble*, m2 : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_tricpy = gsl_matrix_long_double_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixLongDouble*, src : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_swap_rows = gsl_matrix_long_double_swap_rows(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  # fun matrix_long_double_swap_columns = gsl_matrix_long_double_swap_columns(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  # fun matrix_long_double_swap_rowcol = gsl_matrix_long_double_swap_rowcol(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  # fun matrix_long_double_transpose = gsl_matrix_long_double_transpose(m : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_transpose_memcpy = gsl_matrix_long_double_transpose_memcpy(dest : MatrixLongDouble*, src : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_transpose_tricpy = gsl_matrix_long_double_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixLongDouble*, src : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_max = gsl_matrix_long_double_max(m : MatrixLongDouble*) : LibC::LongDouble
  # fun matrix_long_double_min = gsl_matrix_long_double_min(m : MatrixLongDouble*) : LibC::LongDouble
  # fun matrix_long_double_minmax = gsl_matrix_long_double_minmax(m : MatrixLongDouble*, min_out : LibC::LongDouble*, max_out : LibC::LongDouble*)
  # fun matrix_long_double_max_index = gsl_matrix_long_double_max_index(m : MatrixLongDouble*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  # fun matrix_long_double_min_index = gsl_matrix_long_double_min_index(m : MatrixLongDouble*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  # fun matrix_long_double_minmax_index = gsl_matrix_long_double_minmax_index(m : MatrixLongDouble*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  # fun matrix_long_double_equal = gsl_matrix_long_double_equal(a : MatrixLongDouble*, b : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_isnull = gsl_matrix_long_double_isnull(m : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_ispos = gsl_matrix_long_double_ispos(m : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_isneg = gsl_matrix_long_double_isneg(m : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_isnonneg = gsl_matrix_long_double_isnonneg(m : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_add = gsl_matrix_long_double_add(a : MatrixLongDouble*, b : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_sub = gsl_matrix_long_double_sub(a : MatrixLongDouble*, b : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_mul_elements = gsl_matrix_long_double_mul_elements(a : MatrixLongDouble*, b : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_div_elements = gsl_matrix_long_double_div_elements(a : MatrixLongDouble*, b : MatrixLongDouble*) : LibC::Int
  # fun matrix_long_double_scale = gsl_matrix_long_double_scale(a : MatrixLongDouble*, x : LibC::Double) : LibC::Int
  # fun matrix_long_double_add_constant = gsl_matrix_long_double_add_constant(a : MatrixLongDouble*, x : LibC::Double) : LibC::Int
  # fun matrix_long_double_add_diagonal = gsl_matrix_long_double_add_diagonal(a : MatrixLongDouble*, x : LibC::Double) : LibC::Int
  # fun matrix_long_double_get_row = gsl_matrix_long_double_get_row(v : VectorLongDouble*, m : MatrixLongDouble*, i : LibC::SizeT) : LibC::Int
  # fun matrix_long_double_get_col = gsl_matrix_long_double_get_col(v : VectorLongDouble*, m : MatrixLongDouble*, j : LibC::SizeT) : LibC::Int
  # fun matrix_long_double_set_row = gsl_matrix_long_double_set_row(m : MatrixLongDouble*, i : LibC::SizeT, v : VectorLongDouble*) : LibC::Int
  # fun matrix_long_double_set_col = gsl_matrix_long_double_set_col(m : MatrixLongDouble*, j : LibC::SizeT, v : VectorLongDouble*) : LibC::Int
  # fun matrix_long_double_get = gsl_matrix_long_double_get(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::LongDouble
  # fun matrix_long_double_set = gsl_matrix_long_double_set(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::LongDouble)
  # fun matrix_long_double_ptr = gsl_matrix_long_double_ptr(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::LongDouble*
  # fun matrix_long_double_const_ptr = gsl_matrix_long_double_const_ptr(m : MatrixLongDouble*, i : LibC::SizeT, j : LibC::SizeT) : LibC::LongDouble*
  fun matrix_alloc = gsl_matrix_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : Matrix*

  struct Matrix
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::Double*
    block : Block*
    owner : LibC::Int
  end

  fun matrix_calloc = gsl_matrix_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : Matrix*
  fun matrix_alloc_from_block = gsl_matrix_alloc_from_block(b : Block*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : Matrix*
  fun matrix_alloc_from_matrix = gsl_matrix_alloc_from_matrix(m : Matrix*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : Matrix*
  fun vector_alloc_row_from_matrix = gsl_vector_alloc_row_from_matrix(m : Matrix*, i : LibC::SizeT) : Vector*
  fun vector_alloc_col_from_matrix = gsl_vector_alloc_col_from_matrix(m : Matrix*, j : LibC::SizeT) : Vector*
  fun matrix_free = gsl_matrix_free(m : Matrix*)
  fun matrix_submatrix = gsl_matrix_submatrix(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixView

  struct X_GslMatrixView
    matrix : Matrix
  end

  fun matrix_row = gsl_matrix_row(m : Matrix*, i : LibC::SizeT) : X_GslVectorView
  fun matrix_column = gsl_matrix_column(m : Matrix*, j : LibC::SizeT) : X_GslVectorView
  fun matrix_diagonal = gsl_matrix_diagonal(m : Matrix*) : X_GslVectorView
  fun matrix_subdiagonal = gsl_matrix_subdiagonal(m : Matrix*, k : LibC::SizeT) : X_GslVectorView
  fun matrix_superdiagonal = gsl_matrix_superdiagonal(m : Matrix*, k : LibC::SizeT) : X_GslVectorView
  fun matrix_subrow = gsl_matrix_subrow(m : Matrix*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorView
  fun matrix_subcolumn = gsl_matrix_subcolumn(m : Matrix*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorView
  fun matrix_view_array = gsl_matrix_view_array(base : LibC::Double*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixView
  fun matrix_view_array_with_tda = gsl_matrix_view_array_with_tda(base : LibC::Double*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixView
  fun matrix_view_vector = gsl_matrix_view_vector(v : Vector*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixView
  fun matrix_view_vector_with_tda = gsl_matrix_view_vector_with_tda(v : Vector*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixView
  fun matrix_const_submatrix = gsl_matrix_const_submatrix(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixConstView

  struct X_GslMatrixConstView
    matrix : Matrix
  end

  fun matrix_const_row = gsl_matrix_const_row(m : Matrix*, i : LibC::SizeT) : X_GslVectorConstView
  fun matrix_const_column = gsl_matrix_const_column(m : Matrix*, j : LibC::SizeT) : X_GslVectorConstView
  fun matrix_const_diagonal = gsl_matrix_const_diagonal(m : Matrix*) : X_GslVectorConstView
  fun matrix_const_subdiagonal = gsl_matrix_const_subdiagonal(m : Matrix*, k : LibC::SizeT) : X_GslVectorConstView
  fun matrix_const_superdiagonal = gsl_matrix_const_superdiagonal(m : Matrix*, k : LibC::SizeT) : X_GslVectorConstView
  fun matrix_const_subrow = gsl_matrix_const_subrow(m : Matrix*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorConstView
  fun matrix_const_subcolumn = gsl_matrix_const_subcolumn(m : Matrix*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorConstView
  fun matrix_const_view_array = gsl_matrix_const_view_array(base : LibC::Double*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixConstView
  fun matrix_const_view_array_with_tda = gsl_matrix_const_view_array_with_tda(base : LibC::Double*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixConstView
  fun matrix_const_view_vector = gsl_matrix_const_view_vector(v : Vector*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixConstView
  fun matrix_const_view_vector_with_tda = gsl_matrix_const_view_vector_with_tda(v : Vector*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixConstView
  fun matrix_set_zero = gsl_matrix_set_zero(m : Matrix*)
  fun matrix_set_identity = gsl_matrix_set_identity(m : Matrix*)
  fun matrix_set_all = gsl_matrix_set_all(m : Matrix*, x : LibC::Double)
  fun matrix_fread = gsl_matrix_fread(stream : File*, m : Matrix*) : LibC::Int
  fun matrix_fwrite = gsl_matrix_fwrite(stream : File*, m : Matrix*) : LibC::Int
  fun matrix_fscanf = gsl_matrix_fscanf(stream : File*, m : Matrix*) : LibC::Int
  fun matrix_fprintf = gsl_matrix_fprintf(stream : File*, m : Matrix*, format : LibC::Char*) : LibC::Int
  fun matrix_memcpy = gsl_matrix_memcpy(dest : Matrix*, src : Matrix*) : LibC::Int
  fun matrix_swap = gsl_matrix_swap(m1 : Matrix*, m2 : Matrix*) : LibC::Int
  fun matrix_tricpy = gsl_matrix_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : Matrix*, src : Matrix*) : LibC::Int
  fun matrix_swap_rows = gsl_matrix_swap_rows(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_swap_columns = gsl_matrix_swap_columns(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_swap_rowcol = gsl_matrix_swap_rowcol(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_transpose = gsl_matrix_transpose(m : Matrix*) : LibC::Int
  fun matrix_transpose_memcpy = gsl_matrix_transpose_memcpy(dest : Matrix*, src : Matrix*) : LibC::Int
  fun matrix_transpose_tricpy = gsl_matrix_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : Matrix*, src : Matrix*) : LibC::Int
  fun matrix_max = gsl_matrix_max(m : Matrix*) : LibC::Double
  fun matrix_min = gsl_matrix_min(m : Matrix*) : LibC::Double
  fun matrix_minmax = gsl_matrix_minmax(m : Matrix*, min_out : LibC::Double*, max_out : LibC::Double*)
  fun matrix_max_index = gsl_matrix_max_index(m : Matrix*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_min_index = gsl_matrix_min_index(m : Matrix*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_minmax_index = gsl_matrix_minmax_index(m : Matrix*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_equal = gsl_matrix_equal(a : Matrix*, b : Matrix*) : LibC::Int
  fun matrix_isnull = gsl_matrix_isnull(m : Matrix*) : LibC::Int
  fun matrix_ispos = gsl_matrix_ispos(m : Matrix*) : LibC::Int
  fun matrix_isneg = gsl_matrix_isneg(m : Matrix*) : LibC::Int
  fun matrix_isnonneg = gsl_matrix_isnonneg(m : Matrix*) : LibC::Int
  fun matrix_add = gsl_matrix_add(a : Matrix*, b : Matrix*) : LibC::Int
  fun matrix_sub = gsl_matrix_sub(a : Matrix*, b : Matrix*) : LibC::Int
  fun matrix_mul_elements = gsl_matrix_mul_elements(a : Matrix*, b : Matrix*) : LibC::Int
  fun matrix_div_elements = gsl_matrix_div_elements(a : Matrix*, b : Matrix*) : LibC::Int
  fun matrix_scale = gsl_matrix_scale(a : Matrix*, x : LibC::Double) : LibC::Int
  fun matrix_add_constant = gsl_matrix_add_constant(a : Matrix*, x : LibC::Double) : LibC::Int
  fun matrix_add_diagonal = gsl_matrix_add_diagonal(a : Matrix*, x : LibC::Double) : LibC::Int
  fun matrix_get_row = gsl_matrix_get_row(v : Vector*, m : Matrix*, i : LibC::SizeT) : LibC::Int
  fun matrix_get_col = gsl_matrix_get_col(v : Vector*, m : Matrix*, j : LibC::SizeT) : LibC::Int
  fun matrix_set_row = gsl_matrix_set_row(m : Matrix*, i : LibC::SizeT, v : Vector*) : LibC::Int
  fun matrix_set_col = gsl_matrix_set_col(m : Matrix*, j : LibC::SizeT, v : Vector*) : LibC::Int
  fun matrix_get = gsl_matrix_get(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Double
  fun matrix_set = gsl_matrix_set(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::Double)
  fun matrix_ptr = gsl_matrix_ptr(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Double*
  fun matrix_const_ptr = gsl_matrix_const_ptr(m : Matrix*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Double*
  fun matrix_float_alloc = gsl_matrix_float_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixFloat*

  struct MatrixFloat
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::Float*
    block : BlockFloat*
    owner : LibC::Int
  end

  fun matrix_float_calloc = gsl_matrix_float_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixFloat*
  fun matrix_float_alloc_from_block = gsl_matrix_float_alloc_from_block(b : BlockFloat*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixFloat*
  fun matrix_float_alloc_from_matrix = gsl_matrix_float_alloc_from_matrix(m : MatrixFloat*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixFloat*
  fun vector_float_alloc_row_from_matrix = gsl_vector_float_alloc_row_from_matrix(m : MatrixFloat*, i : LibC::SizeT) : VectorFloat*
  fun vector_float_alloc_col_from_matrix = gsl_vector_float_alloc_col_from_matrix(m : MatrixFloat*, j : LibC::SizeT) : VectorFloat*
  fun matrix_float_free = gsl_matrix_float_free(m : MatrixFloat*)
  fun matrix_float_submatrix = gsl_matrix_float_submatrix(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixFloatView

  struct X_GslMatrixFloatView
    matrix : MatrixFloat
  end

  fun matrix_float_row = gsl_matrix_float_row(m : MatrixFloat*, i : LibC::SizeT) : X_GslVectorFloatView
  fun matrix_float_column = gsl_matrix_float_column(m : MatrixFloat*, j : LibC::SizeT) : X_GslVectorFloatView
  fun matrix_float_diagonal = gsl_matrix_float_diagonal(m : MatrixFloat*) : X_GslVectorFloatView
  fun matrix_float_subdiagonal = gsl_matrix_float_subdiagonal(m : MatrixFloat*, k : LibC::SizeT) : X_GslVectorFloatView
  fun matrix_float_superdiagonal = gsl_matrix_float_superdiagonal(m : MatrixFloat*, k : LibC::SizeT) : X_GslVectorFloatView
  fun matrix_float_subrow = gsl_matrix_float_subrow(m : MatrixFloat*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatView
  fun matrix_float_subcolumn = gsl_matrix_float_subcolumn(m : MatrixFloat*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatView
  fun matrix_float_view_array = gsl_matrix_float_view_array(base : LibC::Float*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixFloatView
  fun matrix_float_view_array_with_tda = gsl_matrix_float_view_array_with_tda(base : LibC::Float*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixFloatView
  fun matrix_float_view_vector = gsl_matrix_float_view_vector(v : VectorFloat*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixFloatView
  fun matrix_float_view_vector_with_tda = gsl_matrix_float_view_vector_with_tda(v : VectorFloat*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixFloatView
  fun matrix_float_const_submatrix = gsl_matrix_float_const_submatrix(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixFloatConstView

  struct X_GslMatrixFloatConstView
    matrix : MatrixFloat
  end

  fun matrix_float_const_row = gsl_matrix_float_const_row(m : MatrixFloat*, i : LibC::SizeT) : X_GslVectorFloatConstView
  fun matrix_float_const_column = gsl_matrix_float_const_column(m : MatrixFloat*, j : LibC::SizeT) : X_GslVectorFloatConstView
  fun matrix_float_const_diagonal = gsl_matrix_float_const_diagonal(m : MatrixFloat*) : X_GslVectorFloatConstView
  fun matrix_float_const_subdiagonal = gsl_matrix_float_const_subdiagonal(m : MatrixFloat*, k : LibC::SizeT) : X_GslVectorFloatConstView
  fun matrix_float_const_superdiagonal = gsl_matrix_float_const_superdiagonal(m : MatrixFloat*, k : LibC::SizeT) : X_GslVectorFloatConstView
  fun matrix_float_const_subrow = gsl_matrix_float_const_subrow(m : MatrixFloat*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatConstView
  fun matrix_float_const_subcolumn = gsl_matrix_float_const_subcolumn(m : MatrixFloat*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorFloatConstView
  fun matrix_float_const_view_array = gsl_matrix_float_const_view_array(base : LibC::Float*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixFloatConstView
  fun matrix_float_const_view_array_with_tda = gsl_matrix_float_const_view_array_with_tda(base : LibC::Float*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixFloatConstView
  fun matrix_float_const_view_vector = gsl_matrix_float_const_view_vector(v : VectorFloat*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixFloatConstView
  fun matrix_float_const_view_vector_with_tda = gsl_matrix_float_const_view_vector_with_tda(v : VectorFloat*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixFloatConstView
  fun matrix_float_set_zero = gsl_matrix_float_set_zero(m : MatrixFloat*)
  fun matrix_float_set_identity = gsl_matrix_float_set_identity(m : MatrixFloat*)
  fun matrix_float_set_all = gsl_matrix_float_set_all(m : MatrixFloat*, x : LibC::Float)
  fun matrix_float_fread = gsl_matrix_float_fread(stream : File*, m : MatrixFloat*) : LibC::Int
  fun matrix_float_fwrite = gsl_matrix_float_fwrite(stream : File*, m : MatrixFloat*) : LibC::Int
  fun matrix_float_fscanf = gsl_matrix_float_fscanf(stream : File*, m : MatrixFloat*) : LibC::Int
  fun matrix_float_fprintf = gsl_matrix_float_fprintf(stream : File*, m : MatrixFloat*, format : LibC::Char*) : LibC::Int
  fun matrix_float_memcpy = gsl_matrix_float_memcpy(dest : MatrixFloat*, src : MatrixFloat*) : LibC::Int
  fun matrix_float_swap = gsl_matrix_float_swap(m1 : MatrixFloat*, m2 : MatrixFloat*) : LibC::Int
  fun matrix_float_tricpy = gsl_matrix_float_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixFloat*, src : MatrixFloat*) : LibC::Int
  fun matrix_float_swap_rows = gsl_matrix_float_swap_rows(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_float_swap_columns = gsl_matrix_float_swap_columns(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_float_swap_rowcol = gsl_matrix_float_swap_rowcol(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_float_transpose = gsl_matrix_float_transpose(m : MatrixFloat*) : LibC::Int
  fun matrix_float_transpose_memcpy = gsl_matrix_float_transpose_memcpy(dest : MatrixFloat*, src : MatrixFloat*) : LibC::Int
  fun matrix_float_transpose_tricpy = gsl_matrix_float_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixFloat*, src : MatrixFloat*) : LibC::Int
  fun matrix_float_max = gsl_matrix_float_max(m : MatrixFloat*) : LibC::Float
  fun matrix_float_min = gsl_matrix_float_min(m : MatrixFloat*) : LibC::Float
  fun matrix_float_minmax = gsl_matrix_float_minmax(m : MatrixFloat*, min_out : LibC::Float*, max_out : LibC::Float*)
  fun matrix_float_max_index = gsl_matrix_float_max_index(m : MatrixFloat*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_float_min_index = gsl_matrix_float_min_index(m : MatrixFloat*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_float_minmax_index = gsl_matrix_float_minmax_index(m : MatrixFloat*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_float_equal = gsl_matrix_float_equal(a : MatrixFloat*, b : MatrixFloat*) : LibC::Int
  fun matrix_float_isnull = gsl_matrix_float_isnull(m : MatrixFloat*) : LibC::Int
  fun matrix_float_ispos = gsl_matrix_float_ispos(m : MatrixFloat*) : LibC::Int
  fun matrix_float_isneg = gsl_matrix_float_isneg(m : MatrixFloat*) : LibC::Int
  fun matrix_float_isnonneg = gsl_matrix_float_isnonneg(m : MatrixFloat*) : LibC::Int
  fun matrix_float_add = gsl_matrix_float_add(a : MatrixFloat*, b : MatrixFloat*) : LibC::Int
  fun matrix_float_sub = gsl_matrix_float_sub(a : MatrixFloat*, b : MatrixFloat*) : LibC::Int
  fun matrix_float_mul_elements = gsl_matrix_float_mul_elements(a : MatrixFloat*, b : MatrixFloat*) : LibC::Int
  fun matrix_float_div_elements = gsl_matrix_float_div_elements(a : MatrixFloat*, b : MatrixFloat*) : LibC::Int
  fun matrix_float_scale = gsl_matrix_float_scale(a : MatrixFloat*, x : LibC::Double) : LibC::Int
  fun matrix_float_add_constant = gsl_matrix_float_add_constant(a : MatrixFloat*, x : LibC::Double) : LibC::Int
  fun matrix_float_add_diagonal = gsl_matrix_float_add_diagonal(a : MatrixFloat*, x : LibC::Double) : LibC::Int
  fun matrix_float_get_row = gsl_matrix_float_get_row(v : VectorFloat*, m : MatrixFloat*, i : LibC::SizeT) : LibC::Int
  fun matrix_float_get_col = gsl_matrix_float_get_col(v : VectorFloat*, m : MatrixFloat*, j : LibC::SizeT) : LibC::Int
  fun matrix_float_set_row = gsl_matrix_float_set_row(m : MatrixFloat*, i : LibC::SizeT, v : VectorFloat*) : LibC::Int
  fun matrix_float_set_col = gsl_matrix_float_set_col(m : MatrixFloat*, j : LibC::SizeT, v : VectorFloat*) : LibC::Int
  fun matrix_float_get = gsl_matrix_float_get(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Float
  fun matrix_float_set = gsl_matrix_float_set(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::Float)
  fun matrix_float_ptr = gsl_matrix_float_ptr(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Float*
  fun matrix_float_const_ptr = gsl_matrix_float_const_ptr(m : MatrixFloat*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Float*
  fun matrix_ulong_alloc = gsl_matrix_ulong_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUlong*

  struct MatrixUlong
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::ULong*
    block : BlockUlong*
    owner : LibC::Int
  end

  fun matrix_ulong_calloc = gsl_matrix_ulong_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUlong*
  fun matrix_ulong_alloc_from_block = gsl_matrix_ulong_alloc_from_block(b : BlockUlong*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixUlong*
  fun matrix_ulong_alloc_from_matrix = gsl_matrix_ulong_alloc_from_matrix(m : MatrixUlong*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUlong*
  fun vector_ulong_alloc_row_from_matrix = gsl_vector_ulong_alloc_row_from_matrix(m : MatrixUlong*, i : LibC::SizeT) : VectorUlong*
  fun vector_ulong_alloc_col_from_matrix = gsl_vector_ulong_alloc_col_from_matrix(m : MatrixUlong*, j : LibC::SizeT) : VectorUlong*
  fun matrix_ulong_free = gsl_matrix_ulong_free(m : MatrixUlong*)
  fun matrix_ulong_submatrix = gsl_matrix_ulong_submatrix(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUlongView

  struct X_GslMatrixUlongView
    matrix : MatrixUlong
  end

  fun matrix_ulong_row = gsl_matrix_ulong_row(m : MatrixUlong*, i : LibC::SizeT) : X_GslVectorUlongView
  fun matrix_ulong_column = gsl_matrix_ulong_column(m : MatrixUlong*, j : LibC::SizeT) : X_GslVectorUlongView
  fun matrix_ulong_diagonal = gsl_matrix_ulong_diagonal(m : MatrixUlong*) : X_GslVectorUlongView
  fun matrix_ulong_subdiagonal = gsl_matrix_ulong_subdiagonal(m : MatrixUlong*, k : LibC::SizeT) : X_GslVectorUlongView
  fun matrix_ulong_superdiagonal = gsl_matrix_ulong_superdiagonal(m : MatrixUlong*, k : LibC::SizeT) : X_GslVectorUlongView
  fun matrix_ulong_subrow = gsl_matrix_ulong_subrow(m : MatrixUlong*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongView
  fun matrix_ulong_subcolumn = gsl_matrix_ulong_subcolumn(m : MatrixUlong*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongView
  fun matrix_ulong_view_array = gsl_matrix_ulong_view_array(base : LibC::ULong*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUlongView
  fun matrix_ulong_view_array_with_tda = gsl_matrix_ulong_view_array_with_tda(base : LibC::ULong*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUlongView
  fun matrix_ulong_view_vector = gsl_matrix_ulong_view_vector(v : VectorUlong*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUlongView
  fun matrix_ulong_view_vector_with_tda = gsl_matrix_ulong_view_vector_with_tda(v : VectorUlong*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUlongView
  fun matrix_ulong_const_submatrix = gsl_matrix_ulong_const_submatrix(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUlongConstView

  struct X_GslMatrixUlongConstView
    matrix : MatrixUlong
  end

  fun matrix_ulong_const_row = gsl_matrix_ulong_const_row(m : MatrixUlong*, i : LibC::SizeT) : X_GslVectorUlongConstView
  fun matrix_ulong_const_column = gsl_matrix_ulong_const_column(m : MatrixUlong*, j : LibC::SizeT) : X_GslVectorUlongConstView
  fun matrix_ulong_const_diagonal = gsl_matrix_ulong_const_diagonal(m : MatrixUlong*) : X_GslVectorUlongConstView
  fun matrix_ulong_const_subdiagonal = gsl_matrix_ulong_const_subdiagonal(m : MatrixUlong*, k : LibC::SizeT) : X_GslVectorUlongConstView
  fun matrix_ulong_const_superdiagonal = gsl_matrix_ulong_const_superdiagonal(m : MatrixUlong*, k : LibC::SizeT) : X_GslVectorUlongConstView
  fun matrix_ulong_const_subrow = gsl_matrix_ulong_const_subrow(m : MatrixUlong*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongConstView
  fun matrix_ulong_const_subcolumn = gsl_matrix_ulong_const_subcolumn(m : MatrixUlong*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUlongConstView
  fun matrix_ulong_const_view_array = gsl_matrix_ulong_const_view_array(base : LibC::ULong*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUlongConstView
  fun matrix_ulong_const_view_array_with_tda = gsl_matrix_ulong_const_view_array_with_tda(base : LibC::ULong*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUlongConstView
  fun matrix_ulong_const_view_vector = gsl_matrix_ulong_const_view_vector(v : VectorUlong*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUlongConstView
  fun matrix_ulong_const_view_vector_with_tda = gsl_matrix_ulong_const_view_vector_with_tda(v : VectorUlong*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUlongConstView
  fun matrix_ulong_set_zero = gsl_matrix_ulong_set_zero(m : MatrixUlong*)
  fun matrix_ulong_set_identity = gsl_matrix_ulong_set_identity(m : MatrixUlong*)
  fun matrix_ulong_set_all = gsl_matrix_ulong_set_all(m : MatrixUlong*, x : LibC::ULong)
  fun matrix_ulong_fread = gsl_matrix_ulong_fread(stream : File*, m : MatrixUlong*) : LibC::Int
  fun matrix_ulong_fwrite = gsl_matrix_ulong_fwrite(stream : File*, m : MatrixUlong*) : LibC::Int
  fun matrix_ulong_fscanf = gsl_matrix_ulong_fscanf(stream : File*, m : MatrixUlong*) : LibC::Int
  fun matrix_ulong_fprintf = gsl_matrix_ulong_fprintf(stream : File*, m : MatrixUlong*, format : LibC::Char*) : LibC::Int
  fun matrix_ulong_memcpy = gsl_matrix_ulong_memcpy(dest : MatrixUlong*, src : MatrixUlong*) : LibC::Int
  fun matrix_ulong_swap = gsl_matrix_ulong_swap(m1 : MatrixUlong*, m2 : MatrixUlong*) : LibC::Int
  fun matrix_ulong_tricpy = gsl_matrix_ulong_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixUlong*, src : MatrixUlong*) : LibC::Int
  fun matrix_ulong_swap_rows = gsl_matrix_ulong_swap_rows(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_ulong_swap_columns = gsl_matrix_ulong_swap_columns(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_ulong_swap_rowcol = gsl_matrix_ulong_swap_rowcol(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_ulong_transpose = gsl_matrix_ulong_transpose(m : MatrixUlong*) : LibC::Int
  fun matrix_ulong_transpose_memcpy = gsl_matrix_ulong_transpose_memcpy(dest : MatrixUlong*, src : MatrixUlong*) : LibC::Int
  fun matrix_ulong_transpose_tricpy = gsl_matrix_ulong_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixUlong*, src : MatrixUlong*) : LibC::Int
  fun matrix_ulong_max = gsl_matrix_ulong_max(m : MatrixUlong*) : LibC::ULong
  fun matrix_ulong_min = gsl_matrix_ulong_min(m : MatrixUlong*) : LibC::ULong
  fun matrix_ulong_minmax = gsl_matrix_ulong_minmax(m : MatrixUlong*, min_out : LibC::ULong*, max_out : LibC::ULong*)
  fun matrix_ulong_max_index = gsl_matrix_ulong_max_index(m : MatrixUlong*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_ulong_min_index = gsl_matrix_ulong_min_index(m : MatrixUlong*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_ulong_minmax_index = gsl_matrix_ulong_minmax_index(m : MatrixUlong*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_ulong_equal = gsl_matrix_ulong_equal(a : MatrixUlong*, b : MatrixUlong*) : LibC::Int
  fun matrix_ulong_isnull = gsl_matrix_ulong_isnull(m : MatrixUlong*) : LibC::Int
  fun matrix_ulong_ispos = gsl_matrix_ulong_ispos(m : MatrixUlong*) : LibC::Int
  fun matrix_ulong_isneg = gsl_matrix_ulong_isneg(m : MatrixUlong*) : LibC::Int
  fun matrix_ulong_isnonneg = gsl_matrix_ulong_isnonneg(m : MatrixUlong*) : LibC::Int
  fun matrix_ulong_add = gsl_matrix_ulong_add(a : MatrixUlong*, b : MatrixUlong*) : LibC::Int
  fun matrix_ulong_sub = gsl_matrix_ulong_sub(a : MatrixUlong*, b : MatrixUlong*) : LibC::Int
  fun matrix_ulong_mul_elements = gsl_matrix_ulong_mul_elements(a : MatrixUlong*, b : MatrixUlong*) : LibC::Int
  fun matrix_ulong_div_elements = gsl_matrix_ulong_div_elements(a : MatrixUlong*, b : MatrixUlong*) : LibC::Int
  fun matrix_ulong_scale = gsl_matrix_ulong_scale(a : MatrixUlong*, x : LibC::Double) : LibC::Int
  fun matrix_ulong_add_constant = gsl_matrix_ulong_add_constant(a : MatrixUlong*, x : LibC::Double) : LibC::Int
  fun matrix_ulong_add_diagonal = gsl_matrix_ulong_add_diagonal(a : MatrixUlong*, x : LibC::Double) : LibC::Int
  fun matrix_ulong_get_row = gsl_matrix_ulong_get_row(v : VectorUlong*, m : MatrixUlong*, i : LibC::SizeT) : LibC::Int
  fun matrix_ulong_get_col = gsl_matrix_ulong_get_col(v : VectorUlong*, m : MatrixUlong*, j : LibC::SizeT) : LibC::Int
  fun matrix_ulong_set_row = gsl_matrix_ulong_set_row(m : MatrixUlong*, i : LibC::SizeT, v : VectorUlong*) : LibC::Int
  fun matrix_ulong_set_col = gsl_matrix_ulong_set_col(m : MatrixUlong*, j : LibC::SizeT, v : VectorUlong*) : LibC::Int
  fun matrix_ulong_get = gsl_matrix_ulong_get(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::ULong
  fun matrix_ulong_set = gsl_matrix_ulong_set(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::ULong)
  fun matrix_ulong_ptr = gsl_matrix_ulong_ptr(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::ULong*
  fun matrix_ulong_const_ptr = gsl_matrix_ulong_const_ptr(m : MatrixUlong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::ULong*
  fun matrix_long_alloc = gsl_matrix_long_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixLong*

  struct MatrixLong
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::Long*
    block : BlockLong*
    owner : LibC::Int
  end

  fun matrix_long_calloc = gsl_matrix_long_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixLong*
  fun matrix_long_alloc_from_block = gsl_matrix_long_alloc_from_block(b : BlockLong*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixLong*
  fun matrix_long_alloc_from_matrix = gsl_matrix_long_alloc_from_matrix(m : MatrixLong*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixLong*
  fun vector_long_alloc_row_from_matrix = gsl_vector_long_alloc_row_from_matrix(m : MatrixLong*, i : LibC::SizeT) : VectorLong*
  fun vector_long_alloc_col_from_matrix = gsl_vector_long_alloc_col_from_matrix(m : MatrixLong*, j : LibC::SizeT) : VectorLong*
  fun matrix_long_free = gsl_matrix_long_free(m : MatrixLong*)
  fun matrix_long_submatrix = gsl_matrix_long_submatrix(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongView

  struct X_GslMatrixLongView
    matrix : MatrixLong
  end

  fun matrix_long_row = gsl_matrix_long_row(m : MatrixLong*, i : LibC::SizeT) : X_GslVectorLongView
  fun matrix_long_column = gsl_matrix_long_column(m : MatrixLong*, j : LibC::SizeT) : X_GslVectorLongView
  fun matrix_long_diagonal = gsl_matrix_long_diagonal(m : MatrixLong*) : X_GslVectorLongView
  fun matrix_long_subdiagonal = gsl_matrix_long_subdiagonal(m : MatrixLong*, k : LibC::SizeT) : X_GslVectorLongView
  fun matrix_long_superdiagonal = gsl_matrix_long_superdiagonal(m : MatrixLong*, k : LibC::SizeT) : X_GslVectorLongView
  fun matrix_long_subrow = gsl_matrix_long_subrow(m : MatrixLong*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongView
  fun matrix_long_subcolumn = gsl_matrix_long_subcolumn(m : MatrixLong*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongView
  fun matrix_long_view_array = gsl_matrix_long_view_array(base : LibC::Long*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongView
  fun matrix_long_view_array_with_tda = gsl_matrix_long_view_array_with_tda(base : LibC::Long*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixLongView
  fun matrix_long_view_vector = gsl_matrix_long_view_vector(v : VectorLong*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongView
  fun matrix_long_view_vector_with_tda = gsl_matrix_long_view_vector_with_tda(v : VectorLong*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixLongView
  fun matrix_long_const_submatrix = gsl_matrix_long_const_submatrix(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongConstView

  struct X_GslMatrixLongConstView
    matrix : MatrixLong
  end

  fun matrix_long_const_row = gsl_matrix_long_const_row(m : MatrixLong*, i : LibC::SizeT) : X_GslVectorLongConstView
  fun matrix_long_const_column = gsl_matrix_long_const_column(m : MatrixLong*, j : LibC::SizeT) : X_GslVectorLongConstView
  fun matrix_long_const_diagonal = gsl_matrix_long_const_diagonal(m : MatrixLong*) : X_GslVectorLongConstView
  fun matrix_long_const_subdiagonal = gsl_matrix_long_const_subdiagonal(m : MatrixLong*, k : LibC::SizeT) : X_GslVectorLongConstView
  fun matrix_long_const_superdiagonal = gsl_matrix_long_const_superdiagonal(m : MatrixLong*, k : LibC::SizeT) : X_GslVectorLongConstView
  fun matrix_long_const_subrow = gsl_matrix_long_const_subrow(m : MatrixLong*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongConstView
  fun matrix_long_const_subcolumn = gsl_matrix_long_const_subcolumn(m : MatrixLong*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorLongConstView
  fun matrix_long_const_view_array = gsl_matrix_long_const_view_array(base : LibC::Long*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongConstView
  fun matrix_long_const_view_array_with_tda = gsl_matrix_long_const_view_array_with_tda(base : LibC::Long*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixLongConstView
  fun matrix_long_const_view_vector = gsl_matrix_long_const_view_vector(v : VectorLong*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixLongConstView
  fun matrix_long_const_view_vector_with_tda = gsl_matrix_long_const_view_vector_with_tda(v : VectorLong*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixLongConstView
  fun matrix_long_set_zero = gsl_matrix_long_set_zero(m : MatrixLong*)
  fun matrix_long_set_identity = gsl_matrix_long_set_identity(m : MatrixLong*)
  fun matrix_long_set_all = gsl_matrix_long_set_all(m : MatrixLong*, x : LibC::Long)
  fun matrix_long_fread = gsl_matrix_long_fread(stream : File*, m : MatrixLong*) : LibC::Int
  fun matrix_long_fwrite = gsl_matrix_long_fwrite(stream : File*, m : MatrixLong*) : LibC::Int
  fun matrix_long_fscanf = gsl_matrix_long_fscanf(stream : File*, m : MatrixLong*) : LibC::Int
  fun matrix_long_fprintf = gsl_matrix_long_fprintf(stream : File*, m : MatrixLong*, format : LibC::Char*) : LibC::Int
  fun matrix_long_memcpy = gsl_matrix_long_memcpy(dest : MatrixLong*, src : MatrixLong*) : LibC::Int
  fun matrix_long_swap = gsl_matrix_long_swap(m1 : MatrixLong*, m2 : MatrixLong*) : LibC::Int
  fun matrix_long_tricpy = gsl_matrix_long_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixLong*, src : MatrixLong*) : LibC::Int
  fun matrix_long_swap_rows = gsl_matrix_long_swap_rows(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_long_swap_columns = gsl_matrix_long_swap_columns(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_long_swap_rowcol = gsl_matrix_long_swap_rowcol(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_long_transpose = gsl_matrix_long_transpose(m : MatrixLong*) : LibC::Int
  fun matrix_long_transpose_memcpy = gsl_matrix_long_transpose_memcpy(dest : MatrixLong*, src : MatrixLong*) : LibC::Int
  fun matrix_long_transpose_tricpy = gsl_matrix_long_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixLong*, src : MatrixLong*) : LibC::Int
  fun matrix_long_max = gsl_matrix_long_max(m : MatrixLong*) : LibC::Long
  fun matrix_long_min = gsl_matrix_long_min(m : MatrixLong*) : LibC::Long
  fun matrix_long_minmax = gsl_matrix_long_minmax(m : MatrixLong*, min_out : LibC::Long*, max_out : LibC::Long*)
  fun matrix_long_max_index = gsl_matrix_long_max_index(m : MatrixLong*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_long_min_index = gsl_matrix_long_min_index(m : MatrixLong*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_long_minmax_index = gsl_matrix_long_minmax_index(m : MatrixLong*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_long_equal = gsl_matrix_long_equal(a : MatrixLong*, b : MatrixLong*) : LibC::Int
  fun matrix_long_isnull = gsl_matrix_long_isnull(m : MatrixLong*) : LibC::Int
  fun matrix_long_ispos = gsl_matrix_long_ispos(m : MatrixLong*) : LibC::Int
  fun matrix_long_isneg = gsl_matrix_long_isneg(m : MatrixLong*) : LibC::Int
  fun matrix_long_isnonneg = gsl_matrix_long_isnonneg(m : MatrixLong*) : LibC::Int
  fun matrix_long_add = gsl_matrix_long_add(a : MatrixLong*, b : MatrixLong*) : LibC::Int
  fun matrix_long_sub = gsl_matrix_long_sub(a : MatrixLong*, b : MatrixLong*) : LibC::Int
  fun matrix_long_mul_elements = gsl_matrix_long_mul_elements(a : MatrixLong*, b : MatrixLong*) : LibC::Int
  fun matrix_long_div_elements = gsl_matrix_long_div_elements(a : MatrixLong*, b : MatrixLong*) : LibC::Int
  fun matrix_long_scale = gsl_matrix_long_scale(a : MatrixLong*, x : LibC::Double) : LibC::Int
  fun matrix_long_add_constant = gsl_matrix_long_add_constant(a : MatrixLong*, x : LibC::Double) : LibC::Int
  fun matrix_long_add_diagonal = gsl_matrix_long_add_diagonal(a : MatrixLong*, x : LibC::Double) : LibC::Int
  fun matrix_long_get_row = gsl_matrix_long_get_row(v : VectorLong*, m : MatrixLong*, i : LibC::SizeT) : LibC::Int
  fun matrix_long_get_col = gsl_matrix_long_get_col(v : VectorLong*, m : MatrixLong*, j : LibC::SizeT) : LibC::Int
  fun matrix_long_set_row = gsl_matrix_long_set_row(m : MatrixLong*, i : LibC::SizeT, v : VectorLong*) : LibC::Int
  fun matrix_long_set_col = gsl_matrix_long_set_col(m : MatrixLong*, j : LibC::SizeT, v : VectorLong*) : LibC::Int
  fun matrix_long_get = gsl_matrix_long_get(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Long
  fun matrix_long_set = gsl_matrix_long_set(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::Long)
  fun matrix_long_ptr = gsl_matrix_long_ptr(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Long*
  fun matrix_long_const_ptr = gsl_matrix_long_const_ptr(m : MatrixLong*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Long*
  fun matrix_uint_alloc = gsl_matrix_uint_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUint*

  struct MatrixUint
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::UInt*
    block : BlockUint*
    owner : LibC::Int
  end

  fun matrix_uint_calloc = gsl_matrix_uint_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUint*
  fun matrix_uint_alloc_from_block = gsl_matrix_uint_alloc_from_block(b : BlockUint*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixUint*
  fun matrix_uint_alloc_from_matrix = gsl_matrix_uint_alloc_from_matrix(m : MatrixUint*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUint*
  fun vector_uint_alloc_row_from_matrix = gsl_vector_uint_alloc_row_from_matrix(m : MatrixUint*, i : LibC::SizeT) : VectorUint*
  fun vector_uint_alloc_col_from_matrix = gsl_vector_uint_alloc_col_from_matrix(m : MatrixUint*, j : LibC::SizeT) : VectorUint*
  fun matrix_uint_free = gsl_matrix_uint_free(m : MatrixUint*)
  fun matrix_uint_submatrix = gsl_matrix_uint_submatrix(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUintView

  struct X_GslMatrixUintView
    matrix : MatrixUint
  end

  fun matrix_uint_row = gsl_matrix_uint_row(m : MatrixUint*, i : LibC::SizeT) : X_GslVectorUintView
  fun matrix_uint_column = gsl_matrix_uint_column(m : MatrixUint*, j : LibC::SizeT) : X_GslVectorUintView
  fun matrix_uint_diagonal = gsl_matrix_uint_diagonal(m : MatrixUint*) : X_GslVectorUintView
  fun matrix_uint_subdiagonal = gsl_matrix_uint_subdiagonal(m : MatrixUint*, k : LibC::SizeT) : X_GslVectorUintView
  fun matrix_uint_superdiagonal = gsl_matrix_uint_superdiagonal(m : MatrixUint*, k : LibC::SizeT) : X_GslVectorUintView
  fun matrix_uint_subrow = gsl_matrix_uint_subrow(m : MatrixUint*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintView
  fun matrix_uint_subcolumn = gsl_matrix_uint_subcolumn(m : MatrixUint*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintView
  fun matrix_uint_view_array = gsl_matrix_uint_view_array(base : LibC::UInt*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUintView
  fun matrix_uint_view_array_with_tda = gsl_matrix_uint_view_array_with_tda(base : LibC::UInt*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUintView
  fun matrix_uint_view_vector = gsl_matrix_uint_view_vector(v : VectorUint*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUintView
  fun matrix_uint_view_vector_with_tda = gsl_matrix_uint_view_vector_with_tda(v : VectorUint*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUintView
  fun matrix_uint_const_submatrix = gsl_matrix_uint_const_submatrix(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUintConstView

  struct X_GslMatrixUintConstView
    matrix : MatrixUint
  end

  fun matrix_uint_const_row = gsl_matrix_uint_const_row(m : MatrixUint*, i : LibC::SizeT) : X_GslVectorUintConstView
  fun matrix_uint_const_column = gsl_matrix_uint_const_column(m : MatrixUint*, j : LibC::SizeT) : X_GslVectorUintConstView
  fun matrix_uint_const_diagonal = gsl_matrix_uint_const_diagonal(m : MatrixUint*) : X_GslVectorUintConstView
  fun matrix_uint_const_subdiagonal = gsl_matrix_uint_const_subdiagonal(m : MatrixUint*, k : LibC::SizeT) : X_GslVectorUintConstView
  fun matrix_uint_const_superdiagonal = gsl_matrix_uint_const_superdiagonal(m : MatrixUint*, k : LibC::SizeT) : X_GslVectorUintConstView
  fun matrix_uint_const_subrow = gsl_matrix_uint_const_subrow(m : MatrixUint*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintConstView
  fun matrix_uint_const_subcolumn = gsl_matrix_uint_const_subcolumn(m : MatrixUint*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUintConstView
  fun matrix_uint_const_view_array = gsl_matrix_uint_const_view_array(base : LibC::UInt*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUintConstView
  fun matrix_uint_const_view_array_with_tda = gsl_matrix_uint_const_view_array_with_tda(base : LibC::UInt*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUintConstView
  fun matrix_uint_const_view_vector = gsl_matrix_uint_const_view_vector(v : VectorUint*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUintConstView
  fun matrix_uint_const_view_vector_with_tda = gsl_matrix_uint_const_view_vector_with_tda(v : VectorUint*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUintConstView
  fun matrix_uint_set_zero = gsl_matrix_uint_set_zero(m : MatrixUint*)
  fun matrix_uint_set_identity = gsl_matrix_uint_set_identity(m : MatrixUint*)
  fun matrix_uint_set_all = gsl_matrix_uint_set_all(m : MatrixUint*, x : LibC::UInt)
  fun matrix_uint_fread = gsl_matrix_uint_fread(stream : File*, m : MatrixUint*) : LibC::Int
  fun matrix_uint_fwrite = gsl_matrix_uint_fwrite(stream : File*, m : MatrixUint*) : LibC::Int
  fun matrix_uint_fscanf = gsl_matrix_uint_fscanf(stream : File*, m : MatrixUint*) : LibC::Int
  fun matrix_uint_fprintf = gsl_matrix_uint_fprintf(stream : File*, m : MatrixUint*, format : LibC::Char*) : LibC::Int
  fun matrix_uint_memcpy = gsl_matrix_uint_memcpy(dest : MatrixUint*, src : MatrixUint*) : LibC::Int
  fun matrix_uint_swap = gsl_matrix_uint_swap(m1 : MatrixUint*, m2 : MatrixUint*) : LibC::Int
  fun matrix_uint_tricpy = gsl_matrix_uint_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixUint*, src : MatrixUint*) : LibC::Int
  fun matrix_uint_swap_rows = gsl_matrix_uint_swap_rows(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_uint_swap_columns = gsl_matrix_uint_swap_columns(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_uint_swap_rowcol = gsl_matrix_uint_swap_rowcol(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_uint_transpose = gsl_matrix_uint_transpose(m : MatrixUint*) : LibC::Int
  fun matrix_uint_transpose_memcpy = gsl_matrix_uint_transpose_memcpy(dest : MatrixUint*, src : MatrixUint*) : LibC::Int
  fun matrix_uint_transpose_tricpy = gsl_matrix_uint_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixUint*, src : MatrixUint*) : LibC::Int
  fun matrix_uint_max = gsl_matrix_uint_max(m : MatrixUint*) : LibC::UInt
  fun matrix_uint_min = gsl_matrix_uint_min(m : MatrixUint*) : LibC::UInt
  fun matrix_uint_minmax = gsl_matrix_uint_minmax(m : MatrixUint*, min_out : LibC::UInt*, max_out : LibC::UInt*)
  fun matrix_uint_max_index = gsl_matrix_uint_max_index(m : MatrixUint*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_uint_min_index = gsl_matrix_uint_min_index(m : MatrixUint*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_uint_minmax_index = gsl_matrix_uint_minmax_index(m : MatrixUint*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_uint_equal = gsl_matrix_uint_equal(a : MatrixUint*, b : MatrixUint*) : LibC::Int
  fun matrix_uint_isnull = gsl_matrix_uint_isnull(m : MatrixUint*) : LibC::Int
  fun matrix_uint_ispos = gsl_matrix_uint_ispos(m : MatrixUint*) : LibC::Int
  fun matrix_uint_isneg = gsl_matrix_uint_isneg(m : MatrixUint*) : LibC::Int
  fun matrix_uint_isnonneg = gsl_matrix_uint_isnonneg(m : MatrixUint*) : LibC::Int
  fun matrix_uint_add = gsl_matrix_uint_add(a : MatrixUint*, b : MatrixUint*) : LibC::Int
  fun matrix_uint_sub = gsl_matrix_uint_sub(a : MatrixUint*, b : MatrixUint*) : LibC::Int
  fun matrix_uint_mul_elements = gsl_matrix_uint_mul_elements(a : MatrixUint*, b : MatrixUint*) : LibC::Int
  fun matrix_uint_div_elements = gsl_matrix_uint_div_elements(a : MatrixUint*, b : MatrixUint*) : LibC::Int
  fun matrix_uint_scale = gsl_matrix_uint_scale(a : MatrixUint*, x : LibC::Double) : LibC::Int
  fun matrix_uint_add_constant = gsl_matrix_uint_add_constant(a : MatrixUint*, x : LibC::Double) : LibC::Int
  fun matrix_uint_add_diagonal = gsl_matrix_uint_add_diagonal(a : MatrixUint*, x : LibC::Double) : LibC::Int
  fun matrix_uint_get_row = gsl_matrix_uint_get_row(v : VectorUint*, m : MatrixUint*, i : LibC::SizeT) : LibC::Int
  fun matrix_uint_get_col = gsl_matrix_uint_get_col(v : VectorUint*, m : MatrixUint*, j : LibC::SizeT) : LibC::Int
  fun matrix_uint_set_row = gsl_matrix_uint_set_row(m : MatrixUint*, i : LibC::SizeT, v : VectorUint*) : LibC::Int
  fun matrix_uint_set_col = gsl_matrix_uint_set_col(m : MatrixUint*, j : LibC::SizeT, v : VectorUint*) : LibC::Int
  fun matrix_uint_get = gsl_matrix_uint_get(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT) : LibC::UInt
  fun matrix_uint_set = gsl_matrix_uint_set(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::UInt)
  fun matrix_uint_ptr = gsl_matrix_uint_ptr(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT) : LibC::UInt*
  fun matrix_uint_const_ptr = gsl_matrix_uint_const_ptr(m : MatrixUint*, i : LibC::SizeT, j : LibC::SizeT) : LibC::UInt*
  fun matrix_int_alloc = gsl_matrix_int_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixInt*

  struct MatrixInt
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::Int*
    block : BlockInt*
    owner : LibC::Int
  end

  fun matrix_int_calloc = gsl_matrix_int_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixInt*
  fun matrix_int_alloc_from_block = gsl_matrix_int_alloc_from_block(b : BlockInt*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixInt*
  fun matrix_int_alloc_from_matrix = gsl_matrix_int_alloc_from_matrix(m : MatrixInt*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixInt*
  fun vector_int_alloc_row_from_matrix = gsl_vector_int_alloc_row_from_matrix(m : MatrixInt*, i : LibC::SizeT) : VectorInt*
  fun vector_int_alloc_col_from_matrix = gsl_vector_int_alloc_col_from_matrix(m : MatrixInt*, j : LibC::SizeT) : VectorInt*
  fun matrix_int_free = gsl_matrix_int_free(m : MatrixInt*)
  fun matrix_int_submatrix = gsl_matrix_int_submatrix(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixIntView

  struct X_GslMatrixIntView
    matrix : MatrixInt
  end

  fun matrix_int_row = gsl_matrix_int_row(m : MatrixInt*, i : LibC::SizeT) : X_GslVectorIntView
  fun matrix_int_column = gsl_matrix_int_column(m : MatrixInt*, j : LibC::SizeT) : X_GslVectorIntView
  fun matrix_int_diagonal = gsl_matrix_int_diagonal(m : MatrixInt*) : X_GslVectorIntView
  fun matrix_int_subdiagonal = gsl_matrix_int_subdiagonal(m : MatrixInt*, k : LibC::SizeT) : X_GslVectorIntView
  fun matrix_int_superdiagonal = gsl_matrix_int_superdiagonal(m : MatrixInt*, k : LibC::SizeT) : X_GslVectorIntView
  fun matrix_int_subrow = gsl_matrix_int_subrow(m : MatrixInt*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntView
  fun matrix_int_subcolumn = gsl_matrix_int_subcolumn(m : MatrixInt*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntView
  fun matrix_int_view_array = gsl_matrix_int_view_array(base : LibC::Int*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixIntView
  fun matrix_int_view_array_with_tda = gsl_matrix_int_view_array_with_tda(base : LibC::Int*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixIntView
  fun matrix_int_view_vector = gsl_matrix_int_view_vector(v : VectorInt*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixIntView
  fun matrix_int_view_vector_with_tda = gsl_matrix_int_view_vector_with_tda(v : VectorInt*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixIntView
  fun matrix_int_const_submatrix = gsl_matrix_int_const_submatrix(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixIntConstView

  struct X_GslMatrixIntConstView
    matrix : MatrixInt
  end

  fun matrix_int_const_row = gsl_matrix_int_const_row(m : MatrixInt*, i : LibC::SizeT) : X_GslVectorIntConstView
  fun matrix_int_const_column = gsl_matrix_int_const_column(m : MatrixInt*, j : LibC::SizeT) : X_GslVectorIntConstView
  fun matrix_int_const_diagonal = gsl_matrix_int_const_diagonal(m : MatrixInt*) : X_GslVectorIntConstView
  fun matrix_int_const_subdiagonal = gsl_matrix_int_const_subdiagonal(m : MatrixInt*, k : LibC::SizeT) : X_GslVectorIntConstView
  fun matrix_int_const_superdiagonal = gsl_matrix_int_const_superdiagonal(m : MatrixInt*, k : LibC::SizeT) : X_GslVectorIntConstView
  fun matrix_int_const_subrow = gsl_matrix_int_const_subrow(m : MatrixInt*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntConstView
  fun matrix_int_const_subcolumn = gsl_matrix_int_const_subcolumn(m : MatrixInt*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorIntConstView
  fun matrix_int_const_view_array = gsl_matrix_int_const_view_array(base : LibC::Int*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixIntConstView
  fun matrix_int_const_view_array_with_tda = gsl_matrix_int_const_view_array_with_tda(base : LibC::Int*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixIntConstView
  fun matrix_int_const_view_vector = gsl_matrix_int_const_view_vector(v : VectorInt*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixIntConstView
  fun matrix_int_const_view_vector_with_tda = gsl_matrix_int_const_view_vector_with_tda(v : VectorInt*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixIntConstView
  fun matrix_int_set_zero = gsl_matrix_int_set_zero(m : MatrixInt*)
  fun matrix_int_set_identity = gsl_matrix_int_set_identity(m : MatrixInt*)
  fun matrix_int_set_all = gsl_matrix_int_set_all(m : MatrixInt*, x : LibC::Int)
  fun matrix_int_fread = gsl_matrix_int_fread(stream : File*, m : MatrixInt*) : LibC::Int
  fun matrix_int_fwrite = gsl_matrix_int_fwrite(stream : File*, m : MatrixInt*) : LibC::Int
  fun matrix_int_fscanf = gsl_matrix_int_fscanf(stream : File*, m : MatrixInt*) : LibC::Int
  fun matrix_int_fprintf = gsl_matrix_int_fprintf(stream : File*, m : MatrixInt*, format : LibC::Char*) : LibC::Int
  fun matrix_int_memcpy = gsl_matrix_int_memcpy(dest : MatrixInt*, src : MatrixInt*) : LibC::Int
  fun matrix_int_swap = gsl_matrix_int_swap(m1 : MatrixInt*, m2 : MatrixInt*) : LibC::Int
  fun matrix_int_tricpy = gsl_matrix_int_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixInt*, src : MatrixInt*) : LibC::Int
  fun matrix_int_swap_rows = gsl_matrix_int_swap_rows(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_int_swap_columns = gsl_matrix_int_swap_columns(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_int_swap_rowcol = gsl_matrix_int_swap_rowcol(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_int_transpose = gsl_matrix_int_transpose(m : MatrixInt*) : LibC::Int
  fun matrix_int_transpose_memcpy = gsl_matrix_int_transpose_memcpy(dest : MatrixInt*, src : MatrixInt*) : LibC::Int
  fun matrix_int_transpose_tricpy = gsl_matrix_int_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixInt*, src : MatrixInt*) : LibC::Int
  fun matrix_int_max = gsl_matrix_int_max(m : MatrixInt*) : LibC::Int
  fun matrix_int_min = gsl_matrix_int_min(m : MatrixInt*) : LibC::Int
  fun matrix_int_minmax = gsl_matrix_int_minmax(m : MatrixInt*, min_out : LibC::Int*, max_out : LibC::Int*)
  fun matrix_int_max_index = gsl_matrix_int_max_index(m : MatrixInt*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_int_min_index = gsl_matrix_int_min_index(m : MatrixInt*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_int_minmax_index = gsl_matrix_int_minmax_index(m : MatrixInt*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_int_equal = gsl_matrix_int_equal(a : MatrixInt*, b : MatrixInt*) : LibC::Int
  fun matrix_int_isnull = gsl_matrix_int_isnull(m : MatrixInt*) : LibC::Int
  fun matrix_int_ispos = gsl_matrix_int_ispos(m : MatrixInt*) : LibC::Int
  fun matrix_int_isneg = gsl_matrix_int_isneg(m : MatrixInt*) : LibC::Int
  fun matrix_int_isnonneg = gsl_matrix_int_isnonneg(m : MatrixInt*) : LibC::Int
  fun matrix_int_add = gsl_matrix_int_add(a : MatrixInt*, b : MatrixInt*) : LibC::Int
  fun matrix_int_sub = gsl_matrix_int_sub(a : MatrixInt*, b : MatrixInt*) : LibC::Int
  fun matrix_int_mul_elements = gsl_matrix_int_mul_elements(a : MatrixInt*, b : MatrixInt*) : LibC::Int
  fun matrix_int_div_elements = gsl_matrix_int_div_elements(a : MatrixInt*, b : MatrixInt*) : LibC::Int
  fun matrix_int_scale = gsl_matrix_int_scale(a : MatrixInt*, x : LibC::Double) : LibC::Int
  fun matrix_int_add_constant = gsl_matrix_int_add_constant(a : MatrixInt*, x : LibC::Double) : LibC::Int
  fun matrix_int_add_diagonal = gsl_matrix_int_add_diagonal(a : MatrixInt*, x : LibC::Double) : LibC::Int
  fun matrix_int_get_row = gsl_matrix_int_get_row(v : VectorInt*, m : MatrixInt*, i : LibC::SizeT) : LibC::Int
  fun matrix_int_get_col = gsl_matrix_int_get_col(v : VectorInt*, m : MatrixInt*, j : LibC::SizeT) : LibC::Int
  fun matrix_int_set_row = gsl_matrix_int_set_row(m : MatrixInt*, i : LibC::SizeT, v : VectorInt*) : LibC::Int
  fun matrix_int_set_col = gsl_matrix_int_set_col(m : MatrixInt*, j : LibC::SizeT, v : VectorInt*) : LibC::Int
  fun matrix_int_get = gsl_matrix_int_get(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_int_set = gsl_matrix_int_set(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::Int)
  fun matrix_int_ptr = gsl_matrix_int_ptr(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int*
  fun matrix_int_const_ptr = gsl_matrix_int_const_ptr(m : MatrixInt*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int*
  fun matrix_ushort_alloc = gsl_matrix_ushort_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUshort*

  struct MatrixUshort
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::UShort*
    block : BlockUshort*
    owner : LibC::Int
  end

  fun matrix_ushort_calloc = gsl_matrix_ushort_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUshort*
  fun matrix_ushort_alloc_from_block = gsl_matrix_ushort_alloc_from_block(b : BlockUshort*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixUshort*
  fun matrix_ushort_alloc_from_matrix = gsl_matrix_ushort_alloc_from_matrix(m : MatrixUshort*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUshort*
  fun vector_ushort_alloc_row_from_matrix = gsl_vector_ushort_alloc_row_from_matrix(m : MatrixUshort*, i : LibC::SizeT) : VectorUshort*
  fun vector_ushort_alloc_col_from_matrix = gsl_vector_ushort_alloc_col_from_matrix(m : MatrixUshort*, j : LibC::SizeT) : VectorUshort*
  fun matrix_ushort_free = gsl_matrix_ushort_free(m : MatrixUshort*)
  fun matrix_ushort_submatrix = gsl_matrix_ushort_submatrix(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUshortView

  struct X_GslMatrixUshortView
    matrix : MatrixUshort
  end

  fun matrix_ushort_row = gsl_matrix_ushort_row(m : MatrixUshort*, i : LibC::SizeT) : X_GslVectorUshortView
  fun matrix_ushort_column = gsl_matrix_ushort_column(m : MatrixUshort*, j : LibC::SizeT) : X_GslVectorUshortView
  fun matrix_ushort_diagonal = gsl_matrix_ushort_diagonal(m : MatrixUshort*) : X_GslVectorUshortView
  fun matrix_ushort_subdiagonal = gsl_matrix_ushort_subdiagonal(m : MatrixUshort*, k : LibC::SizeT) : X_GslVectorUshortView
  fun matrix_ushort_superdiagonal = gsl_matrix_ushort_superdiagonal(m : MatrixUshort*, k : LibC::SizeT) : X_GslVectorUshortView
  fun matrix_ushort_subrow = gsl_matrix_ushort_subrow(m : MatrixUshort*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortView
  fun matrix_ushort_subcolumn = gsl_matrix_ushort_subcolumn(m : MatrixUshort*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortView
  fun matrix_ushort_view_array = gsl_matrix_ushort_view_array(base : LibC::UShort*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUshortView
  fun matrix_ushort_view_array_with_tda = gsl_matrix_ushort_view_array_with_tda(base : LibC::UShort*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUshortView
  fun matrix_ushort_view_vector = gsl_matrix_ushort_view_vector(v : VectorUshort*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUshortView
  fun matrix_ushort_view_vector_with_tda = gsl_matrix_ushort_view_vector_with_tda(v : VectorUshort*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUshortView
  fun matrix_ushort_const_submatrix = gsl_matrix_ushort_const_submatrix(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUshortConstView

  struct X_GslMatrixUshortConstView
    matrix : MatrixUshort
  end

  fun matrix_ushort_const_row = gsl_matrix_ushort_const_row(m : MatrixUshort*, i : LibC::SizeT) : X_GslVectorUshortConstView
  fun matrix_ushort_const_column = gsl_matrix_ushort_const_column(m : MatrixUshort*, j : LibC::SizeT) : X_GslVectorUshortConstView
  fun matrix_ushort_const_diagonal = gsl_matrix_ushort_const_diagonal(m : MatrixUshort*) : X_GslVectorUshortConstView
  fun matrix_ushort_const_subdiagonal = gsl_matrix_ushort_const_subdiagonal(m : MatrixUshort*, k : LibC::SizeT) : X_GslVectorUshortConstView
  fun matrix_ushort_const_superdiagonal = gsl_matrix_ushort_const_superdiagonal(m : MatrixUshort*, k : LibC::SizeT) : X_GslVectorUshortConstView
  fun matrix_ushort_const_subrow = gsl_matrix_ushort_const_subrow(m : MatrixUshort*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortConstView
  fun matrix_ushort_const_subcolumn = gsl_matrix_ushort_const_subcolumn(m : MatrixUshort*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUshortConstView
  fun matrix_ushort_const_view_array = gsl_matrix_ushort_const_view_array(base : LibC::UShort*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUshortConstView
  fun matrix_ushort_const_view_array_with_tda = gsl_matrix_ushort_const_view_array_with_tda(base : LibC::UShort*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUshortConstView
  fun matrix_ushort_const_view_vector = gsl_matrix_ushort_const_view_vector(v : VectorUshort*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUshortConstView
  fun matrix_ushort_const_view_vector_with_tda = gsl_matrix_ushort_const_view_vector_with_tda(v : VectorUshort*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUshortConstView
  fun matrix_ushort_set_zero = gsl_matrix_ushort_set_zero(m : MatrixUshort*)
  fun matrix_ushort_set_identity = gsl_matrix_ushort_set_identity(m : MatrixUshort*)
  fun matrix_ushort_set_all = gsl_matrix_ushort_set_all(m : MatrixUshort*, x : LibC::UShort)
  fun matrix_ushort_fread = gsl_matrix_ushort_fread(stream : File*, m : MatrixUshort*) : LibC::Int
  fun matrix_ushort_fwrite = gsl_matrix_ushort_fwrite(stream : File*, m : MatrixUshort*) : LibC::Int
  fun matrix_ushort_fscanf = gsl_matrix_ushort_fscanf(stream : File*, m : MatrixUshort*) : LibC::Int
  fun matrix_ushort_fprintf = gsl_matrix_ushort_fprintf(stream : File*, m : MatrixUshort*, format : LibC::Char*) : LibC::Int
  fun matrix_ushort_memcpy = gsl_matrix_ushort_memcpy(dest : MatrixUshort*, src : MatrixUshort*) : LibC::Int
  fun matrix_ushort_swap = gsl_matrix_ushort_swap(m1 : MatrixUshort*, m2 : MatrixUshort*) : LibC::Int
  fun matrix_ushort_tricpy = gsl_matrix_ushort_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixUshort*, src : MatrixUshort*) : LibC::Int
  fun matrix_ushort_swap_rows = gsl_matrix_ushort_swap_rows(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_ushort_swap_columns = gsl_matrix_ushort_swap_columns(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_ushort_swap_rowcol = gsl_matrix_ushort_swap_rowcol(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_ushort_transpose = gsl_matrix_ushort_transpose(m : MatrixUshort*) : LibC::Int
  fun matrix_ushort_transpose_memcpy = gsl_matrix_ushort_transpose_memcpy(dest : MatrixUshort*, src : MatrixUshort*) : LibC::Int
  fun matrix_ushort_transpose_tricpy = gsl_matrix_ushort_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixUshort*, src : MatrixUshort*) : LibC::Int
  fun matrix_ushort_max = gsl_matrix_ushort_max(m : MatrixUshort*) : LibC::UShort
  fun matrix_ushort_min = gsl_matrix_ushort_min(m : MatrixUshort*) : LibC::UShort
  fun matrix_ushort_minmax = gsl_matrix_ushort_minmax(m : MatrixUshort*, min_out : LibC::UShort*, max_out : LibC::UShort*)
  fun matrix_ushort_max_index = gsl_matrix_ushort_max_index(m : MatrixUshort*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_ushort_min_index = gsl_matrix_ushort_min_index(m : MatrixUshort*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_ushort_minmax_index = gsl_matrix_ushort_minmax_index(m : MatrixUshort*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_ushort_equal = gsl_matrix_ushort_equal(a : MatrixUshort*, b : MatrixUshort*) : LibC::Int
  fun matrix_ushort_isnull = gsl_matrix_ushort_isnull(m : MatrixUshort*) : LibC::Int
  fun matrix_ushort_ispos = gsl_matrix_ushort_ispos(m : MatrixUshort*) : LibC::Int
  fun matrix_ushort_isneg = gsl_matrix_ushort_isneg(m : MatrixUshort*) : LibC::Int
  fun matrix_ushort_isnonneg = gsl_matrix_ushort_isnonneg(m : MatrixUshort*) : LibC::Int
  fun matrix_ushort_add = gsl_matrix_ushort_add(a : MatrixUshort*, b : MatrixUshort*) : LibC::Int
  fun matrix_ushort_sub = gsl_matrix_ushort_sub(a : MatrixUshort*, b : MatrixUshort*) : LibC::Int
  fun matrix_ushort_mul_elements = gsl_matrix_ushort_mul_elements(a : MatrixUshort*, b : MatrixUshort*) : LibC::Int
  fun matrix_ushort_div_elements = gsl_matrix_ushort_div_elements(a : MatrixUshort*, b : MatrixUshort*) : LibC::Int
  fun matrix_ushort_scale = gsl_matrix_ushort_scale(a : MatrixUshort*, x : LibC::Double) : LibC::Int
  fun matrix_ushort_add_constant = gsl_matrix_ushort_add_constant(a : MatrixUshort*, x : LibC::Double) : LibC::Int
  fun matrix_ushort_add_diagonal = gsl_matrix_ushort_add_diagonal(a : MatrixUshort*, x : LibC::Double) : LibC::Int
  fun matrix_ushort_get_row = gsl_matrix_ushort_get_row(v : VectorUshort*, m : MatrixUshort*, i : LibC::SizeT) : LibC::Int
  fun matrix_ushort_get_col = gsl_matrix_ushort_get_col(v : VectorUshort*, m : MatrixUshort*, j : LibC::SizeT) : LibC::Int
  fun matrix_ushort_set_row = gsl_matrix_ushort_set_row(m : MatrixUshort*, i : LibC::SizeT, v : VectorUshort*) : LibC::Int
  fun matrix_ushort_set_col = gsl_matrix_ushort_set_col(m : MatrixUshort*, j : LibC::SizeT, v : VectorUshort*) : LibC::Int
  fun matrix_ushort_get = gsl_matrix_ushort_get(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::UShort
  fun matrix_ushort_set = gsl_matrix_ushort_set(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::UShort)
  fun matrix_ushort_ptr = gsl_matrix_ushort_ptr(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::UShort*
  fun matrix_ushort_const_ptr = gsl_matrix_ushort_const_ptr(m : MatrixUshort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::UShort*
  fun matrix_short_alloc = gsl_matrix_short_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixShort*

  struct MatrixShort
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::Short*
    block : BlockShort*
    owner : LibC::Int
  end

  fun matrix_short_calloc = gsl_matrix_short_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixShort*
  fun matrix_short_alloc_from_block = gsl_matrix_short_alloc_from_block(b : BlockShort*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixShort*
  fun matrix_short_alloc_from_matrix = gsl_matrix_short_alloc_from_matrix(m : MatrixShort*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixShort*
  fun vector_short_alloc_row_from_matrix = gsl_vector_short_alloc_row_from_matrix(m : MatrixShort*, i : LibC::SizeT) : VectorShort*
  fun vector_short_alloc_col_from_matrix = gsl_vector_short_alloc_col_from_matrix(m : MatrixShort*, j : LibC::SizeT) : VectorShort*
  fun matrix_short_free = gsl_matrix_short_free(m : MatrixShort*)
  fun matrix_short_submatrix = gsl_matrix_short_submatrix(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixShortView

  struct X_GslMatrixShortView
    matrix : MatrixShort
  end

  fun matrix_short_row = gsl_matrix_short_row(m : MatrixShort*, i : LibC::SizeT) : X_GslVectorShortView
  fun matrix_short_column = gsl_matrix_short_column(m : MatrixShort*, j : LibC::SizeT) : X_GslVectorShortView
  fun matrix_short_diagonal = gsl_matrix_short_diagonal(m : MatrixShort*) : X_GslVectorShortView
  fun matrix_short_subdiagonal = gsl_matrix_short_subdiagonal(m : MatrixShort*, k : LibC::SizeT) : X_GslVectorShortView
  fun matrix_short_superdiagonal = gsl_matrix_short_superdiagonal(m : MatrixShort*, k : LibC::SizeT) : X_GslVectorShortView
  fun matrix_short_subrow = gsl_matrix_short_subrow(m : MatrixShort*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortView
  fun matrix_short_subcolumn = gsl_matrix_short_subcolumn(m : MatrixShort*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortView
  fun matrix_short_view_array = gsl_matrix_short_view_array(base : LibC::Short*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixShortView
  fun matrix_short_view_array_with_tda = gsl_matrix_short_view_array_with_tda(base : LibC::Short*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixShortView
  fun matrix_short_view_vector = gsl_matrix_short_view_vector(v : VectorShort*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixShortView
  fun matrix_short_view_vector_with_tda = gsl_matrix_short_view_vector_with_tda(v : VectorShort*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixShortView
  fun matrix_short_const_submatrix = gsl_matrix_short_const_submatrix(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixShortConstView

  struct X_GslMatrixShortConstView
    matrix : MatrixShort
  end

  fun matrix_short_const_row = gsl_matrix_short_const_row(m : MatrixShort*, i : LibC::SizeT) : X_GslVectorShortConstView
  fun matrix_short_const_column = gsl_matrix_short_const_column(m : MatrixShort*, j : LibC::SizeT) : X_GslVectorShortConstView
  fun matrix_short_const_diagonal = gsl_matrix_short_const_diagonal(m : MatrixShort*) : X_GslVectorShortConstView
  fun matrix_short_const_subdiagonal = gsl_matrix_short_const_subdiagonal(m : MatrixShort*, k : LibC::SizeT) : X_GslVectorShortConstView
  fun matrix_short_const_superdiagonal = gsl_matrix_short_const_superdiagonal(m : MatrixShort*, k : LibC::SizeT) : X_GslVectorShortConstView
  fun matrix_short_const_subrow = gsl_matrix_short_const_subrow(m : MatrixShort*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortConstView
  fun matrix_short_const_subcolumn = gsl_matrix_short_const_subcolumn(m : MatrixShort*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorShortConstView
  fun matrix_short_const_view_array = gsl_matrix_short_const_view_array(base : LibC::Short*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixShortConstView
  fun matrix_short_const_view_array_with_tda = gsl_matrix_short_const_view_array_with_tda(base : LibC::Short*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixShortConstView
  fun matrix_short_const_view_vector = gsl_matrix_short_const_view_vector(v : VectorShort*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixShortConstView
  fun matrix_short_const_view_vector_with_tda = gsl_matrix_short_const_view_vector_with_tda(v : VectorShort*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixShortConstView
  fun matrix_short_set_zero = gsl_matrix_short_set_zero(m : MatrixShort*)
  fun matrix_short_set_identity = gsl_matrix_short_set_identity(m : MatrixShort*)
  fun matrix_short_set_all = gsl_matrix_short_set_all(m : MatrixShort*, x : LibC::Short)
  fun matrix_short_fread = gsl_matrix_short_fread(stream : File*, m : MatrixShort*) : LibC::Int
  fun matrix_short_fwrite = gsl_matrix_short_fwrite(stream : File*, m : MatrixShort*) : LibC::Int
  fun matrix_short_fscanf = gsl_matrix_short_fscanf(stream : File*, m : MatrixShort*) : LibC::Int
  fun matrix_short_fprintf = gsl_matrix_short_fprintf(stream : File*, m : MatrixShort*, format : LibC::Char*) : LibC::Int
  fun matrix_short_memcpy = gsl_matrix_short_memcpy(dest : MatrixShort*, src : MatrixShort*) : LibC::Int
  fun matrix_short_swap = gsl_matrix_short_swap(m1 : MatrixShort*, m2 : MatrixShort*) : LibC::Int
  fun matrix_short_tricpy = gsl_matrix_short_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixShort*, src : MatrixShort*) : LibC::Int
  fun matrix_short_swap_rows = gsl_matrix_short_swap_rows(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_short_swap_columns = gsl_matrix_short_swap_columns(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_short_swap_rowcol = gsl_matrix_short_swap_rowcol(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_short_transpose = gsl_matrix_short_transpose(m : MatrixShort*) : LibC::Int
  fun matrix_short_transpose_memcpy = gsl_matrix_short_transpose_memcpy(dest : MatrixShort*, src : MatrixShort*) : LibC::Int
  fun matrix_short_transpose_tricpy = gsl_matrix_short_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixShort*, src : MatrixShort*) : LibC::Int
  fun matrix_short_max = gsl_matrix_short_max(m : MatrixShort*) : LibC::Short
  fun matrix_short_min = gsl_matrix_short_min(m : MatrixShort*) : LibC::Short
  fun matrix_short_minmax = gsl_matrix_short_minmax(m : MatrixShort*, min_out : LibC::Short*, max_out : LibC::Short*)
  fun matrix_short_max_index = gsl_matrix_short_max_index(m : MatrixShort*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_short_min_index = gsl_matrix_short_min_index(m : MatrixShort*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_short_minmax_index = gsl_matrix_short_minmax_index(m : MatrixShort*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_short_equal = gsl_matrix_short_equal(a : MatrixShort*, b : MatrixShort*) : LibC::Int
  fun matrix_short_isnull = gsl_matrix_short_isnull(m : MatrixShort*) : LibC::Int
  fun matrix_short_ispos = gsl_matrix_short_ispos(m : MatrixShort*) : LibC::Int
  fun matrix_short_isneg = gsl_matrix_short_isneg(m : MatrixShort*) : LibC::Int
  fun matrix_short_isnonneg = gsl_matrix_short_isnonneg(m : MatrixShort*) : LibC::Int
  fun matrix_short_add = gsl_matrix_short_add(a : MatrixShort*, b : MatrixShort*) : LibC::Int
  fun matrix_short_sub = gsl_matrix_short_sub(a : MatrixShort*, b : MatrixShort*) : LibC::Int
  fun matrix_short_mul_elements = gsl_matrix_short_mul_elements(a : MatrixShort*, b : MatrixShort*) : LibC::Int
  fun matrix_short_div_elements = gsl_matrix_short_div_elements(a : MatrixShort*, b : MatrixShort*) : LibC::Int
  fun matrix_short_scale = gsl_matrix_short_scale(a : MatrixShort*, x : LibC::Double) : LibC::Int
  fun matrix_short_add_constant = gsl_matrix_short_add_constant(a : MatrixShort*, x : LibC::Double) : LibC::Int
  fun matrix_short_add_diagonal = gsl_matrix_short_add_diagonal(a : MatrixShort*, x : LibC::Double) : LibC::Int
  fun matrix_short_get_row = gsl_matrix_short_get_row(v : VectorShort*, m : MatrixShort*, i : LibC::SizeT) : LibC::Int
  fun matrix_short_get_col = gsl_matrix_short_get_col(v : VectorShort*, m : MatrixShort*, j : LibC::SizeT) : LibC::Int
  fun matrix_short_set_row = gsl_matrix_short_set_row(m : MatrixShort*, i : LibC::SizeT, v : VectorShort*) : LibC::Int
  fun matrix_short_set_col = gsl_matrix_short_set_col(m : MatrixShort*, j : LibC::SizeT, v : VectorShort*) : LibC::Int
  fun matrix_short_get = gsl_matrix_short_get(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Short
  fun matrix_short_set = gsl_matrix_short_set(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::Short)
  fun matrix_short_ptr = gsl_matrix_short_ptr(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Short*
  fun matrix_short_const_ptr = gsl_matrix_short_const_ptr(m : MatrixShort*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Short*
  fun matrix_uchar_alloc = gsl_matrix_uchar_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUchar*

  struct MatrixUchar
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : UInt8*
    block : BlockUchar*
    owner : LibC::Int
  end

  fun matrix_uchar_calloc = gsl_matrix_uchar_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUchar*
  fun matrix_uchar_alloc_from_block = gsl_matrix_uchar_alloc_from_block(b : BlockUchar*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixUchar*
  fun matrix_uchar_alloc_from_matrix = gsl_matrix_uchar_alloc_from_matrix(m : MatrixUchar*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixUchar*
  fun vector_uchar_alloc_row_from_matrix = gsl_vector_uchar_alloc_row_from_matrix(m : MatrixUchar*, i : LibC::SizeT) : VectorUchar*
  fun vector_uchar_alloc_col_from_matrix = gsl_vector_uchar_alloc_col_from_matrix(m : MatrixUchar*, j : LibC::SizeT) : VectorUchar*
  fun matrix_uchar_free = gsl_matrix_uchar_free(m : MatrixUchar*)
  fun matrix_uchar_submatrix = gsl_matrix_uchar_submatrix(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUcharView

  struct X_GslMatrixUcharView
    matrix : MatrixUchar
  end

  fun matrix_uchar_row = gsl_matrix_uchar_row(m : MatrixUchar*, i : LibC::SizeT) : X_GslVectorUcharView
  fun matrix_uchar_column = gsl_matrix_uchar_column(m : MatrixUchar*, j : LibC::SizeT) : X_GslVectorUcharView
  fun matrix_uchar_diagonal = gsl_matrix_uchar_diagonal(m : MatrixUchar*) : X_GslVectorUcharView
  fun matrix_uchar_subdiagonal = gsl_matrix_uchar_subdiagonal(m : MatrixUchar*, k : LibC::SizeT) : X_GslVectorUcharView
  fun matrix_uchar_superdiagonal = gsl_matrix_uchar_superdiagonal(m : MatrixUchar*, k : LibC::SizeT) : X_GslVectorUcharView
  fun matrix_uchar_subrow = gsl_matrix_uchar_subrow(m : MatrixUchar*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharView
  fun matrix_uchar_subcolumn = gsl_matrix_uchar_subcolumn(m : MatrixUchar*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharView
  fun matrix_uchar_view_array = gsl_matrix_uchar_view_array(base : UInt8*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUcharView
  fun matrix_uchar_view_array_with_tda = gsl_matrix_uchar_view_array_with_tda(base : UInt8*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUcharView
  fun matrix_uchar_view_vector = gsl_matrix_uchar_view_vector(v : VectorUchar*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUcharView
  fun matrix_uchar_view_vector_with_tda = gsl_matrix_uchar_view_vector_with_tda(v : VectorUchar*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUcharView
  fun matrix_uchar_const_submatrix = gsl_matrix_uchar_const_submatrix(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUcharConstView

  struct X_GslMatrixUcharConstView
    matrix : MatrixUchar
  end

  fun matrix_uchar_const_row = gsl_matrix_uchar_const_row(m : MatrixUchar*, i : LibC::SizeT) : X_GslVectorUcharConstView
  fun matrix_uchar_const_column = gsl_matrix_uchar_const_column(m : MatrixUchar*, j : LibC::SizeT) : X_GslVectorUcharConstView
  fun matrix_uchar_const_diagonal = gsl_matrix_uchar_const_diagonal(m : MatrixUchar*) : X_GslVectorUcharConstView
  fun matrix_uchar_const_subdiagonal = gsl_matrix_uchar_const_subdiagonal(m : MatrixUchar*, k : LibC::SizeT) : X_GslVectorUcharConstView
  fun matrix_uchar_const_superdiagonal = gsl_matrix_uchar_const_superdiagonal(m : MatrixUchar*, k : LibC::SizeT) : X_GslVectorUcharConstView
  fun matrix_uchar_const_subrow = gsl_matrix_uchar_const_subrow(m : MatrixUchar*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharConstView
  fun matrix_uchar_const_subcolumn = gsl_matrix_uchar_const_subcolumn(m : MatrixUchar*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorUcharConstView
  fun matrix_uchar_const_view_array = gsl_matrix_uchar_const_view_array(base : UInt8*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUcharConstView
  fun matrix_uchar_const_view_array_with_tda = gsl_matrix_uchar_const_view_array_with_tda(base : UInt8*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUcharConstView
  fun matrix_uchar_const_view_vector = gsl_matrix_uchar_const_view_vector(v : VectorUchar*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixUcharConstView
  fun matrix_uchar_const_view_vector_with_tda = gsl_matrix_uchar_const_view_vector_with_tda(v : VectorUchar*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixUcharConstView
  fun matrix_uchar_set_zero = gsl_matrix_uchar_set_zero(m : MatrixUchar*)
  fun matrix_uchar_set_identity = gsl_matrix_uchar_set_identity(m : MatrixUchar*)
  fun matrix_uchar_set_all = gsl_matrix_uchar_set_all(m : MatrixUchar*, x : UInt8)
  fun matrix_uchar_fread = gsl_matrix_uchar_fread(stream : File*, m : MatrixUchar*) : LibC::Int
  fun matrix_uchar_fwrite = gsl_matrix_uchar_fwrite(stream : File*, m : MatrixUchar*) : LibC::Int
  fun matrix_uchar_fscanf = gsl_matrix_uchar_fscanf(stream : File*, m : MatrixUchar*) : LibC::Int
  fun matrix_uchar_fprintf = gsl_matrix_uchar_fprintf(stream : File*, m : MatrixUchar*, format : LibC::Char*) : LibC::Int
  fun matrix_uchar_memcpy = gsl_matrix_uchar_memcpy(dest : MatrixUchar*, src : MatrixUchar*) : LibC::Int
  fun matrix_uchar_swap = gsl_matrix_uchar_swap(m1 : MatrixUchar*, m2 : MatrixUchar*) : LibC::Int
  fun matrix_uchar_tricpy = gsl_matrix_uchar_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixUchar*, src : MatrixUchar*) : LibC::Int
  fun matrix_uchar_swap_rows = gsl_matrix_uchar_swap_rows(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_uchar_swap_columns = gsl_matrix_uchar_swap_columns(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_uchar_swap_rowcol = gsl_matrix_uchar_swap_rowcol(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_uchar_transpose = gsl_matrix_uchar_transpose(m : MatrixUchar*) : LibC::Int
  fun matrix_uchar_transpose_memcpy = gsl_matrix_uchar_transpose_memcpy(dest : MatrixUchar*, src : MatrixUchar*) : LibC::Int
  fun matrix_uchar_transpose_tricpy = gsl_matrix_uchar_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixUchar*, src : MatrixUchar*) : LibC::Int
  fun matrix_uchar_max = gsl_matrix_uchar_max(m : MatrixUchar*) : UInt8
  fun matrix_uchar_min = gsl_matrix_uchar_min(m : MatrixUchar*) : UInt8
  fun matrix_uchar_minmax = gsl_matrix_uchar_minmax(m : MatrixUchar*, min_out : UInt8*, max_out : UInt8*)
  fun matrix_uchar_max_index = gsl_matrix_uchar_max_index(m : MatrixUchar*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_uchar_min_index = gsl_matrix_uchar_min_index(m : MatrixUchar*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_uchar_minmax_index = gsl_matrix_uchar_minmax_index(m : MatrixUchar*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_uchar_equal = gsl_matrix_uchar_equal(a : MatrixUchar*, b : MatrixUchar*) : LibC::Int
  fun matrix_uchar_isnull = gsl_matrix_uchar_isnull(m : MatrixUchar*) : LibC::Int
  fun matrix_uchar_ispos = gsl_matrix_uchar_ispos(m : MatrixUchar*) : LibC::Int
  fun matrix_uchar_isneg = gsl_matrix_uchar_isneg(m : MatrixUchar*) : LibC::Int
  fun matrix_uchar_isnonneg = gsl_matrix_uchar_isnonneg(m : MatrixUchar*) : LibC::Int
  fun matrix_uchar_add = gsl_matrix_uchar_add(a : MatrixUchar*, b : MatrixUchar*) : LibC::Int
  fun matrix_uchar_sub = gsl_matrix_uchar_sub(a : MatrixUchar*, b : MatrixUchar*) : LibC::Int
  fun matrix_uchar_mul_elements = gsl_matrix_uchar_mul_elements(a : MatrixUchar*, b : MatrixUchar*) : LibC::Int
  fun matrix_uchar_div_elements = gsl_matrix_uchar_div_elements(a : MatrixUchar*, b : MatrixUchar*) : LibC::Int
  fun matrix_uchar_scale = gsl_matrix_uchar_scale(a : MatrixUchar*, x : LibC::Double) : LibC::Int
  fun matrix_uchar_add_constant = gsl_matrix_uchar_add_constant(a : MatrixUchar*, x : LibC::Double) : LibC::Int
  fun matrix_uchar_add_diagonal = gsl_matrix_uchar_add_diagonal(a : MatrixUchar*, x : LibC::Double) : LibC::Int
  fun matrix_uchar_get_row = gsl_matrix_uchar_get_row(v : VectorUchar*, m : MatrixUchar*, i : LibC::SizeT) : LibC::Int
  fun matrix_uchar_get_col = gsl_matrix_uchar_get_col(v : VectorUchar*, m : MatrixUchar*, j : LibC::SizeT) : LibC::Int
  fun matrix_uchar_set_row = gsl_matrix_uchar_set_row(m : MatrixUchar*, i : LibC::SizeT, v : VectorUchar*) : LibC::Int
  fun matrix_uchar_set_col = gsl_matrix_uchar_set_col(m : MatrixUchar*, j : LibC::SizeT, v : VectorUchar*) : LibC::Int
  fun matrix_uchar_get = gsl_matrix_uchar_get(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT) : UInt8
  fun matrix_uchar_set = gsl_matrix_uchar_set(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT, x : UInt8)
  fun matrix_uchar_ptr = gsl_matrix_uchar_ptr(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT) : UInt8*
  fun matrix_uchar_const_ptr = gsl_matrix_uchar_const_ptr(m : MatrixUchar*, i : LibC::SizeT, j : LibC::SizeT) : UInt8*
  fun matrix_char_alloc = gsl_matrix_char_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixChar*

  struct MatrixChar
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    tda : LibC::SizeT
    data : LibC::Char*
    block : BlockChar*
    owner : LibC::Int
  end

  fun matrix_char_calloc = gsl_matrix_char_calloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixChar*
  fun matrix_char_alloc_from_block = gsl_matrix_char_alloc_from_block(b : BlockChar*, offset : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT, d2 : LibC::SizeT) : MatrixChar*
  fun matrix_char_alloc_from_matrix = gsl_matrix_char_alloc_from_matrix(m : MatrixChar*, k1 : LibC::SizeT, k2 : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : MatrixChar*
  fun vector_char_alloc_row_from_matrix = gsl_vector_char_alloc_row_from_matrix(m : MatrixChar*, i : LibC::SizeT) : VectorChar*
  fun vector_char_alloc_col_from_matrix = gsl_vector_char_alloc_col_from_matrix(m : MatrixChar*, j : LibC::SizeT) : VectorChar*
  fun matrix_char_free = gsl_matrix_char_free(m : MatrixChar*)
  fun matrix_char_submatrix = gsl_matrix_char_submatrix(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixCharView

  struct X_GslMatrixCharView
    matrix : MatrixChar
  end

  fun matrix_char_row = gsl_matrix_char_row(m : MatrixChar*, i : LibC::SizeT) : X_GslVectorCharView
  fun matrix_char_column = gsl_matrix_char_column(m : MatrixChar*, j : LibC::SizeT) : X_GslVectorCharView
  fun matrix_char_diagonal = gsl_matrix_char_diagonal(m : MatrixChar*) : X_GslVectorCharView
  fun matrix_char_subdiagonal = gsl_matrix_char_subdiagonal(m : MatrixChar*, k : LibC::SizeT) : X_GslVectorCharView
  fun matrix_char_superdiagonal = gsl_matrix_char_superdiagonal(m : MatrixChar*, k : LibC::SizeT) : X_GslVectorCharView
  fun matrix_char_subrow = gsl_matrix_char_subrow(m : MatrixChar*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharView
  fun matrix_char_subcolumn = gsl_matrix_char_subcolumn(m : MatrixChar*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharView
  fun matrix_char_view_array = gsl_matrix_char_view_array(base : LibC::Char*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixCharView
  fun matrix_char_view_array_with_tda = gsl_matrix_char_view_array_with_tda(base : LibC::Char*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixCharView
  fun matrix_char_view_vector = gsl_matrix_char_view_vector(v : VectorChar*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixCharView
  fun matrix_char_view_vector_with_tda = gsl_matrix_char_view_vector_with_tda(v : VectorChar*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixCharView
  fun matrix_char_const_submatrix = gsl_matrix_char_const_submatrix(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixCharConstView

  struct X_GslMatrixCharConstView
    matrix : MatrixChar
  end

  fun matrix_char_const_row = gsl_matrix_char_const_row(m : MatrixChar*, i : LibC::SizeT) : X_GslVectorCharConstView
  fun matrix_char_const_column = gsl_matrix_char_const_column(m : MatrixChar*, j : LibC::SizeT) : X_GslVectorCharConstView
  fun matrix_char_const_diagonal = gsl_matrix_char_const_diagonal(m : MatrixChar*) : X_GslVectorCharConstView
  fun matrix_char_const_subdiagonal = gsl_matrix_char_const_subdiagonal(m : MatrixChar*, k : LibC::SizeT) : X_GslVectorCharConstView
  fun matrix_char_const_superdiagonal = gsl_matrix_char_const_superdiagonal(m : MatrixChar*, k : LibC::SizeT) : X_GslVectorCharConstView
  fun matrix_char_const_subrow = gsl_matrix_char_const_subrow(m : MatrixChar*, i : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharConstView
  fun matrix_char_const_subcolumn = gsl_matrix_char_const_subcolumn(m : MatrixChar*, j : LibC::SizeT, offset : LibC::SizeT, n : LibC::SizeT) : X_GslVectorCharConstView
  fun matrix_char_const_view_array = gsl_matrix_char_const_view_array(base : LibC::Char*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixCharConstView
  fun matrix_char_const_view_array_with_tda = gsl_matrix_char_const_view_array_with_tda(base : LibC::Char*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixCharConstView
  fun matrix_char_const_view_vector = gsl_matrix_char_const_view_vector(v : VectorChar*, n1 : LibC::SizeT, n2 : LibC::SizeT) : X_GslMatrixCharConstView
  fun matrix_char_const_view_vector_with_tda = gsl_matrix_char_const_view_vector_with_tda(v : VectorChar*, n1 : LibC::SizeT, n2 : LibC::SizeT, tda : LibC::SizeT) : X_GslMatrixCharConstView
  fun matrix_char_set_zero = gsl_matrix_char_set_zero(m : MatrixChar*)
  fun matrix_char_set_identity = gsl_matrix_char_set_identity(m : MatrixChar*)
  fun matrix_char_set_all = gsl_matrix_char_set_all(m : MatrixChar*, x : LibC::Char)
  fun matrix_char_fread = gsl_matrix_char_fread(stream : File*, m : MatrixChar*) : LibC::Int
  fun matrix_char_fwrite = gsl_matrix_char_fwrite(stream : File*, m : MatrixChar*) : LibC::Int
  fun matrix_char_fscanf = gsl_matrix_char_fscanf(stream : File*, m : MatrixChar*) : LibC::Int
  fun matrix_char_fprintf = gsl_matrix_char_fprintf(stream : File*, m : MatrixChar*, format : LibC::Char*) : LibC::Int
  fun matrix_char_memcpy = gsl_matrix_char_memcpy(dest : MatrixChar*, src : MatrixChar*) : LibC::Int
  fun matrix_char_swap = gsl_matrix_char_swap(m1 : MatrixChar*, m2 : MatrixChar*) : LibC::Int
  fun matrix_char_tricpy = gsl_matrix_char_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixChar*, src : MatrixChar*) : LibC::Int
  fun matrix_char_swap_rows = gsl_matrix_char_swap_rows(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_char_swap_columns = gsl_matrix_char_swap_columns(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_char_swap_rowcol = gsl_matrix_char_swap_rowcol(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun matrix_char_transpose = gsl_matrix_char_transpose(m : MatrixChar*) : LibC::Int
  fun matrix_char_transpose_memcpy = gsl_matrix_char_transpose_memcpy(dest : MatrixChar*, src : MatrixChar*) : LibC::Int
  fun matrix_char_transpose_tricpy = gsl_matrix_char_transpose_tricpy(uplo_src : LibC::Char, copy_diag : LibC::Int, dest : MatrixChar*, src : MatrixChar*) : LibC::Int
  fun matrix_char_max = gsl_matrix_char_max(m : MatrixChar*) : LibC::Char
  fun matrix_char_min = gsl_matrix_char_min(m : MatrixChar*) : LibC::Char
  fun matrix_char_minmax = gsl_matrix_char_minmax(m : MatrixChar*, min_out : LibC::Char*, max_out : LibC::Char*)
  fun matrix_char_max_index = gsl_matrix_char_max_index(m : MatrixChar*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_char_min_index = gsl_matrix_char_min_index(m : MatrixChar*, imin : LibC::SizeT*, jmin : LibC::SizeT*)
  fun matrix_char_minmax_index = gsl_matrix_char_minmax_index(m : MatrixChar*, imin : LibC::SizeT*, jmin : LibC::SizeT*, imax : LibC::SizeT*, jmax : LibC::SizeT*)
  fun matrix_char_equal = gsl_matrix_char_equal(a : MatrixChar*, b : MatrixChar*) : LibC::Int
  fun matrix_char_isnull = gsl_matrix_char_isnull(m : MatrixChar*) : LibC::Int
  fun matrix_char_ispos = gsl_matrix_char_ispos(m : MatrixChar*) : LibC::Int
  fun matrix_char_isneg = gsl_matrix_char_isneg(m : MatrixChar*) : LibC::Int
  fun matrix_char_isnonneg = gsl_matrix_char_isnonneg(m : MatrixChar*) : LibC::Int
  fun matrix_char_add = gsl_matrix_char_add(a : MatrixChar*, b : MatrixChar*) : LibC::Int
  fun matrix_char_sub = gsl_matrix_char_sub(a : MatrixChar*, b : MatrixChar*) : LibC::Int
  fun matrix_char_mul_elements = gsl_matrix_char_mul_elements(a : MatrixChar*, b : MatrixChar*) : LibC::Int
  fun matrix_char_div_elements = gsl_matrix_char_div_elements(a : MatrixChar*, b : MatrixChar*) : LibC::Int
  fun matrix_char_scale = gsl_matrix_char_scale(a : MatrixChar*, x : LibC::Double) : LibC::Int
  fun matrix_char_add_constant = gsl_matrix_char_add_constant(a : MatrixChar*, x : LibC::Double) : LibC::Int
  fun matrix_char_add_diagonal = gsl_matrix_char_add_diagonal(a : MatrixChar*, x : LibC::Double) : LibC::Int
  fun matrix_char_get_row = gsl_matrix_char_get_row(v : VectorChar*, m : MatrixChar*, i : LibC::SizeT) : LibC::Int
  fun matrix_char_get_col = gsl_matrix_char_get_col(v : VectorChar*, m : MatrixChar*, j : LibC::SizeT) : LibC::Int
  fun matrix_char_set_row = gsl_matrix_char_set_row(m : MatrixChar*, i : LibC::SizeT, v : VectorChar*) : LibC::Int
  fun matrix_char_set_col = gsl_matrix_char_set_col(m : MatrixChar*, j : LibC::SizeT, v : VectorChar*) : LibC::Int
  fun matrix_char_get = gsl_matrix_char_get(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Char
  fun matrix_char_set = gsl_matrix_char_set(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::Char)
  fun matrix_char_ptr = gsl_matrix_char_ptr(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Char*
  fun matrix_char_const_ptr = gsl_matrix_char_const_ptr(m : MatrixChar*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Char*
  fun blas_sdsdot = gsl_blas_sdsdot(alpha : LibC::Float, x : VectorFloat*, y : VectorFloat*, result : LibC::Float*) : LibC::Int
  fun blas_dsdot = gsl_blas_dsdot(x : VectorFloat*, y : VectorFloat*, result : LibC::Double*) : LibC::Int
  fun blas_sdot = gsl_blas_sdot(x : VectorFloat*, y : VectorFloat*, result : LibC::Float*) : LibC::Int
  fun blas_ddot = gsl_blas_ddot(x : Vector*, y : Vector*, result : LibC::Double*) : LibC::Int
  fun blas_cdotu = gsl_blas_cdotu(x : VectorComplexFloat*, y : VectorComplexFloat*, dotu : ComplexFloat*) : LibC::Int
  fun blas_cdotc = gsl_blas_cdotc(x : VectorComplexFloat*, y : VectorComplexFloat*, dotc : ComplexFloat*) : LibC::Int
  fun blas_zdotu = gsl_blas_zdotu(x : VectorComplex*, y : VectorComplex*, dotu : Complex*) : LibC::Int
  fun blas_zdotc = gsl_blas_zdotc(x : VectorComplex*, y : VectorComplex*, dotc : Complex*) : LibC::Int
  fun blas_snrm2 = gsl_blas_snrm2(x : VectorFloat*) : LibC::Float
  fun blas_sasum = gsl_blas_sasum(x : VectorFloat*) : LibC::Float
  fun blas_dnrm2 = gsl_blas_dnrm2(x : Vector*) : LibC::Double
  fun blas_dasum = gsl_blas_dasum(x : Vector*) : LibC::Double
  fun blas_scnrm2 = gsl_blas_scnrm2(x : VectorComplexFloat*) : LibC::Float
  fun blas_scasum = gsl_blas_scasum(x : VectorComplexFloat*) : LibC::Float
  fun blas_dznrm2 = gsl_blas_dznrm2(x : VectorComplex*) : LibC::Double
  fun blas_dzasum = gsl_blas_dzasum(x : VectorComplex*) : LibC::Double
  fun blas_isamax = gsl_blas_isamax(x : VectorFloat*) : CblasIndexT
  alias CblasIndexT = LibC::SizeT
  fun blas_idamax = gsl_blas_idamax(x : Vector*) : CblasIndexT
  fun blas_icamax = gsl_blas_icamax(x : VectorComplexFloat*) : CblasIndexT
  fun blas_izamax = gsl_blas_izamax(x : VectorComplex*) : CblasIndexT
  fun blas_sswap = gsl_blas_sswap(x : VectorFloat*, y : VectorFloat*) : LibC::Int
  fun blas_scopy = gsl_blas_scopy(x : VectorFloat*, y : VectorFloat*) : LibC::Int
  fun blas_saxpy = gsl_blas_saxpy(alpha : LibC::Float, x : VectorFloat*, y : VectorFloat*) : LibC::Int
  fun blas_dswap = gsl_blas_dswap(x : Vector*, y : Vector*) : LibC::Int
  fun blas_dcopy = gsl_blas_dcopy(x : Vector*, y : Vector*) : LibC::Int
  fun blas_daxpy = gsl_blas_daxpy(alpha : LibC::Double, x : Vector*, y : Vector*) : LibC::Int
  fun blas_cswap = gsl_blas_cswap(x : VectorComplexFloat*, y : VectorComplexFloat*) : LibC::Int
  fun blas_ccopy = gsl_blas_ccopy(x : VectorComplexFloat*, y : VectorComplexFloat*) : LibC::Int
  fun blas_caxpy = gsl_blas_caxpy(alpha : ComplexFloat, x : VectorComplexFloat*, y : VectorComplexFloat*) : LibC::Int
  fun blas_zswap = gsl_blas_zswap(x : VectorComplex*, y : VectorComplex*) : LibC::Int
  fun blas_zcopy = gsl_blas_zcopy(x : VectorComplex*, y : VectorComplex*) : LibC::Int
  fun blas_zaxpy = gsl_blas_zaxpy(alpha : Complex, x : VectorComplex*, y : VectorComplex*) : LibC::Int
  fun blas_srotg = gsl_blas_srotg(a : LibC::Float*, b : LibC::Float*, c : LibC::Float*, s : LibC::Float*) : LibC::Int
  fun blas_srotmg = gsl_blas_srotmg(d1 : LibC::Float*, d2 : LibC::Float*, b1 : LibC::Float*, b2 : LibC::Float, p : LibC::Float*) : LibC::Int
  fun blas_srot = gsl_blas_srot(x : VectorFloat*, y : VectorFloat*, c : LibC::Float, s : LibC::Float) : LibC::Int
  fun blas_srotm = gsl_blas_srotm(x : VectorFloat*, y : VectorFloat*, p : LibC::Float*) : LibC::Int
  fun blas_drotg = gsl_blas_drotg(a : LibC::Double*, b : LibC::Double*, c : LibC::Double*, s : LibC::Double*) : LibC::Int
  fun blas_drotmg = gsl_blas_drotmg(d1 : LibC::Double*, d2 : LibC::Double*, b1 : LibC::Double*, b2 : LibC::Double, p : LibC::Double*) : LibC::Int
  fun blas_drot = gsl_blas_drot(x : Vector*, y : Vector*, c : LibC::Double, s : LibC::Double) : LibC::Int
  fun blas_drotm = gsl_blas_drotm(x : Vector*, y : Vector*, p : LibC::Double*) : LibC::Int
  fun blas_sscal = gsl_blas_sscal(alpha : LibC::Float, x : VectorFloat*)
  fun blas_dscal = gsl_blas_dscal(alpha : LibC::Double, x : Vector*)
  fun blas_cscal = gsl_blas_cscal(alpha : ComplexFloat, x : VectorComplexFloat*)
  fun blas_zscal = gsl_blas_zscal(alpha : Complex, x : VectorComplex*)
  fun blas_csscal = gsl_blas_csscal(alpha : LibC::Float, x : VectorComplexFloat*)
  fun blas_zdscal = gsl_blas_zdscal(alpha : LibC::Double, x : VectorComplex*)
  fun blas_sgemv = gsl_blas_sgemv(trans_a : CblasTransposeT, alpha : LibC::Float, a : MatrixFloat*, x : VectorFloat*, beta : LibC::Float, y : VectorFloat*) : LibC::Int
  enum CblasTransposeT
    CblasNoTrans   = 111
    CblasTrans     = 112
    CblasConjTrans = 113
  end
  fun blas_strmv = gsl_blas_strmv(uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, a : MatrixFloat*, x : VectorFloat*) : LibC::Int
  enum CblasUploT
    CblasUpper = 121
    CblasLower = 122
  end
  enum CblasDiagT
    CblasNonUnit = 131
    CblasUnit    = 132
  end
  fun blas_strsv = gsl_blas_strsv(uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, a : MatrixFloat*, x : VectorFloat*) : LibC::Int
  fun blas_dgemv = gsl_blas_dgemv(trans_a : CblasTransposeT, alpha : LibC::Double, a : Matrix*, x : Vector*, beta : LibC::Double, y : Vector*) : LibC::Int
  fun blas_dtrmv = gsl_blas_dtrmv(uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, a : Matrix*, x : Vector*) : LibC::Int
  fun blas_dtrsv = gsl_blas_dtrsv(uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, a : Matrix*, x : Vector*) : LibC::Int
  fun blas_cgemv = gsl_blas_cgemv(trans_a : CblasTransposeT, alpha : ComplexFloat, a : MatrixComplexFloat*, x : VectorComplexFloat*, beta : ComplexFloat, y : VectorComplexFloat*) : LibC::Int
  fun blas_ctrmv = gsl_blas_ctrmv(uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, a : MatrixComplexFloat*, x : VectorComplexFloat*) : LibC::Int
  fun blas_ctrsv = gsl_blas_ctrsv(uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, a : MatrixComplexFloat*, x : VectorComplexFloat*) : LibC::Int
  fun blas_zgemv = gsl_blas_zgemv(trans_a : CblasTransposeT, alpha : Complex, a : MatrixComplex*, x : VectorComplex*, beta : Complex, y : VectorComplex*) : LibC::Int
  fun blas_ztrmv = gsl_blas_ztrmv(uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, a : MatrixComplex*, x : VectorComplex*) : LibC::Int
  fun blas_ztrsv = gsl_blas_ztrsv(uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, a : MatrixComplex*, x : VectorComplex*) : LibC::Int
  fun blas_ssymv = gsl_blas_ssymv(uplo : CblasUploT, alpha : LibC::Float, a : MatrixFloat*, x : VectorFloat*, beta : LibC::Float, y : VectorFloat*) : LibC::Int
  fun blas_sger = gsl_blas_sger(alpha : LibC::Float, x : VectorFloat*, y : VectorFloat*, a : MatrixFloat*) : LibC::Int
  fun blas_ssyr = gsl_blas_ssyr(uplo : CblasUploT, alpha : LibC::Float, x : VectorFloat*, a : MatrixFloat*) : LibC::Int
  fun blas_ssyr2 = gsl_blas_ssyr2(uplo : CblasUploT, alpha : LibC::Float, x : VectorFloat*, y : VectorFloat*, a : MatrixFloat*) : LibC::Int
  fun blas_dsymv = gsl_blas_dsymv(uplo : CblasUploT, alpha : LibC::Double, a : Matrix*, x : Vector*, beta : LibC::Double, y : Vector*) : LibC::Int
  fun blas_dger = gsl_blas_dger(alpha : LibC::Double, x : Vector*, y : Vector*, a : Matrix*) : LibC::Int
  fun blas_dsyr = gsl_blas_dsyr(uplo : CblasUploT, alpha : LibC::Double, x : Vector*, a : Matrix*) : LibC::Int
  fun blas_dsyr2 = gsl_blas_dsyr2(uplo : CblasUploT, alpha : LibC::Double, x : Vector*, y : Vector*, a : Matrix*) : LibC::Int
  fun blas_chemv = gsl_blas_chemv(uplo : CblasUploT, alpha : ComplexFloat, a : MatrixComplexFloat*, x : VectorComplexFloat*, beta : ComplexFloat, y : VectorComplexFloat*) : LibC::Int
  fun blas_cgeru = gsl_blas_cgeru(alpha : ComplexFloat, x : VectorComplexFloat*, y : VectorComplexFloat*, a : MatrixComplexFloat*) : LibC::Int
  fun blas_cgerc = gsl_blas_cgerc(alpha : ComplexFloat, x : VectorComplexFloat*, y : VectorComplexFloat*, a : MatrixComplexFloat*) : LibC::Int
  fun blas_cher = gsl_blas_cher(uplo : CblasUploT, alpha : LibC::Float, x : VectorComplexFloat*, a : MatrixComplexFloat*) : LibC::Int
  fun blas_cher2 = gsl_blas_cher2(uplo : CblasUploT, alpha : ComplexFloat, x : VectorComplexFloat*, y : VectorComplexFloat*, a : MatrixComplexFloat*) : LibC::Int
  fun blas_zhemv = gsl_blas_zhemv(uplo : CblasUploT, alpha : Complex, a : MatrixComplex*, x : VectorComplex*, beta : Complex, y : VectorComplex*) : LibC::Int
  fun blas_zgeru = gsl_blas_zgeru(alpha : Complex, x : VectorComplex*, y : VectorComplex*, a : MatrixComplex*) : LibC::Int
  fun blas_zgerc = gsl_blas_zgerc(alpha : Complex, x : VectorComplex*, y : VectorComplex*, a : MatrixComplex*) : LibC::Int
  fun blas_zher = gsl_blas_zher(uplo : CblasUploT, alpha : LibC::Double, x : VectorComplex*, a : MatrixComplex*) : LibC::Int
  fun blas_zher2 = gsl_blas_zher2(uplo : CblasUploT, alpha : Complex, x : VectorComplex*, y : VectorComplex*, a : MatrixComplex*) : LibC::Int
  fun blas_sgemm = gsl_blas_sgemm(trans_a : CblasTransposeT, trans_b : CblasTransposeT, alpha : LibC::Float, a : MatrixFloat*, b : MatrixFloat*, beta : LibC::Float, c : MatrixFloat*) : LibC::Int
  fun blas_ssymm = gsl_blas_ssymm(side : CblasSideT, uplo : CblasUploT, alpha : LibC::Float, a : MatrixFloat*, b : MatrixFloat*, beta : LibC::Float, c : MatrixFloat*) : LibC::Int
  enum CblasSideT
    CblasLeft  = 141
    CblasRight = 142
  end
  fun blas_ssyrk = gsl_blas_ssyrk(uplo : CblasUploT, trans : CblasTransposeT, alpha : LibC::Float, a : MatrixFloat*, beta : LibC::Float, c : MatrixFloat*) : LibC::Int
  fun blas_ssyr2k = gsl_blas_ssyr2k(uplo : CblasUploT, trans : CblasTransposeT, alpha : LibC::Float, a : MatrixFloat*, b : MatrixFloat*, beta : LibC::Float, c : MatrixFloat*) : LibC::Int
  fun blas_strmm = gsl_blas_strmm(side : CblasSideT, uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, alpha : LibC::Float, a : MatrixFloat*, b : MatrixFloat*) : LibC::Int
  fun blas_strsm = gsl_blas_strsm(side : CblasSideT, uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, alpha : LibC::Float, a : MatrixFloat*, b : MatrixFloat*) : LibC::Int
  fun blas_dgemm = gsl_blas_dgemm(trans_a : CblasTransposeT, trans_b : CblasTransposeT, alpha : LibC::Double, a : Matrix*, b : Matrix*, beta : LibC::Double, c : Matrix*) : LibC::Int
  fun blas_dsymm = gsl_blas_dsymm(side : CblasSideT, uplo : CblasUploT, alpha : LibC::Double, a : Matrix*, b : Matrix*, beta : LibC::Double, c : Matrix*) : LibC::Int
  fun blas_dsyrk = gsl_blas_dsyrk(uplo : CblasUploT, trans : CblasTransposeT, alpha : LibC::Double, a : Matrix*, beta : LibC::Double, c : Matrix*) : LibC::Int
  fun blas_dsyr2k = gsl_blas_dsyr2k(uplo : CblasUploT, trans : CblasTransposeT, alpha : LibC::Double, a : Matrix*, b : Matrix*, beta : LibC::Double, c : Matrix*) : LibC::Int
  fun blas_dtrmm = gsl_blas_dtrmm(side : CblasSideT, uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, alpha : LibC::Double, a : Matrix*, b : Matrix*) : LibC::Int
  fun blas_dtrsm = gsl_blas_dtrsm(side : CblasSideT, uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, alpha : LibC::Double, a : Matrix*, b : Matrix*) : LibC::Int
  fun blas_cgemm = gsl_blas_cgemm(trans_a : CblasTransposeT, trans_b : CblasTransposeT, alpha : ComplexFloat, a : MatrixComplexFloat*, b : MatrixComplexFloat*, beta : ComplexFloat, c : MatrixComplexFloat*) : LibC::Int
  fun blas_csymm = gsl_blas_csymm(side : CblasSideT, uplo : CblasUploT, alpha : ComplexFloat, a : MatrixComplexFloat*, b : MatrixComplexFloat*, beta : ComplexFloat, c : MatrixComplexFloat*) : LibC::Int
  fun blas_csyrk = gsl_blas_csyrk(uplo : CblasUploT, trans : CblasTransposeT, alpha : ComplexFloat, a : MatrixComplexFloat*, beta : ComplexFloat, c : MatrixComplexFloat*) : LibC::Int
  fun blas_csyr2k = gsl_blas_csyr2k(uplo : CblasUploT, trans : CblasTransposeT, alpha : ComplexFloat, a : MatrixComplexFloat*, b : MatrixComplexFloat*, beta : ComplexFloat, c : MatrixComplexFloat*) : LibC::Int
  fun blas_ctrmm = gsl_blas_ctrmm(side : CblasSideT, uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, alpha : ComplexFloat, a : MatrixComplexFloat*, b : MatrixComplexFloat*) : LibC::Int
  fun blas_ctrsm = gsl_blas_ctrsm(side : CblasSideT, uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, alpha : ComplexFloat, a : MatrixComplexFloat*, b : MatrixComplexFloat*) : LibC::Int
  fun blas_zgemm = gsl_blas_zgemm(trans_a : CblasTransposeT, trans_b : CblasTransposeT, alpha : Complex, a : MatrixComplex*, b : MatrixComplex*, beta : Complex, c : MatrixComplex*) : LibC::Int
  fun blas_zsymm = gsl_blas_zsymm(side : CblasSideT, uplo : CblasUploT, alpha : Complex, a : MatrixComplex*, b : MatrixComplex*, beta : Complex, c : MatrixComplex*) : LibC::Int
  fun blas_zsyrk = gsl_blas_zsyrk(uplo : CblasUploT, trans : CblasTransposeT, alpha : Complex, a : MatrixComplex*, beta : Complex, c : MatrixComplex*) : LibC::Int
  fun blas_zsyr2k = gsl_blas_zsyr2k(uplo : CblasUploT, trans : CblasTransposeT, alpha : Complex, a : MatrixComplex*, b : MatrixComplex*, beta : Complex, c : MatrixComplex*) : LibC::Int
  fun blas_ztrmm = gsl_blas_ztrmm(side : CblasSideT, uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, alpha : Complex, a : MatrixComplex*, b : MatrixComplex*) : LibC::Int
  fun blas_ztrsm = gsl_blas_ztrsm(side : CblasSideT, uplo : CblasUploT, trans_a : CblasTransposeT, diag : CblasDiagT, alpha : Complex, a : MatrixComplex*, b : MatrixComplex*) : LibC::Int
  fun blas_chemm = gsl_blas_chemm(side : CblasSideT, uplo : CblasUploT, alpha : ComplexFloat, a : MatrixComplexFloat*, b : MatrixComplexFloat*, beta : ComplexFloat, c : MatrixComplexFloat*) : LibC::Int
  fun blas_cherk = gsl_blas_cherk(uplo : CblasUploT, trans : CblasTransposeT, alpha : LibC::Float, a : MatrixComplexFloat*, beta : LibC::Float, c : MatrixComplexFloat*) : LibC::Int
  fun blas_cher2k = gsl_blas_cher2k(uplo : CblasUploT, trans : CblasTransposeT, alpha : ComplexFloat, a : MatrixComplexFloat*, b : MatrixComplexFloat*, beta : LibC::Float, c : MatrixComplexFloat*) : LibC::Int
  fun blas_zhemm = gsl_blas_zhemm(side : CblasSideT, uplo : CblasUploT, alpha : Complex, a : MatrixComplex*, b : MatrixComplex*, beta : Complex, c : MatrixComplex*) : LibC::Int
  fun blas_zherk = gsl_blas_zherk(uplo : CblasUploT, trans : CblasTransposeT, alpha : LibC::Double, a : MatrixComplex*, beta : LibC::Double, c : MatrixComplex*) : LibC::Int
  fun blas_zher2k = gsl_blas_zher2k(uplo : CblasUploT, trans : CblasTransposeT, alpha : Complex, a : MatrixComplex*, b : MatrixComplex*, beta : LibC::Double, c : MatrixComplex*) : LibC::Int
  fun log1p = gsl_log1p(x : LibC::Double) : LibC::Double
  fun expm1 = gsl_expm1(x : LibC::Double) : LibC::Double
  fun hypot = gsl_hypot(x : LibC::Double, y : LibC::Double) : LibC::Double
  fun hypot3 = gsl_hypot3(x : LibC::Double, y : LibC::Double, z : LibC::Double) : LibC::Double
  fun acosh = gsl_acosh(x : LibC::Double) : LibC::Double
  fun asinh = gsl_asinh(x : LibC::Double) : LibC::Double
  fun atanh = gsl_atanh(x : LibC::Double) : LibC::Double
  fun isnan = gsl_isnan(x : LibC::Double) : LibC::Int
  fun isinf = gsl_isinf(x : LibC::Double) : LibC::Int
  fun finite = gsl_finite(x : LibC::Double) : LibC::Int
  fun nan = gsl_nan : LibC::Double
  fun posinf = gsl_posinf : LibC::Double
  fun neginf = gsl_neginf : LibC::Double
  fun fdiv = gsl_fdiv(x : LibC::Double, y : LibC::Double) : LibC::Double
  fun coerce_double = gsl_coerce_double(x : LibC::Double) : LibC::Double
  fun coerce_float = gsl_coerce_float(x : LibC::Float) : LibC::Float
  # fun coerce_long_double = gsl_coerce_long_double(x : LibC::LongDouble) : LibC::LongDouble
  fun ldexp = gsl_ldexp(x : LibC::Double, e : LibC::Int) : LibC::Double
  fun frexp = gsl_frexp(x : LibC::Double, e : LibC::Int*) : LibC::Double
  fun fcmp = gsl_fcmp(x1 : LibC::Double, x2 : LibC::Double, epsilon : LibC::Double) : LibC::Int
  fun pow_2 = gsl_pow_2(x : LibC::Double) : LibC::Double
  fun pow_3 = gsl_pow_3(x : LibC::Double) : LibC::Double
  fun pow_4 = gsl_pow_4(x : LibC::Double) : LibC::Double
  fun pow_5 = gsl_pow_5(x : LibC::Double) : LibC::Double
  fun pow_6 = gsl_pow_6(x : LibC::Double) : LibC::Double
  fun pow_7 = gsl_pow_7(x : LibC::Double) : LibC::Double
  fun pow_8 = gsl_pow_8(x : LibC::Double) : LibC::Double
  fun pow_9 = gsl_pow_9(x : LibC::Double) : LibC::Double
  fun pow_int = gsl_pow_int(x : LibC::Double, n : LibC::Int) : LibC::Double
  fun pow_uint = gsl_pow_uint(x : LibC::Double, n : LibC::UInt) : LibC::Double
  fun max = gsl_max(a : LibC::Double, b : LibC::Double) : LibC::Double
  fun min = gsl_min(a : LibC::Double, b : LibC::Double) : LibC::Double

  struct FunctionStruct
    function : (LibC::Double, Void* -> LibC::Double)
    params : Void*
  end

  struct FunctionFdfStruct
    f : (LibC::Double, Void* -> LibC::Double)
    df : (LibC::Double, Void* -> LibC::Double)
    fdf : (LibC::Double, Void*, LibC::Double*, LibC::Double* -> Void)
    params : Void*
  end

  struct FunctionVecStruct
    function : (LibC::Double, LibC::Double*, Void* -> LibC::Int)
    params : Void*
  end

  fun bspline_alloc = gsl_bspline_alloc(k : LibC::SizeT, nbreak : LibC::SizeT) : BsplineWorkspace*

  struct BsplineWorkspace
    k : LibC::SizeT
    km1 : LibC::SizeT
    l : LibC::SizeT
    nbreak : LibC::SizeT
    n : LibC::SizeT
    knots : Vector*
    deltal : Vector*
    deltar : Vector*
    b : Vector*
    a : Matrix*
    d_b : Matrix*
  end

  fun bspline_free = gsl_bspline_free(w : BsplineWorkspace*)
  fun bspline_ncoeffs = gsl_bspline_ncoeffs(w : BsplineWorkspace*) : LibC::SizeT
  fun bspline_order = gsl_bspline_order(w : BsplineWorkspace*) : LibC::SizeT
  fun bspline_nbreak = gsl_bspline_nbreak(w : BsplineWorkspace*) : LibC::SizeT
  fun bspline_breakpoint = gsl_bspline_breakpoint(i : LibC::SizeT, w : BsplineWorkspace*) : LibC::Double
  fun bspline_greville_abscissa = gsl_bspline_greville_abscissa(i : LibC::SizeT, w : BsplineWorkspace*) : LibC::Double
  fun bspline_knots = gsl_bspline_knots(breakpts : Vector*, w : BsplineWorkspace*) : LibC::Int
  fun bspline_knots_uniform = gsl_bspline_knots_uniform(a : LibC::Double, b : LibC::Double, w : BsplineWorkspace*) : LibC::Int
  fun bspline_knots_greville = gsl_bspline_knots_greville(abscissae : Vector*, w : BsplineWorkspace*, abserr : LibC::Double*) : LibC::Int
  fun bspline_eval = gsl_bspline_eval(x : LibC::Double, b : Vector*, w : BsplineWorkspace*) : LibC::Int
  fun bspline_eval_nonzero = gsl_bspline_eval_nonzero(x : LibC::Double, bk : Vector*, istart : LibC::SizeT*, iend : LibC::SizeT*, w : BsplineWorkspace*) : LibC::Int
  fun bspline_deriv_eval = gsl_bspline_deriv_eval(x : LibC::Double, nderiv : LibC::SizeT, d_b : Matrix*, w : BsplineWorkspace*) : LibC::Int
  fun bspline_deriv_eval_nonzero = gsl_bspline_deriv_eval_nonzero(x : LibC::Double, nderiv : LibC::SizeT, d_b : Matrix*, istart : LibC::SizeT*, iend : LibC::SizeT*, w : BsplineWorkspace*) : LibC::Int
  fun cdf_ugaussian_p = gsl_cdf_ugaussian_P(x : LibC::Double) : LibC::Double
  fun cdf_ugaussian_q = gsl_cdf_ugaussian_Q(x : LibC::Double) : LibC::Double
  fun cdf_ugaussian_pinv = gsl_cdf_ugaussian_Pinv(p : LibC::Double) : LibC::Double
  fun cdf_ugaussian_qinv = gsl_cdf_ugaussian_Qinv(q : LibC::Double) : LibC::Double
  fun cdf_gaussian_p = gsl_cdf_gaussian_P(x : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_gaussian_q = gsl_cdf_gaussian_Q(x : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_gaussian_pinv = gsl_cdf_gaussian_Pinv(p : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_gaussian_qinv = gsl_cdf_gaussian_Qinv(q : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_gamma_p = gsl_cdf_gamma_P(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gamma_q = gsl_cdf_gamma_Q(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gamma_pinv = gsl_cdf_gamma_Pinv(p : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gamma_qinv = gsl_cdf_gamma_Qinv(q : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_cauchy_p = gsl_cdf_cauchy_P(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_cauchy_q = gsl_cdf_cauchy_Q(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_cauchy_pinv = gsl_cdf_cauchy_Pinv(p : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_cauchy_qinv = gsl_cdf_cauchy_Qinv(q : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_laplace_p = gsl_cdf_laplace_P(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_laplace_q = gsl_cdf_laplace_Q(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_laplace_pinv = gsl_cdf_laplace_Pinv(p : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_laplace_qinv = gsl_cdf_laplace_Qinv(q : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_rayleigh_p = gsl_cdf_rayleigh_P(x : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_rayleigh_q = gsl_cdf_rayleigh_Q(x : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_rayleigh_pinv = gsl_cdf_rayleigh_Pinv(p : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_rayleigh_qinv = gsl_cdf_rayleigh_Qinv(q : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_chisq_p = gsl_cdf_chisq_P(x : LibC::Double, nu : LibC::Double) : LibC::Double
  fun cdf_chisq_q = gsl_cdf_chisq_Q(x : LibC::Double, nu : LibC::Double) : LibC::Double
  fun cdf_chisq_pinv = gsl_cdf_chisq_Pinv(p : LibC::Double, nu : LibC::Double) : LibC::Double
  fun cdf_chisq_qinv = gsl_cdf_chisq_Qinv(q : LibC::Double, nu : LibC::Double) : LibC::Double
  fun cdf_exponential_p = gsl_cdf_exponential_P(x : LibC::Double, mu : LibC::Double) : LibC::Double
  fun cdf_exponential_q = gsl_cdf_exponential_Q(x : LibC::Double, mu : LibC::Double) : LibC::Double
  fun cdf_exponential_pinv = gsl_cdf_exponential_Pinv(p : LibC::Double, mu : LibC::Double) : LibC::Double
  fun cdf_exponential_qinv = gsl_cdf_exponential_Qinv(q : LibC::Double, mu : LibC::Double) : LibC::Double
  fun cdf_exppow_p = gsl_cdf_exppow_P(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_exppow_q = gsl_cdf_exppow_Q(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_tdist_p = gsl_cdf_tdist_P(x : LibC::Double, nu : LibC::Double) : LibC::Double
  fun cdf_tdist_q = gsl_cdf_tdist_Q(x : LibC::Double, nu : LibC::Double) : LibC::Double
  fun cdf_tdist_pinv = gsl_cdf_tdist_Pinv(p : LibC::Double, nu : LibC::Double) : LibC::Double
  fun cdf_tdist_qinv = gsl_cdf_tdist_Qinv(q : LibC::Double, nu : LibC::Double) : LibC::Double
  fun cdf_fdist_p = gsl_cdf_fdist_P(x : LibC::Double, nu1 : LibC::Double, nu2 : LibC::Double) : LibC::Double
  fun cdf_fdist_q = gsl_cdf_fdist_Q(x : LibC::Double, nu1 : LibC::Double, nu2 : LibC::Double) : LibC::Double
  fun cdf_fdist_pinv = gsl_cdf_fdist_Pinv(p : LibC::Double, nu1 : LibC::Double, nu2 : LibC::Double) : LibC::Double
  fun cdf_fdist_qinv = gsl_cdf_fdist_Qinv(q : LibC::Double, nu1 : LibC::Double, nu2 : LibC::Double) : LibC::Double
  fun cdf_beta_p = gsl_cdf_beta_P(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_beta_q = gsl_cdf_beta_Q(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_beta_pinv = gsl_cdf_beta_Pinv(p : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_beta_qinv = gsl_cdf_beta_Qinv(q : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_flat_p = gsl_cdf_flat_P(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_flat_q = gsl_cdf_flat_Q(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_flat_pinv = gsl_cdf_flat_Pinv(p : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_flat_qinv = gsl_cdf_flat_Qinv(q : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_lognormal_p = gsl_cdf_lognormal_P(x : LibC::Double, zeta : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_lognormal_q = gsl_cdf_lognormal_Q(x : LibC::Double, zeta : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_lognormal_pinv = gsl_cdf_lognormal_Pinv(p : LibC::Double, zeta : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_lognormal_qinv = gsl_cdf_lognormal_Qinv(q : LibC::Double, zeta : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun cdf_gumbel1_p = gsl_cdf_gumbel1_P(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gumbel1_q = gsl_cdf_gumbel1_Q(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gumbel1_pinv = gsl_cdf_gumbel1_Pinv(p : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gumbel1_qinv = gsl_cdf_gumbel1_Qinv(q : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gumbel2_p = gsl_cdf_gumbel2_P(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gumbel2_q = gsl_cdf_gumbel2_Q(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gumbel2_pinv = gsl_cdf_gumbel2_Pinv(p : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_gumbel2_qinv = gsl_cdf_gumbel2_Qinv(q : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_weibull_p = gsl_cdf_weibull_P(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_weibull_q = gsl_cdf_weibull_Q(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_weibull_pinv = gsl_cdf_weibull_Pinv(p : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_weibull_qinv = gsl_cdf_weibull_Qinv(q : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_pareto_p = gsl_cdf_pareto_P(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_pareto_q = gsl_cdf_pareto_Q(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_pareto_pinv = gsl_cdf_pareto_Pinv(p : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_pareto_qinv = gsl_cdf_pareto_Qinv(q : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun cdf_logistic_p = gsl_cdf_logistic_P(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_logistic_q = gsl_cdf_logistic_Q(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_logistic_pinv = gsl_cdf_logistic_Pinv(p : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_logistic_qinv = gsl_cdf_logistic_Qinv(q : LibC::Double, a : LibC::Double) : LibC::Double
  fun cdf_binomial_p = gsl_cdf_binomial_P(k : LibC::UInt, p : LibC::Double, n : LibC::UInt) : LibC::Double
  fun cdf_binomial_q = gsl_cdf_binomial_Q(k : LibC::UInt, p : LibC::Double, n : LibC::UInt) : LibC::Double
  fun cdf_poisson_p = gsl_cdf_poisson_P(k : LibC::UInt, mu : LibC::Double) : LibC::Double
  fun cdf_poisson_q = gsl_cdf_poisson_Q(k : LibC::UInt, mu : LibC::Double) : LibC::Double
  fun cdf_geometric_p = gsl_cdf_geometric_P(k : LibC::UInt, p : LibC::Double) : LibC::Double
  fun cdf_geometric_q = gsl_cdf_geometric_Q(k : LibC::UInt, p : LibC::Double) : LibC::Double
  fun cdf_negative_binomial_p = gsl_cdf_negative_binomial_P(k : LibC::UInt, p : LibC::Double, n : LibC::Double) : LibC::Double
  fun cdf_negative_binomial_q = gsl_cdf_negative_binomial_Q(k : LibC::UInt, p : LibC::Double, n : LibC::Double) : LibC::Double
  fun cdf_pascal_p = gsl_cdf_pascal_P(k : LibC::UInt, p : LibC::Double, n : LibC::UInt) : LibC::Double
  fun cdf_pascal_q = gsl_cdf_pascal_Q(k : LibC::UInt, p : LibC::Double, n : LibC::UInt) : LibC::Double
  fun cdf_hypergeometric_p = gsl_cdf_hypergeometric_P(k : LibC::UInt, n1 : LibC::UInt, n2 : LibC::UInt, t : LibC::UInt) : LibC::Double
  fun cdf_hypergeometric_q = gsl_cdf_hypergeometric_Q(k : LibC::UInt, n1 : LibC::UInt, n2 : LibC::UInt, t : LibC::UInt) : LibC::Double

  struct ChebSeriesStruct
    c : LibC::Double*
    order : LibC::SizeT
    a : LibC::Double
    b : LibC::Double
    order_sp : LibC::SizeT
    f : LibC::Double*
  end

  fun cheb_alloc = gsl_cheb_alloc(order : LibC::SizeT) : ChebSeries*
  type ChebSeries = ChebSeriesStruct
  fun cheb_free = gsl_cheb_free(cs : ChebSeries*)
  fun cheb_init = gsl_cheb_init(cs : ChebSeries*, func : Function*, a : LibC::Double, b : LibC::Double) : LibC::Int
  type Function = FunctionStruct
  fun cheb_order = gsl_cheb_order(cs : ChebSeries*) : LibC::SizeT
  fun cheb_size = gsl_cheb_size(cs : ChebSeries*) : LibC::SizeT
  fun cheb_coeffs = gsl_cheb_coeffs(cs : ChebSeries*) : LibC::Double*
  fun cheb_eval = gsl_cheb_eval(cs : ChebSeries*, x : LibC::Double) : LibC::Double
  fun cheb_eval_err = gsl_cheb_eval_err(cs : ChebSeries*, x : LibC::Double, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun cheb_eval_n = gsl_cheb_eval_n(cs : ChebSeries*, order : LibC::SizeT, x : LibC::Double) : LibC::Double
  fun cheb_eval_n_err = gsl_cheb_eval_n_err(cs : ChebSeries*, order : LibC::SizeT, x : LibC::Double, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun cheb_eval_mode = gsl_cheb_eval_mode(cs : ChebSeries*, x : LibC::Double, mode : ModeT) : LibC::Double
  alias ModeT = LibC::UInt
  fun cheb_eval_mode_e = gsl_cheb_eval_mode_e(cs : ChebSeries*, x : LibC::Double, mode : ModeT, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun cheb_calc_deriv = gsl_cheb_calc_deriv(deriv : ChebSeries*, cs : ChebSeries*) : LibC::Int
  fun cheb_calc_integ = gsl_cheb_calc_integ(integ : ChebSeries*, cs : ChebSeries*) : LibC::Int

  struct CombinationStruct
    n : LibC::SizeT
    k : LibC::SizeT
    data : LibC::SizeT*
  end

  fun combination_alloc = gsl_combination_alloc(n : LibC::SizeT, k : LibC::SizeT) : Combination*
  type Combination = CombinationStruct
  fun combination_calloc = gsl_combination_calloc(n : LibC::SizeT, k : LibC::SizeT) : Combination*
  fun combination_init_first = gsl_combination_init_first(c : Combination*)
  fun combination_init_last = gsl_combination_init_last(c : Combination*)
  fun combination_free = gsl_combination_free(c : Combination*)
  fun combination_memcpy = gsl_combination_memcpy(dest : Combination*, src : Combination*) : LibC::Int
  fun combination_fread = gsl_combination_fread(stream : File*, c : Combination*) : LibC::Int
  fun combination_fwrite = gsl_combination_fwrite(stream : File*, c : Combination*) : LibC::Int
  fun combination_fscanf = gsl_combination_fscanf(stream : File*, c : Combination*) : LibC::Int
  fun combination_fprintf = gsl_combination_fprintf(stream : File*, c : Combination*, format : LibC::Char*) : LibC::Int
  fun combination_n = gsl_combination_n(c : Combination*) : LibC::SizeT
  fun combination_k = gsl_combination_k(c : Combination*) : LibC::SizeT
  fun combination_data = gsl_combination_data(c : Combination*) : LibC::SizeT*
  fun combination_valid = gsl_combination_valid(c : Combination*) : LibC::Int
  fun combination_next = gsl_combination_next(c : Combination*) : LibC::Int
  fun combination_prev = gsl_combination_prev(c : Combination*) : LibC::Int
  fun combination_get = gsl_combination_get(c : Combination*, i : LibC::SizeT) : LibC::SizeT
  fun complex_polar = gsl_complex_polar(r : LibC::Double, theta : LibC::Double) : Complex
  fun complex_rect = gsl_complex_rect(x : LibC::Double, y : LibC::Double) : Complex
  fun complex_arg = gsl_complex_arg(z : Complex) : LibC::Double
  fun complex_abs = gsl_complex_abs(z : Complex) : LibC::Double
  fun complex_abs2 = gsl_complex_abs2(z : Complex) : LibC::Double
  fun complex_logabs = gsl_complex_logabs(z : Complex) : LibC::Double
  fun complex_add = gsl_complex_add(a : Complex, b : Complex) : Complex
  fun complex_sub = gsl_complex_sub(a : Complex, b : Complex) : Complex
  fun complex_mul = gsl_complex_mul(a : Complex, b : Complex) : Complex
  fun complex_div = gsl_complex_div(a : Complex, b : Complex) : Complex
  fun complex_add_real = gsl_complex_add_real(a : Complex, x : LibC::Double) : Complex
  fun complex_sub_real = gsl_complex_sub_real(a : Complex, x : LibC::Double) : Complex
  fun complex_mul_real = gsl_complex_mul_real(a : Complex, x : LibC::Double) : Complex
  fun complex_div_real = gsl_complex_div_real(a : Complex, x : LibC::Double) : Complex
  fun complex_add_imag = gsl_complex_add_imag(a : Complex, y : LibC::Double) : Complex
  fun complex_sub_imag = gsl_complex_sub_imag(a : Complex, y : LibC::Double) : Complex
  fun complex_mul_imag = gsl_complex_mul_imag(a : Complex, y : LibC::Double) : Complex
  fun complex_div_imag = gsl_complex_div_imag(a : Complex, y : LibC::Double) : Complex
  fun complex_conjugate = gsl_complex_conjugate(z : Complex) : Complex
  fun complex_inverse = gsl_complex_inverse(a : Complex) : Complex
  fun complex_negative = gsl_complex_negative(a : Complex) : Complex
  fun complex_sqrt = gsl_complex_sqrt(z : Complex) : Complex
  fun complex_sqrt_real = gsl_complex_sqrt_real(x : LibC::Double) : Complex
  fun complex_pow = gsl_complex_pow(a : Complex, b : Complex) : Complex
  fun complex_pow_real = gsl_complex_pow_real(a : Complex, b : LibC::Double) : Complex
  fun complex_exp = gsl_complex_exp(a : Complex) : Complex
  fun complex_log = gsl_complex_log(a : Complex) : Complex
  fun complex_log10 = gsl_complex_log10(a : Complex) : Complex
  fun complex_log_b = gsl_complex_log_b(a : Complex, b : Complex) : Complex
  fun complex_sin = gsl_complex_sin(a : Complex) : Complex
  fun complex_cos = gsl_complex_cos(a : Complex) : Complex
  fun complex_sec = gsl_complex_sec(a : Complex) : Complex
  fun complex_csc = gsl_complex_csc(a : Complex) : Complex
  fun complex_tan = gsl_complex_tan(a : Complex) : Complex
  fun complex_cot = gsl_complex_cot(a : Complex) : Complex
  fun complex_arcsin = gsl_complex_arcsin(a : Complex) : Complex
  fun complex_arcsin_real = gsl_complex_arcsin_real(a : LibC::Double) : Complex
  fun complex_arccos = gsl_complex_arccos(a : Complex) : Complex
  fun complex_arccos_real = gsl_complex_arccos_real(a : LibC::Double) : Complex
  fun complex_arcsec = gsl_complex_arcsec(a : Complex) : Complex
  fun complex_arcsec_real = gsl_complex_arcsec_real(a : LibC::Double) : Complex
  fun complex_arccsc = gsl_complex_arccsc(a : Complex) : Complex
  fun complex_arccsc_real = gsl_complex_arccsc_real(a : LibC::Double) : Complex
  fun complex_arctan = gsl_complex_arctan(a : Complex) : Complex
  fun complex_arccot = gsl_complex_arccot(a : Complex) : Complex
  fun complex_sinh = gsl_complex_sinh(a : Complex) : Complex
  fun complex_cosh = gsl_complex_cosh(a : Complex) : Complex
  fun complex_sech = gsl_complex_sech(a : Complex) : Complex
  fun complex_csch = gsl_complex_csch(a : Complex) : Complex
  fun complex_tanh = gsl_complex_tanh(a : Complex) : Complex
  fun complex_coth = gsl_complex_coth(a : Complex) : Complex
  fun complex_arcsinh = gsl_complex_arcsinh(a : Complex) : Complex
  fun complex_arccosh = gsl_complex_arccosh(a : Complex) : Complex
  fun complex_arccosh_real = gsl_complex_arccosh_real(a : LibC::Double) : Complex
  fun complex_arcsech = gsl_complex_arcsech(a : Complex) : Complex
  fun complex_arccsch = gsl_complex_arccsch(a : Complex) : Complex
  fun complex_arctanh = gsl_complex_arctanh(a : Complex) : Complex
  fun complex_arctanh_real = gsl_complex_arctanh_real(a : LibC::Double) : Complex
  fun complex_arccoth = gsl_complex_arccoth(a : Complex) : Complex
  fun deriv_central = gsl_deriv_central(f : Function*, x : LibC::Double, h : LibC::Double, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun deriv_backward = gsl_deriv_backward(f : Function*, x : LibC::Double, h : LibC::Double, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun deriv_forward = gsl_deriv_forward(f : Function*, x : LibC::Double, h : LibC::Double, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  FftForward  = -1
  FftBackward =  1
  fun dft_complex_float_forward = gsl_dft_complex_float_forward(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, result : LibC::Float*) : LibC::Int
  fun dft_complex_float_backward = gsl_dft_complex_float_backward(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, result : LibC::Float*) : LibC::Int
  fun dft_complex_float_inverse = gsl_dft_complex_float_inverse(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, result : LibC::Float*) : LibC::Int
  fun dft_complex_float_transform = gsl_dft_complex_float_transform(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, result : LibC::Float*, sign : FftDirection) : LibC::Int
  enum FftDirection
    FftForward  = -1
    FftBackward =  1
  end
  fun dft_complex_forward = gsl_dft_complex_forward(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, result : LibC::Double*) : LibC::Int
  fun dft_complex_backward = gsl_dft_complex_backward(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, result : LibC::Double*) : LibC::Int
  fun dft_complex_inverse = gsl_dft_complex_inverse(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, result : LibC::Double*) : LibC::Int
  fun dft_complex_transform = gsl_dft_complex_transform(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, result : LibC::Double*, sign : FftDirection) : LibC::Int

  struct DhtStruct
    size : LibC::SizeT
    nu : LibC::Double
    xmax : LibC::Double
    kmax : LibC::Double
    j : LibC::Double*
    jjj : LibC::Double*
    j2 : LibC::Double*
  end

  fun dht_alloc = gsl_dht_alloc(size : LibC::SizeT) : Dht*
  type Dht = DhtStruct
  fun dht_new = gsl_dht_new(size : LibC::SizeT, nu : LibC::Double, xmax : LibC::Double) : Dht*
  fun dht_init = gsl_dht_init(t : Dht*, nu : LibC::Double, xmax : LibC::Double) : LibC::Int
  fun dht_x_sample = gsl_dht_x_sample(t : Dht*, n : LibC::Int) : LibC::Double
  fun dht_k_sample = gsl_dht_k_sample(t : Dht*, n : LibC::Int) : LibC::Double
  fun dht_free = gsl_dht_free(t : Dht*)
  fun dht_apply = gsl_dht_apply(t : Dht*, f_in : LibC::Double*, f_out : LibC::Double*) : LibC::Int
  fun diff_central = gsl_diff_central(f : Function*, x : LibC::Double, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun diff_backward = gsl_diff_backward(f : Function*, x : LibC::Double, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun diff_forward = gsl_diff_forward(f : Function*, x : LibC::Double, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun eigen_symm_alloc = gsl_eigen_symm_alloc(n : LibC::SizeT) : EigenSymmWorkspace*

  struct EigenSymmWorkspace
    size : LibC::SizeT
    d : LibC::Double*
    sd : LibC::Double*
  end

  fun eigen_symm_free = gsl_eigen_symm_free(w : EigenSymmWorkspace*)
  fun eigen_symm = gsl_eigen_symm(a : Matrix*, eval : Vector*, w : EigenSymmWorkspace*) : LibC::Int
  fun eigen_symmv_alloc = gsl_eigen_symmv_alloc(n : LibC::SizeT) : EigenSymmvWorkspace*

  struct EigenSymmvWorkspace
    size : LibC::SizeT
    d : LibC::Double*
    sd : LibC::Double*
    gc : LibC::Double*
    gs : LibC::Double*
  end

  fun eigen_symmv_free = gsl_eigen_symmv_free(w : EigenSymmvWorkspace*)
  fun eigen_symmv = gsl_eigen_symmv(a : Matrix*, eval : Vector*, evec : Matrix*, w : EigenSymmvWorkspace*) : LibC::Int
  fun eigen_herm_alloc = gsl_eigen_herm_alloc(n : LibC::SizeT) : EigenHermWorkspace*

  struct EigenHermWorkspace
    size : LibC::SizeT
    d : LibC::Double*
    sd : LibC::Double*
    tau : LibC::Double*
  end

  fun eigen_herm_free = gsl_eigen_herm_free(w : EigenHermWorkspace*)
  fun eigen_herm = gsl_eigen_herm(a : MatrixComplex*, eval : Vector*, w : EigenHermWorkspace*) : LibC::Int
  fun eigen_hermv_alloc = gsl_eigen_hermv_alloc(n : LibC::SizeT) : EigenHermvWorkspace*

  struct EigenHermvWorkspace
    size : LibC::SizeT
    d : LibC::Double*
    sd : LibC::Double*
    tau : LibC::Double*
    gc : LibC::Double*
    gs : LibC::Double*
  end

  fun eigen_hermv_free = gsl_eigen_hermv_free(w : EigenHermvWorkspace*)
  fun eigen_hermv = gsl_eigen_hermv(a : MatrixComplex*, eval : Vector*, evec : MatrixComplex*, w : EigenHermvWorkspace*) : LibC::Int
  fun eigen_francis_alloc = gsl_eigen_francis_alloc : EigenFrancisWorkspace*

  struct EigenFrancisWorkspace
    size : LibC::SizeT
    max_iterations : LibC::SizeT
    n_iter : LibC::SizeT
    n_evals : LibC::SizeT
    compute_t : LibC::Int
    h : Matrix*
    z : Matrix*
  end

  fun eigen_francis_free = gsl_eigen_francis_free(w : EigenFrancisWorkspace*)
  fun eigen_francis_t = gsl_eigen_francis_T(compute_t : LibC::Int, w : EigenFrancisWorkspace*)
  fun eigen_francis = gsl_eigen_francis(h : Matrix*, eval : VectorComplex*, w : EigenFrancisWorkspace*) : LibC::Int
  fun eigen_francis_z = gsl_eigen_francis_Z(h : Matrix*, eval : VectorComplex*, z : Matrix*, w : EigenFrancisWorkspace*) : LibC::Int
  fun eigen_nonsymm_alloc = gsl_eigen_nonsymm_alloc(n : LibC::SizeT) : EigenNonsymmWorkspace*

  struct EigenNonsymmWorkspace
    size : LibC::SizeT
    diag : Vector*
    tau : Vector*
    z : Matrix*
    do_balance : LibC::Int
    n_evals : LibC::SizeT
    francis_workspace_p : EigenFrancisWorkspace*
  end

  fun eigen_nonsymm_free = gsl_eigen_nonsymm_free(w : EigenNonsymmWorkspace*)
  fun eigen_nonsymm_params = gsl_eigen_nonsymm_params(compute_t : LibC::Int, balance : LibC::Int, w : EigenNonsymmWorkspace*)
  fun eigen_nonsymm = gsl_eigen_nonsymm(a : Matrix*, eval : VectorComplex*, w : EigenNonsymmWorkspace*) : LibC::Int
  fun eigen_nonsymm_z = gsl_eigen_nonsymm_Z(a : Matrix*, eval : VectorComplex*, z : Matrix*, w : EigenNonsymmWorkspace*) : LibC::Int
  fun eigen_nonsymmv_alloc = gsl_eigen_nonsymmv_alloc(n : LibC::SizeT) : EigenNonsymmvWorkspace*

  struct EigenNonsymmvWorkspace
    size : LibC::SizeT
    work : Vector*
    work2 : Vector*
    work3 : Vector*
    z : Matrix*
    nonsymm_workspace_p : EigenNonsymmWorkspace*
  end

  fun eigen_nonsymmv_free = gsl_eigen_nonsymmv_free(w : EigenNonsymmvWorkspace*)
  fun eigen_nonsymmv_params = gsl_eigen_nonsymmv_params(balance : LibC::Int, w : EigenNonsymmvWorkspace*)
  fun eigen_nonsymmv = gsl_eigen_nonsymmv(a : Matrix*, eval : VectorComplex*, evec : MatrixComplex*, w : EigenNonsymmvWorkspace*) : LibC::Int
  fun eigen_nonsymmv_z = gsl_eigen_nonsymmv_Z(a : Matrix*, eval : VectorComplex*, evec : MatrixComplex*, z : Matrix*, w : EigenNonsymmvWorkspace*) : LibC::Int
  fun eigen_gensymm_alloc = gsl_eigen_gensymm_alloc(n : LibC::SizeT) : EigenGensymmWorkspace*

  struct EigenGensymmWorkspace
    size : LibC::SizeT
    symm_workspace_p : EigenSymmWorkspace*
  end

  fun eigen_gensymm_free = gsl_eigen_gensymm_free(w : EigenGensymmWorkspace*)
  fun eigen_gensymm = gsl_eigen_gensymm(a : Matrix*, b : Matrix*, eval : Vector*, w : EigenGensymmWorkspace*) : LibC::Int
  fun eigen_gensymm_standardize = gsl_eigen_gensymm_standardize(a : Matrix*, b : Matrix*) : LibC::Int
  fun eigen_gensymmv_alloc = gsl_eigen_gensymmv_alloc(n : LibC::SizeT) : EigenGensymmvWorkspace*

  struct EigenGensymmvWorkspace
    size : LibC::SizeT
    symmv_workspace_p : EigenSymmvWorkspace*
  end

  fun eigen_gensymmv_free = gsl_eigen_gensymmv_free(w : EigenGensymmvWorkspace*)
  fun eigen_gensymmv = gsl_eigen_gensymmv(a : Matrix*, b : Matrix*, eval : Vector*, evec : Matrix*, w : EigenGensymmvWorkspace*) : LibC::Int
  fun eigen_genherm_alloc = gsl_eigen_genherm_alloc(n : LibC::SizeT) : EigenGenhermWorkspace*

  struct EigenGenhermWorkspace
    size : LibC::SizeT
    herm_workspace_p : EigenHermWorkspace*
  end

  fun eigen_genherm_free = gsl_eigen_genherm_free(w : EigenGenhermWorkspace*)
  fun eigen_genherm = gsl_eigen_genherm(a : MatrixComplex*, b : MatrixComplex*, eval : Vector*, w : EigenGenhermWorkspace*) : LibC::Int
  fun eigen_genherm_standardize = gsl_eigen_genherm_standardize(a : MatrixComplex*, b : MatrixComplex*) : LibC::Int
  fun eigen_genhermv_alloc = gsl_eigen_genhermv_alloc(n : LibC::SizeT) : EigenGenhermvWorkspace*

  struct EigenGenhermvWorkspace
    size : LibC::SizeT
    hermv_workspace_p : EigenHermvWorkspace*
  end

  fun eigen_genhermv_free = gsl_eigen_genhermv_free(w : EigenGenhermvWorkspace*)
  fun eigen_genhermv = gsl_eigen_genhermv(a : MatrixComplex*, b : MatrixComplex*, eval : Vector*, evec : MatrixComplex*, w : EigenGenhermvWorkspace*) : LibC::Int
  fun eigen_gen_alloc = gsl_eigen_gen_alloc(n : LibC::SizeT) : EigenGenWorkspace*

  struct EigenGenWorkspace
    size : LibC::SizeT
    work : Vector*
    n_evals : LibC::SizeT
    max_iterations : LibC::SizeT
    n_iter : LibC::SizeT
    eshift : LibC::Double
    needtop : LibC::Int
    atol : LibC::Double
    btol : LibC::Double
    ascale : LibC::Double
    bscale : LibC::Double
    h : Matrix*
    r : Matrix*
    compute_s : LibC::Int
    compute_t : LibC::Int
    q : Matrix*
    z : Matrix*
  end

  fun eigen_gen_free = gsl_eigen_gen_free(w : EigenGenWorkspace*)
  fun eigen_gen_params = gsl_eigen_gen_params(compute_s : LibC::Int, compute_t : LibC::Int, balance : LibC::Int, w : EigenGenWorkspace*)
  fun eigen_gen = gsl_eigen_gen(a : Matrix*, b : Matrix*, alpha : VectorComplex*, beta : Vector*, w : EigenGenWorkspace*) : LibC::Int
  fun eigen_gen_qz = gsl_eigen_gen_QZ(a : Matrix*, b : Matrix*, alpha : VectorComplex*, beta : Vector*, q : Matrix*, z : Matrix*, w : EigenGenWorkspace*) : LibC::Int
  fun eigen_genv_alloc = gsl_eigen_genv_alloc(n : LibC::SizeT) : EigenGenvWorkspace*

  struct EigenGenvWorkspace
    size : LibC::SizeT
    work1 : Vector*
    work2 : Vector*
    work3 : Vector*
    work4 : Vector*
    work5 : Vector*
    work6 : Vector*
    q : Matrix*
    z : Matrix*
    gen_workspace_p : EigenGenWorkspace*
  end

  fun eigen_genv_free = gsl_eigen_genv_free(w : EigenGenvWorkspace*)
  fun eigen_genv = gsl_eigen_genv(a : Matrix*, b : Matrix*, alpha : VectorComplex*, beta : Vector*, evec : MatrixComplex*, w : EigenGenvWorkspace*) : LibC::Int
  fun eigen_genv_qz = gsl_eigen_genv_QZ(a : Matrix*, b : Matrix*, alpha : VectorComplex*, beta : Vector*, evec : MatrixComplex*, q : Matrix*, z : Matrix*, w : EigenGenvWorkspace*) : LibC::Int
  fun eigen_symmv_sort = gsl_eigen_symmv_sort(eval : Vector*, evec : Matrix*, sort_type : EigenSortT) : LibC::Int
  enum EigenSortT
    GslEigenSortValAsc  = 0
    GslEigenSortValDesc = 1
    GslEigenSortAbsAsc  = 2
    GslEigenSortAbsDesc = 3
  end
  fun eigen_hermv_sort = gsl_eigen_hermv_sort(eval : Vector*, evec : MatrixComplex*, sort_type : EigenSortT) : LibC::Int
  fun eigen_nonsymmv_sort = gsl_eigen_nonsymmv_sort(eval : VectorComplex*, evec : MatrixComplex*, sort_type : EigenSortT) : LibC::Int
  fun eigen_gensymmv_sort = gsl_eigen_gensymmv_sort(eval : Vector*, evec : Matrix*, sort_type : EigenSortT) : LibC::Int
  fun eigen_genhermv_sort = gsl_eigen_genhermv_sort(eval : Vector*, evec : MatrixComplex*, sort_type : EigenSortT) : LibC::Int
  fun eigen_genv_sort = gsl_eigen_genv_sort(alpha : VectorComplex*, beta : Vector*, evec : MatrixComplex*, sort_type : EigenSortT) : LibC::Int
  fun schur_gen_eigvals = gsl_schur_gen_eigvals(a : Matrix*, b : Matrix*, wr1 : LibC::Double*, wr2 : LibC::Double*, wi : LibC::Double*, scale1 : LibC::Double*, scale2 : LibC::Double*) : LibC::Int
  fun schur_solve_equation = gsl_schur_solve_equation(ca : LibC::Double, a : Matrix*, z : LibC::Double, d1 : LibC::Double, d2 : LibC::Double, b : Vector*, x : Vector*, s : LibC::Double*, xnorm : LibC::Double*, smin : LibC::Double) : LibC::Int
  fun schur_solve_equation_z = gsl_schur_solve_equation_z(ca : LibC::Double, a : Matrix*, z : Complex*, d1 : LibC::Double, d2 : LibC::Double, b : VectorComplex*, x : VectorComplex*, s : LibC::Double*, xnorm : LibC::Double*, smin : LibC::Double) : LibC::Int
  fun eigen_jacobi = gsl_eigen_jacobi(matrix : Matrix*, eval : Vector*, evec : Matrix*, max_rot : LibC::UInt, nrot : LibC::UInt*) : LibC::Int
  fun eigen_invert_jacobi = gsl_eigen_invert_jacobi(matrix : Matrix*, ainv : Matrix*, max_rot : LibC::UInt) : LibC::Int
  fun fft_complex_float_radix2_forward = gsl_fft_complex_float_radix2_forward(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  alias ComplexPackedArrayFloat = LibC::Float*
  fun fft_complex_float_radix2_backward = gsl_fft_complex_float_radix2_backward(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_float_radix2_inverse = gsl_fft_complex_float_radix2_inverse(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_float_radix2_transform = gsl_fft_complex_float_radix2_transform(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT, sign : FftDirection) : LibC::Int
  fun fft_complex_float_radix2_dif_forward = gsl_fft_complex_float_radix2_dif_forward(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_float_radix2_dif_backward = gsl_fft_complex_float_radix2_dif_backward(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_float_radix2_dif_inverse = gsl_fft_complex_float_radix2_dif_inverse(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_float_radix2_dif_transform = gsl_fft_complex_float_radix2_dif_transform(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT, sign : FftDirection) : LibC::Int
  fun fft_complex_wavetable_float_alloc = gsl_fft_complex_wavetable_float_alloc(n : LibC::SizeT) : FftComplexWavetableFloat*

  struct FftComplexWavetableFloat
    n : LibC::SizeT
    nf : LibC::SizeT
    factor : LibC::SizeT[64]
    twiddle : ComplexFloat*[64]
    trig : ComplexFloat*
  end

  fun fft_complex_wavetable_float_free = gsl_fft_complex_wavetable_float_free(wavetable : FftComplexWavetableFloat*)
  fun fft_complex_workspace_float_alloc = gsl_fft_complex_workspace_float_alloc(n : LibC::SizeT) : FftComplexWorkspaceFloat*

  struct FftComplexWorkspaceFloat
    n : LibC::SizeT
    scratch : LibC::Float*
  end

  fun fft_complex_workspace_float_free = gsl_fft_complex_workspace_float_free(workspace : FftComplexWorkspaceFloat*)
  fun fft_complex_float_memcpy = gsl_fft_complex_float_memcpy(dest : FftComplexWavetableFloat*, src : FftComplexWavetableFloat*) : LibC::Int
  fun fft_complex_float_forward = gsl_fft_complex_float_forward(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftComplexWavetableFloat*, work : FftComplexWorkspaceFloat*) : LibC::Int
  fun fft_complex_float_backward = gsl_fft_complex_float_backward(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftComplexWavetableFloat*, work : FftComplexWorkspaceFloat*) : LibC::Int
  fun fft_complex_float_inverse = gsl_fft_complex_float_inverse(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftComplexWavetableFloat*, work : FftComplexWorkspaceFloat*) : LibC::Int
  fun fft_complex_float_transform = gsl_fft_complex_float_transform(data : ComplexPackedArrayFloat, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftComplexWavetableFloat*, work : FftComplexWorkspaceFloat*, sign : FftDirection) : LibC::Int
  fun fft_complex_radix2_forward = gsl_fft_complex_radix2_forward(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  alias ComplexPackedArray = LibC::Double*
  fun fft_complex_radix2_backward = gsl_fft_complex_radix2_backward(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_radix2_inverse = gsl_fft_complex_radix2_inverse(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_radix2_transform = gsl_fft_complex_radix2_transform(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT, sign : FftDirection) : LibC::Int
  fun fft_complex_radix2_dif_forward = gsl_fft_complex_radix2_dif_forward(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_radix2_dif_backward = gsl_fft_complex_radix2_dif_backward(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_radix2_dif_inverse = gsl_fft_complex_radix2_dif_inverse(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_complex_radix2_dif_transform = gsl_fft_complex_radix2_dif_transform(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT, sign : FftDirection) : LibC::Int
  fun fft_complex_wavetable_alloc = gsl_fft_complex_wavetable_alloc(n : LibC::SizeT) : FftComplexWavetable*

  struct FftComplexWavetable
    n : LibC::SizeT
    nf : LibC::SizeT
    factor : LibC::SizeT[64]
    twiddle : Complex*[64]
    trig : Complex*
  end

  fun fft_complex_wavetable_free = gsl_fft_complex_wavetable_free(wavetable : FftComplexWavetable*)
  fun fft_complex_workspace_alloc = gsl_fft_complex_workspace_alloc(n : LibC::SizeT) : FftComplexWorkspace*

  struct FftComplexWorkspace
    n : LibC::SizeT
    scratch : LibC::Double*
  end

  fun fft_complex_workspace_free = gsl_fft_complex_workspace_free(workspace : FftComplexWorkspace*)
  fun fft_complex_memcpy = gsl_fft_complex_memcpy(dest : FftComplexWavetable*, src : FftComplexWavetable*) : LibC::Int
  fun fft_complex_forward = gsl_fft_complex_forward(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftComplexWavetable*, work : FftComplexWorkspace*) : LibC::Int
  fun fft_complex_backward = gsl_fft_complex_backward(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftComplexWavetable*, work : FftComplexWorkspace*) : LibC::Int
  fun fft_complex_inverse = gsl_fft_complex_inverse(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftComplexWavetable*, work : FftComplexWorkspace*) : LibC::Int
  fun fft_complex_transform = gsl_fft_complex_transform(data : ComplexPackedArray, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftComplexWavetable*, work : FftComplexWorkspace*, sign : FftDirection) : LibC::Int
  fun fft_real_float_radix2_transform = gsl_fft_real_float_radix2_transform(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_real_wavetable_float_alloc = gsl_fft_real_wavetable_float_alloc(n : LibC::SizeT) : FftRealWavetableFloat*

  struct FftRealWavetableFloat
    n : LibC::SizeT
    nf : LibC::SizeT
    factor : LibC::SizeT[64]
    twiddle : ComplexFloat*[64]
    trig : ComplexFloat*
  end

  fun fft_real_wavetable_float_free = gsl_fft_real_wavetable_float_free(wavetable : FftRealWavetableFloat*)
  fun fft_real_workspace_float_alloc = gsl_fft_real_workspace_float_alloc(n : LibC::SizeT) : FftRealWorkspaceFloat*

  struct FftRealWorkspaceFloat
    n : LibC::SizeT
    scratch : LibC::Float*
  end

  fun fft_real_workspace_float_free = gsl_fft_real_workspace_float_free(workspace : FftRealWorkspaceFloat*)
  fun fft_real_float_transform = gsl_fft_real_float_transform(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftRealWavetableFloat*, work : FftRealWorkspaceFloat*) : LibC::Int
  fun fft_real_float_unpack = gsl_fft_real_float_unpack(real_float_coefficient : LibC::Float*, complex_coefficient : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_float_radix2_backward = gsl_fft_halfcomplex_float_radix2_backward(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_float_radix2_inverse = gsl_fft_halfcomplex_float_radix2_inverse(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_float_radix2_transform = gsl_fft_halfcomplex_float_radix2_transform(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_wavetable_float_alloc = gsl_fft_halfcomplex_wavetable_float_alloc(n : LibC::SizeT) : FftHalfcomplexWavetableFloat*

  struct FftHalfcomplexWavetableFloat
    n : LibC::SizeT
    nf : LibC::SizeT
    factor : LibC::SizeT[64]
    twiddle : ComplexFloat*[64]
    trig : ComplexFloat*
  end

  fun fft_halfcomplex_wavetable_float_free = gsl_fft_halfcomplex_wavetable_float_free(wavetable : FftHalfcomplexWavetableFloat*)
  fun fft_halfcomplex_float_backward = gsl_fft_halfcomplex_float_backward(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftHalfcomplexWavetableFloat*, work : FftRealWorkspaceFloat*) : LibC::Int
  fun fft_halfcomplex_float_inverse = gsl_fft_halfcomplex_float_inverse(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftHalfcomplexWavetableFloat*, work : FftRealWorkspaceFloat*) : LibC::Int
  fun fft_halfcomplex_float_transform = gsl_fft_halfcomplex_float_transform(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftHalfcomplexWavetableFloat*, work : FftRealWorkspaceFloat*) : LibC::Int
  fun fft_halfcomplex_float_unpack = gsl_fft_halfcomplex_float_unpack(halfcomplex_coefficient : LibC::Float*, complex_coefficient : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_float_radix2_unpack = gsl_fft_halfcomplex_float_radix2_unpack(halfcomplex_coefficient : LibC::Float*, complex_coefficient : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_real_radix2_transform = gsl_fft_real_radix2_transform(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_real_wavetable_alloc = gsl_fft_real_wavetable_alloc(n : LibC::SizeT) : FftRealWavetable*

  struct FftRealWavetable
    n : LibC::SizeT
    nf : LibC::SizeT
    factor : LibC::SizeT[64]
    twiddle : Complex*[64]
    trig : Complex*
  end

  fun fft_real_wavetable_free = gsl_fft_real_wavetable_free(wavetable : FftRealWavetable*)
  fun fft_real_workspace_alloc = gsl_fft_real_workspace_alloc(n : LibC::SizeT) : FftRealWorkspace*

  struct FftRealWorkspace
    n : LibC::SizeT
    scratch : LibC::Double*
  end

  fun fft_real_workspace_free = gsl_fft_real_workspace_free(workspace : FftRealWorkspace*)
  fun fft_real_transform = gsl_fft_real_transform(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftRealWavetable*, work : FftRealWorkspace*) : LibC::Int
  fun fft_real_unpack = gsl_fft_real_unpack(real_coefficient : LibC::Double*, complex_coefficient : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_radix2_backward = gsl_fft_halfcomplex_radix2_backward(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_radix2_inverse = gsl_fft_halfcomplex_radix2_inverse(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_radix2_transform = gsl_fft_halfcomplex_radix2_transform(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_wavetable_alloc = gsl_fft_halfcomplex_wavetable_alloc(n : LibC::SizeT) : FftHalfcomplexWavetable*

  struct FftHalfcomplexWavetable
    n : LibC::SizeT
    nf : LibC::SizeT
    factor : LibC::SizeT[64]
    twiddle : Complex*[64]
    trig : Complex*
  end

  fun fft_halfcomplex_wavetable_free = gsl_fft_halfcomplex_wavetable_free(wavetable : FftHalfcomplexWavetable*)
  fun fft_halfcomplex_backward = gsl_fft_halfcomplex_backward(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftHalfcomplexWavetable*, work : FftRealWorkspace*) : LibC::Int
  fun fft_halfcomplex_inverse = gsl_fft_halfcomplex_inverse(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftHalfcomplexWavetable*, work : FftRealWorkspace*) : LibC::Int
  fun fft_halfcomplex_transform = gsl_fft_halfcomplex_transform(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wavetable : FftHalfcomplexWavetable*, work : FftRealWorkspace*) : LibC::Int
  fun fft_halfcomplex_unpack = gsl_fft_halfcomplex_unpack(halfcomplex_coefficient : LibC::Double*, complex_coefficient : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fft_halfcomplex_radix2_unpack = gsl_fft_halfcomplex_radix2_unpack(halfcomplex_coefficient : LibC::Double*, complex_coefficient : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun fit_linear = gsl_fit_linear(x : LibC::Double*, xstride : LibC::SizeT, y : LibC::Double*, ystride : LibC::SizeT, n : LibC::SizeT, c0 : LibC::Double*, c1 : LibC::Double*, cov00 : LibC::Double*, cov01 : LibC::Double*, cov11 : LibC::Double*, sumsq : LibC::Double*) : LibC::Int
  fun fit_wlinear = gsl_fit_wlinear(x : LibC::Double*, xstride : LibC::SizeT, w : LibC::Double*, wstride : LibC::SizeT, y : LibC::Double*, ystride : LibC::SizeT, n : LibC::SizeT, c0 : LibC::Double*, c1 : LibC::Double*, cov00 : LibC::Double*, cov01 : LibC::Double*, cov11 : LibC::Double*, chisq : LibC::Double*) : LibC::Int
  fun fit_linear_est = gsl_fit_linear_est(x : LibC::Double, c0 : LibC::Double, c1 : LibC::Double, cov00 : LibC::Double, cov01 : LibC::Double, cov11 : LibC::Double, y : LibC::Double*, y_err : LibC::Double*) : LibC::Int
  fun fit_mul = gsl_fit_mul(x : LibC::Double*, xstride : LibC::SizeT, y : LibC::Double*, ystride : LibC::SizeT, n : LibC::SizeT, c1 : LibC::Double*, cov11 : LibC::Double*, sumsq : LibC::Double*) : LibC::Int
  fun fit_wmul = gsl_fit_wmul(x : LibC::Double*, xstride : LibC::SizeT, w : LibC::Double*, wstride : LibC::SizeT, y : LibC::Double*, ystride : LibC::SizeT, n : LibC::SizeT, c1 : LibC::Double*, cov11 : LibC::Double*, sumsq : LibC::Double*) : LibC::Int
  fun fit_mul_est = gsl_fit_mul_est(x : LibC::Double, c1 : LibC::Double, cov11 : LibC::Double, y : LibC::Double*, y_err : LibC::Double*) : LibC::Int

  struct PermutationStruct
    size : LibC::SizeT
    data : LibC::SizeT*
  end

  fun permutation_alloc = gsl_permutation_alloc(n : LibC::SizeT) : Permutation*
  type Permutation = PermutationStruct
  fun permutation_calloc = gsl_permutation_calloc(n : LibC::SizeT) : Permutation*
  fun permutation_init = gsl_permutation_init(p : Permutation*)
  fun permutation_free = gsl_permutation_free(p : Permutation*)
  fun permutation_memcpy = gsl_permutation_memcpy(dest : Permutation*, src : Permutation*) : LibC::Int
  fun permutation_fread = gsl_permutation_fread(stream : File*, p : Permutation*) : LibC::Int
  fun permutation_fwrite = gsl_permutation_fwrite(stream : File*, p : Permutation*) : LibC::Int
  fun permutation_fscanf = gsl_permutation_fscanf(stream : File*, p : Permutation*) : LibC::Int
  fun permutation_fprintf = gsl_permutation_fprintf(stream : File*, p : Permutation*, format : LibC::Char*) : LibC::Int
  fun permutation_size = gsl_permutation_size(p : Permutation*) : LibC::SizeT
  fun permutation_data = gsl_permutation_data(p : Permutation*) : LibC::SizeT*
  fun permutation_swap = gsl_permutation_swap(p : Permutation*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Int
  fun permutation_valid = gsl_permutation_valid(p : Permutation*) : LibC::Int
  fun permutation_reverse = gsl_permutation_reverse(p : Permutation*)
  fun permutation_inverse = gsl_permutation_inverse(inv : Permutation*, p : Permutation*) : LibC::Int
  fun permutation_next = gsl_permutation_next(p : Permutation*) : LibC::Int
  fun permutation_prev = gsl_permutation_prev(p : Permutation*) : LibC::Int
  fun permutation_mul = gsl_permutation_mul(p : Permutation*, pa : Permutation*, pb : Permutation*) : LibC::Int
  fun permutation_linear_to_canonical = gsl_permutation_linear_to_canonical(q : Permutation*, p : Permutation*) : LibC::Int
  fun permutation_canonical_to_linear = gsl_permutation_canonical_to_linear(p : Permutation*, q : Permutation*) : LibC::Int
  fun permutation_inversions = gsl_permutation_inversions(p : Permutation*) : LibC::SizeT
  fun permutation_linear_cycles = gsl_permutation_linear_cycles(p : Permutation*) : LibC::SizeT
  fun permutation_canonical_cycles = gsl_permutation_canonical_cycles(q : Permutation*) : LibC::SizeT
  fun permutation_get = gsl_permutation_get(p : Permutation*, i : LibC::SizeT) : LibC::SizeT
  fun heapsort = gsl_heapsort(array : Void*, count : LibC::SizeT, size : LibC::SizeT, compare : ComparisonFnT)
  alias ComparisonFnT = (Void*, Void* -> LibC::Int)
  fun heapsort_index = gsl_heapsort_index(p : LibC::SizeT*, array : Void*, count : LibC::SizeT, size : LibC::SizeT, compare : ComparisonFnT) : LibC::Int
  fun histogram2d_alloc = gsl_histogram2d_alloc(nx : LibC::SizeT, ny : LibC::SizeT) : Histogram2d*

  struct Histogram2d
    nx : LibC::SizeT
    ny : LibC::SizeT
    xrange : LibC::Double*
    yrange : LibC::Double*
    bin : LibC::Double*
  end

  fun histogram2d_calloc = gsl_histogram2d_calloc(nx : LibC::SizeT, ny : LibC::SizeT) : Histogram2d*
  fun histogram2d_calloc_uniform = gsl_histogram2d_calloc_uniform(nx : LibC::SizeT, ny : LibC::SizeT, xmin : LibC::Double, xmax : LibC::Double, ymin : LibC::Double, ymax : LibC::Double) : Histogram2d*
  fun histogram2d_free = gsl_histogram2d_free(h : Histogram2d*)
  fun histogram2d_increment = gsl_histogram2d_increment(h : Histogram2d*, x : LibC::Double, y : LibC::Double) : LibC::Int
  fun histogram2d_accumulate = gsl_histogram2d_accumulate(h : Histogram2d*, x : LibC::Double, y : LibC::Double, weight : LibC::Double) : LibC::Int
  fun histogram2d_find = gsl_histogram2d_find(h : Histogram2d*, x : LibC::Double, y : LibC::Double, i : LibC::SizeT*, j : LibC::SizeT*) : LibC::Int
  fun histogram2d_get = gsl_histogram2d_get(h : Histogram2d*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Double
  fun histogram2d_get_xrange = gsl_histogram2d_get_xrange(h : Histogram2d*, i : LibC::SizeT, xlower : LibC::Double*, xupper : LibC::Double*) : LibC::Int
  fun histogram2d_get_yrange = gsl_histogram2d_get_yrange(h : Histogram2d*, j : LibC::SizeT, ylower : LibC::Double*, yupper : LibC::Double*) : LibC::Int
  fun histogram2d_xmax = gsl_histogram2d_xmax(h : Histogram2d*) : LibC::Double
  fun histogram2d_xmin = gsl_histogram2d_xmin(h : Histogram2d*) : LibC::Double
  fun histogram2d_nx = gsl_histogram2d_nx(h : Histogram2d*) : LibC::SizeT
  fun histogram2d_ymax = gsl_histogram2d_ymax(h : Histogram2d*) : LibC::Double
  fun histogram2d_ymin = gsl_histogram2d_ymin(h : Histogram2d*) : LibC::Double
  fun histogram2d_ny = gsl_histogram2d_ny(h : Histogram2d*) : LibC::SizeT
  fun histogram2d_reset = gsl_histogram2d_reset(h : Histogram2d*)
  fun histogram2d_calloc_range = gsl_histogram2d_calloc_range(nx : LibC::SizeT, ny : LibC::SizeT, xrange : LibC::Double*, yrange : LibC::Double*) : Histogram2d*
  fun histogram2d_set_ranges_uniform = gsl_histogram2d_set_ranges_uniform(h : Histogram2d*, xmin : LibC::Double, xmax : LibC::Double, ymin : LibC::Double, ymax : LibC::Double) : LibC::Int
  fun histogram2d_set_ranges = gsl_histogram2d_set_ranges(h : Histogram2d*, xrange : LibC::Double*, xsize : LibC::SizeT, yrange : LibC::Double*, ysize : LibC::SizeT) : LibC::Int
  fun histogram2d_memcpy = gsl_histogram2d_memcpy(dest : Histogram2d*, source : Histogram2d*) : LibC::Int
  fun histogram2d_clone = gsl_histogram2d_clone(source : Histogram2d*) : Histogram2d*
  fun histogram2d_max_val = gsl_histogram2d_max_val(h : Histogram2d*) : LibC::Double
  fun histogram2d_max_bin = gsl_histogram2d_max_bin(h : Histogram2d*, i : LibC::SizeT*, j : LibC::SizeT*)
  fun histogram2d_min_val = gsl_histogram2d_min_val(h : Histogram2d*) : LibC::Double
  fun histogram2d_min_bin = gsl_histogram2d_min_bin(h : Histogram2d*, i : LibC::SizeT*, j : LibC::SizeT*)
  fun histogram2d_xmean = gsl_histogram2d_xmean(h : Histogram2d*) : LibC::Double
  fun histogram2d_ymean = gsl_histogram2d_ymean(h : Histogram2d*) : LibC::Double
  fun histogram2d_xsigma = gsl_histogram2d_xsigma(h : Histogram2d*) : LibC::Double
  fun histogram2d_ysigma = gsl_histogram2d_ysigma(h : Histogram2d*) : LibC::Double
  fun histogram2d_cov = gsl_histogram2d_cov(h : Histogram2d*) : LibC::Double
  fun histogram2d_sum = gsl_histogram2d_sum(h : Histogram2d*) : LibC::Double
  fun histogram2d_equal_bins_p = gsl_histogram2d_equal_bins_p(h1 : Histogram2d*, h2 : Histogram2d*) : LibC::Int
  fun histogram2d_add = gsl_histogram2d_add(h1 : Histogram2d*, h2 : Histogram2d*) : LibC::Int
  fun histogram2d_sub = gsl_histogram2d_sub(h1 : Histogram2d*, h2 : Histogram2d*) : LibC::Int
  fun histogram2d_mul = gsl_histogram2d_mul(h1 : Histogram2d*, h2 : Histogram2d*) : LibC::Int
  fun histogram2d_div = gsl_histogram2d_div(h1 : Histogram2d*, h2 : Histogram2d*) : LibC::Int
  fun histogram2d_scale = gsl_histogram2d_scale(h : Histogram2d*, scale : LibC::Double) : LibC::Int
  fun histogram2d_shift = gsl_histogram2d_shift(h : Histogram2d*, shift : LibC::Double) : LibC::Int
  fun histogram2d_fwrite = gsl_histogram2d_fwrite(stream : File*, h : Histogram2d*) : LibC::Int
  fun histogram2d_fread = gsl_histogram2d_fread(stream : File*, h : Histogram2d*) : LibC::Int
  fun histogram2d_fprintf = gsl_histogram2d_fprintf(stream : File*, h : Histogram2d*, range_format : LibC::Char*, bin_format : LibC::Char*) : LibC::Int
  fun histogram2d_fscanf = gsl_histogram2d_fscanf(stream : File*, h : Histogram2d*) : LibC::Int
  fun histogram2d_pdf_alloc = gsl_histogram2d_pdf_alloc(nx : LibC::SizeT, ny : LibC::SizeT) : Histogram2dPdf*

  struct Histogram2dPdf
    nx : LibC::SizeT
    ny : LibC::SizeT
    xrange : LibC::Double*
    yrange : LibC::Double*
    sum : LibC::Double*
  end

  fun histogram2d_pdf_init = gsl_histogram2d_pdf_init(p : Histogram2dPdf*, h : Histogram2d*) : LibC::Int
  fun histogram2d_pdf_free = gsl_histogram2d_pdf_free(p : Histogram2dPdf*)
  fun histogram2d_pdf_sample = gsl_histogram2d_pdf_sample(p : Histogram2dPdf*, r1 : LibC::Double, r2 : LibC::Double, x : LibC::Double*, y : LibC::Double*) : LibC::Int
  fun histogram_alloc = gsl_histogram_alloc(n : LibC::SizeT) : Histogram*

  struct Histogram
    n : LibC::SizeT
    range : LibC::Double*
    bin : LibC::Double*
  end

  fun histogram_calloc = gsl_histogram_calloc(n : LibC::SizeT) : Histogram*
  fun histogram_calloc_uniform = gsl_histogram_calloc_uniform(n : LibC::SizeT, xmin : LibC::Double, xmax : LibC::Double) : Histogram*
  fun histogram_free = gsl_histogram_free(h : Histogram*)
  fun histogram_increment = gsl_histogram_increment(h : Histogram*, x : LibC::Double) : LibC::Int
  fun histogram_accumulate = gsl_histogram_accumulate(h : Histogram*, x : LibC::Double, weight : LibC::Double) : LibC::Int
  fun histogram_find = gsl_histogram_find(h : Histogram*, x : LibC::Double, i : LibC::SizeT*) : LibC::Int
  fun histogram_get = gsl_histogram_get(h : Histogram*, i : LibC::SizeT) : LibC::Double
  fun histogram_get_range = gsl_histogram_get_range(h : Histogram*, i : LibC::SizeT, lower : LibC::Double*, upper : LibC::Double*) : LibC::Int
  fun histogram_max = gsl_histogram_max(h : Histogram*) : LibC::Double
  fun histogram_min = gsl_histogram_min(h : Histogram*) : LibC::Double
  fun histogram_bins = gsl_histogram_bins(h : Histogram*) : LibC::SizeT
  fun histogram_reset = gsl_histogram_reset(h : Histogram*)
  fun histogram_calloc_range = gsl_histogram_calloc_range(n : LibC::SizeT, range : LibC::Double*) : Histogram*
  fun histogram_set_ranges = gsl_histogram_set_ranges(h : Histogram*, range : LibC::Double*, size : LibC::SizeT) : LibC::Int
  fun histogram_set_ranges_uniform = gsl_histogram_set_ranges_uniform(h : Histogram*, xmin : LibC::Double, xmax : LibC::Double) : LibC::Int
  fun histogram_memcpy = gsl_histogram_memcpy(dest : Histogram*, source : Histogram*) : LibC::Int
  fun histogram_clone = gsl_histogram_clone(source : Histogram*) : Histogram*
  fun histogram_max_val = gsl_histogram_max_val(h : Histogram*) : LibC::Double
  fun histogram_max_bin = gsl_histogram_max_bin(h : Histogram*) : LibC::SizeT
  fun histogram_min_val = gsl_histogram_min_val(h : Histogram*) : LibC::Double
  fun histogram_min_bin = gsl_histogram_min_bin(h : Histogram*) : LibC::SizeT
  fun histogram_equal_bins_p = gsl_histogram_equal_bins_p(h1 : Histogram*, h2 : Histogram*) : LibC::Int
  fun histogram_add = gsl_histogram_add(h1 : Histogram*, h2 : Histogram*) : LibC::Int
  fun histogram_sub = gsl_histogram_sub(h1 : Histogram*, h2 : Histogram*) : LibC::Int
  fun histogram_mul = gsl_histogram_mul(h1 : Histogram*, h2 : Histogram*) : LibC::Int
  fun histogram_div = gsl_histogram_div(h1 : Histogram*, h2 : Histogram*) : LibC::Int
  fun histogram_scale = gsl_histogram_scale(h : Histogram*, scale : LibC::Double) : LibC::Int
  fun histogram_shift = gsl_histogram_shift(h : Histogram*, shift : LibC::Double) : LibC::Int
  fun histogram_sigma = gsl_histogram_sigma(h : Histogram*) : LibC::Double
  fun histogram_mean = gsl_histogram_mean(h : Histogram*) : LibC::Double
  fun histogram_sum = gsl_histogram_sum(h : Histogram*) : LibC::Double
  fun histogram_fwrite = gsl_histogram_fwrite(stream : File*, h : Histogram*) : LibC::Int
  fun histogram_fread = gsl_histogram_fread(stream : File*, h : Histogram*) : LibC::Int
  fun histogram_fprintf = gsl_histogram_fprintf(stream : File*, h : Histogram*, range_format : LibC::Char*, bin_format : LibC::Char*) : LibC::Int
  fun histogram_fscanf = gsl_histogram_fscanf(stream : File*, h : Histogram*) : LibC::Int
  fun histogram_pdf_alloc = gsl_histogram_pdf_alloc(n : LibC::SizeT) : HistogramPdf*

  struct HistogramPdf
    n : LibC::SizeT
    range : LibC::Double*
    sum : LibC::Double*
  end

  fun histogram_pdf_init = gsl_histogram_pdf_init(p : HistogramPdf*, h : Histogram*) : LibC::Int
  fun histogram_pdf_free = gsl_histogram_pdf_free(p : HistogramPdf*)
  fun histogram_pdf_sample = gsl_histogram_pdf_sample(p : HistogramPdf*, r : LibC::Double) : LibC::Double
  fun ieee_printf_float = gsl_ieee_printf_float(x : LibC::Float*)
  fun ieee_printf_double = gsl_ieee_printf_double(x : LibC::Double*)
  fun ieee_fprintf_float = gsl_ieee_fprintf_float(stream : File*, x : LibC::Float*)
  fun ieee_fprintf_double = gsl_ieee_fprintf_double(stream : File*, x : LibC::Double*)
  fun ieee_float_to_rep = gsl_ieee_float_to_rep(x : LibC::Float*, r : IeeeFloatRep*)

  struct IeeeFloatRep
    sign : LibC::Int
    mantissa : LibC::Char[24]
    exponent : LibC::Int
    type : LibC::Int
  end

  fun ieee_double_to_rep = gsl_ieee_double_to_rep(x : LibC::Double*, r : IeeeDoubleRep*)

  struct IeeeDoubleRep
    sign : LibC::Int
    mantissa : LibC::Char[53]
    exponent : LibC::Int
    type : LibC::Int
  end

  fun ieee_env_setup = gsl_ieee_env_setup
  fun ieee_read_mode_string = gsl_ieee_read_mode_string(description : LibC::Char*, precision : LibC::Int*, rounding : LibC::Int*, exception_mask : LibC::Int*) : LibC::Int
  fun ieee_set_mode = gsl_ieee_set_mode(precision : LibC::Int, rounding : LibC::Int, exception_mask : LibC::Int) : LibC::Int
  fun integration_workspace_alloc = gsl_integration_workspace_alloc(n : LibC::SizeT) : IntegrationWorkspace*

  struct IntegrationWorkspace
    limit : LibC::SizeT
    size : LibC::SizeT
    nrmax : LibC::SizeT
    i : LibC::SizeT
    maximum_level : LibC::SizeT
    alist : LibC::Double*
    blist : LibC::Double*
    rlist : LibC::Double*
    elist : LibC::Double*
    order : LibC::SizeT*
    level : LibC::SizeT*
  end

  fun integration_workspace_free = gsl_integration_workspace_free(w : IntegrationWorkspace*)
  fun integration_qaws_table_alloc = gsl_integration_qaws_table_alloc(alpha : LibC::Double, beta : LibC::Double, mu : LibC::Int, nu : LibC::Int) : IntegrationQawsTable*

  struct IntegrationQawsTable
    alpha : LibC::Double
    beta : LibC::Double
    mu : LibC::Int
    nu : LibC::Int
    ri : LibC::Double[25]
    rj : LibC::Double[25]
    rg : LibC::Double[25]
    rh : LibC::Double[25]
  end

  fun integration_qaws_table_set = gsl_integration_qaws_table_set(t : IntegrationQawsTable*, alpha : LibC::Double, beta : LibC::Double, mu : LibC::Int, nu : LibC::Int) : LibC::Int
  fun integration_qaws_table_free = gsl_integration_qaws_table_free(t : IntegrationQawsTable*)
  fun integration_qawo_table_alloc = gsl_integration_qawo_table_alloc(omega : LibC::Double, l : LibC::Double, sine : IntegrationQawoEnum, n : LibC::SizeT) : IntegrationQawoTable*
  enum IntegrationQawoEnum
    GslIntegCosine = 0
    GslIntegSine   = 1
  end

  struct IntegrationQawoTable
    n : LibC::SizeT
    omega : LibC::Double
    l : LibC::Double
    par : LibC::Double
    sine : IntegrationQawoEnum
    chebmo : LibC::Double*
  end

  fun integration_qawo_table_set = gsl_integration_qawo_table_set(t : IntegrationQawoTable*, omega : LibC::Double, l : LibC::Double, sine : IntegrationQawoEnum) : LibC::Int
  fun integration_qawo_table_set_length = gsl_integration_qawo_table_set_length(t : IntegrationQawoTable*, l : LibC::Double) : LibC::Int
  fun integration_qawo_table_free = gsl_integration_qawo_table_free(t : IntegrationQawoTable*)
  fun integration_qk15 = gsl_integration_qk15(f : Function*, a : LibC::Double, b : LibC::Double, result : LibC::Double*, abserr : LibC::Double*, resabs : LibC::Double*, resasc : LibC::Double*)
  fun integration_qk21 = gsl_integration_qk21(f : Function*, a : LibC::Double, b : LibC::Double, result : LibC::Double*, abserr : LibC::Double*, resabs : LibC::Double*, resasc : LibC::Double*)
  fun integration_qk31 = gsl_integration_qk31(f : Function*, a : LibC::Double, b : LibC::Double, result : LibC::Double*, abserr : LibC::Double*, resabs : LibC::Double*, resasc : LibC::Double*)
  fun integration_qk41 = gsl_integration_qk41(f : Function*, a : LibC::Double, b : LibC::Double, result : LibC::Double*, abserr : LibC::Double*, resabs : LibC::Double*, resasc : LibC::Double*)
  fun integration_qk51 = gsl_integration_qk51(f : Function*, a : LibC::Double, b : LibC::Double, result : LibC::Double*, abserr : LibC::Double*, resabs : LibC::Double*, resasc : LibC::Double*)
  fun integration_qk61 = gsl_integration_qk61(f : Function*, a : LibC::Double, b : LibC::Double, result : LibC::Double*, abserr : LibC::Double*, resabs : LibC::Double*, resasc : LibC::Double*)
  fun integration_qcheb = gsl_integration_qcheb(f : Function*, a : LibC::Double, b : LibC::Double, cheb12 : LibC::Double*, cheb24 : LibC::Double*)
  fun integration_qk = gsl_integration_qk(n : LibC::Int, xgk : LibC::Double*, wg : LibC::Double*, wgk : LibC::Double*, fv1 : LibC::Double*, fv2 : LibC::Double*, f : Function*, a : LibC::Double, b : LibC::Double, result : LibC::Double*, abserr : LibC::Double*, resabs : LibC::Double*, resasc : LibC::Double*)
  fun integration_qng = gsl_integration_qng(f : Function*, a : LibC::Double, b : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, result : LibC::Double*, abserr : LibC::Double*, neval : LibC::SizeT*) : LibC::Int
  fun integration_qag = gsl_integration_qag(f : Function*, a : LibC::Double, b : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, key : LibC::Int, workspace : IntegrationWorkspace*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qagi = gsl_integration_qagi(f : Function*, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qagiu = gsl_integration_qagiu(f : Function*, a : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qagil = gsl_integration_qagil(f : Function*, b : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qags = gsl_integration_qags(f : Function*, a : LibC::Double, b : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qagp = gsl_integration_qagp(f : Function*, pts : LibC::Double*, npts : LibC::SizeT, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qawc = gsl_integration_qawc(f : Function*, a : LibC::Double, b : LibC::Double, c : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qaws = gsl_integration_qaws(f : Function*, a : LibC::Double, b : LibC::Double, t : IntegrationQawsTable*, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qawo = gsl_integration_qawo(f : Function*, a : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, wf : IntegrationQawoTable*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_qawf = gsl_integration_qawf(f : Function*, a : LibC::Double, epsabs : LibC::Double, limit : LibC::SizeT, workspace : IntegrationWorkspace*, cycle_workspace : IntegrationWorkspace*, wf : IntegrationQawoTable*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun integration_glfixed_table_alloc = gsl_integration_glfixed_table_alloc(n : LibC::SizeT) : IntegrationGlfixedTable*

  struct IntegrationGlfixedTable
    n : LibC::SizeT
    x : LibC::Double*
    w : LibC::Double*
    precomputed : LibC::Int
  end

  fun integration_glfixed_table_free = gsl_integration_glfixed_table_free(t : IntegrationGlfixedTable*)
  fun integration_glfixed = gsl_integration_glfixed(f : Function*, a : LibC::Double, b : LibC::Double, t : IntegrationGlfixedTable*) : LibC::Double
  fun integration_glfixed_point = gsl_integration_glfixed_point(a : LibC::Double, b : LibC::Double, i : LibC::SizeT, xi : LibC::Double*, wi : LibC::Double*, t : IntegrationGlfixedTable*) : LibC::Int
  fun integration_cquad_workspace_alloc = gsl_integration_cquad_workspace_alloc(n : LibC::SizeT) : IntegrationCquadWorkspace*

  struct IntegrationCquadWorkspace
    size : LibC::SizeT
    ivals : IntegrationCquadIval*
    heap : LibC::SizeT*
  end

  struct IntegrationCquadIval
    a : LibC::Double
    b : LibC::Double
    c : LibC::Double[64]
    fx : LibC::Double[33]
    igral : LibC::Double
    err : LibC::Double
    depth : LibC::Int
    rdepth : LibC::Int
    ndiv : LibC::Int
  end

  fun integration_cquad_workspace_free = gsl_integration_cquad_workspace_free(w : IntegrationCquadWorkspace*)
  fun integration_cquad = gsl_integration_cquad(f : Function*, a : LibC::Double, b : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, ws : IntegrationCquadWorkspace*, result : LibC::Double*, abserr : LibC::Double*, nevals : LibC::SizeT*) : LibC::Int

  struct IntegrationFixedType
    check : (LibC::SizeT, IntegrationFixedParams* -> LibC::Int)
    init : (LibC::SizeT, LibC::Double*, LibC::Double*, IntegrationFixedParams* -> LibC::Int)
  end

  struct IntegrationFixedParams
    alpha : LibC::Double
    beta : LibC::Double
    a : LibC::Double
    b : LibC::Double
    zemu : LibC::Double
    shft : LibC::Double
    slp : LibC::Double
    al : LibC::Double
    be : LibC::Double
  end

  fun integration_fixed_alloc = gsl_integration_fixed_alloc(type : IntegrationFixedType*, n : LibC::SizeT, a : LibC::Double, b : LibC::Double, alpha : LibC::Double, beta : LibC::Double) : IntegrationFixedWorkspace*

  struct IntegrationFixedWorkspace
    n : LibC::SizeT
    weights : LibC::Double*
    x : LibC::Double*
    diag : LibC::Double*
    subdiag : LibC::Double*
    type : IntegrationFixedType*
  end

  fun integration_fixed_free = gsl_integration_fixed_free(w : IntegrationFixedWorkspace*)
  fun integration_fixed_n = gsl_integration_fixed_n(w : IntegrationFixedWorkspace*) : LibC::SizeT
  fun integration_fixed_nodes = gsl_integration_fixed_nodes(w : IntegrationFixedWorkspace*) : LibC::Double*
  fun integration_fixed_weights = gsl_integration_fixed_weights(w : IntegrationFixedWorkspace*) : LibC::Double*
  fun integration_fixed = gsl_integration_fixed(func : Function*, result : LibC::Double*, w : IntegrationFixedWorkspace*) : LibC::Int

  struct InterpType
    name : LibC::Char*
    min_size : LibC::UInt
    alloc : (LibC::SizeT -> Void*)
    init : (Void*, LibC::Double*, LibC::Double*, LibC::SizeT -> LibC::Int)
    eval : (Void*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::Double, InterpAccel*, LibC::Double* -> LibC::Int)
    eval_deriv : (Void*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::Double, InterpAccel*, LibC::Double* -> LibC::Int)
    eval_deriv2 : (Void*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::Double, InterpAccel*, LibC::Double* -> LibC::Int)
    eval_integ : (Void*, LibC::Double*, LibC::Double*, LibC::SizeT, InterpAccel*, LibC::Double, LibC::Double, LibC::Double* -> LibC::Int)
    free : (Void* -> Void)
  end

  struct InterpAccel
    cache : LibC::SizeT
    miss_count : LibC::SizeT
    hit_count : LibC::SizeT
  end

  fun interp_accel_alloc = gsl_interp_accel_alloc : InterpAccel*
  fun interp_accel_reset = gsl_interp_accel_reset(a : InterpAccel*) : LibC::Int
  fun interp_accel_free = gsl_interp_accel_free(a : InterpAccel*)
  fun interp_alloc = gsl_interp_alloc(t : InterpType*, n : LibC::SizeT) : Interp*

  struct Interp
    type : InterpType*
    xmin : LibC::Double
    xmax : LibC::Double
    size : LibC::SizeT
    state : Void*
  end

  fun interp_init = gsl_interp_init(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, size : LibC::SizeT) : LibC::Int
  fun interp_name = gsl_interp_name(interp : Interp*) : LibC::Char*
  fun interp_min_size = gsl_interp_min_size(interp : Interp*) : LibC::UInt
  fun interp_type_min_size = gsl_interp_type_min_size(t : InterpType*) : LibC::UInt
  fun interp_eval_e = gsl_interp_eval_e(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, x : LibC::Double, a : InterpAccel*, y : LibC::Double*) : LibC::Int
  fun interp_eval = gsl_interp_eval(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, x : LibC::Double, a : InterpAccel*) : LibC::Double
  fun interp_eval_deriv_e = gsl_interp_eval_deriv_e(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, x : LibC::Double, a : InterpAccel*, d : LibC::Double*) : LibC::Int
  fun interp_eval_deriv = gsl_interp_eval_deriv(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, x : LibC::Double, a : InterpAccel*) : LibC::Double
  fun interp_eval_deriv2_e = gsl_interp_eval_deriv2_e(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, x : LibC::Double, a : InterpAccel*, d2 : LibC::Double*) : LibC::Int
  fun interp_eval_deriv2 = gsl_interp_eval_deriv2(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, x : LibC::Double, a : InterpAccel*) : LibC::Double
  fun interp_eval_integ_e = gsl_interp_eval_integ_e(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, a : LibC::Double, b : LibC::Double, acc : InterpAccel*, result : LibC::Double*) : LibC::Int
  fun interp_eval_integ = gsl_interp_eval_integ(obj : Interp*, xa : LibC::Double*, ya : LibC::Double*, a : LibC::Double, b : LibC::Double, acc : InterpAccel*) : LibC::Double
  fun interp_free = gsl_interp_free(interp : Interp*)
  fun interp_bsearch = gsl_interp_bsearch(x_array : LibC::Double*, x : LibC::Double, index_lo : LibC::SizeT, index_hi : LibC::SizeT) : LibC::SizeT
  fun interp_accel_find = gsl_interp_accel_find(a : InterpAccel*, x_array : LibC::Double*, size : LibC::SizeT, x : LibC::Double) : LibC::SizeT

  struct Interp2dType
    name : LibC::Char*
    min_size : LibC::UInt
    alloc : (LibC::SizeT, LibC::SizeT -> Void*)
    init : (Void*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::SizeT -> LibC::Int)
    eval : (Void*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::SizeT, LibC::Double, LibC::Double, InterpAccel*, InterpAccel*, LibC::Double* -> LibC::Int)
    eval_deriv_x : (Void*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::SizeT, LibC::Double, LibC::Double, InterpAccel*, InterpAccel*, LibC::Double* -> LibC::Int)
    eval_deriv_y : (Void*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::SizeT, LibC::Double, LibC::Double, InterpAccel*, InterpAccel*, LibC::Double* -> LibC::Int)
    eval_deriv_xx : (Void*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::SizeT, LibC::Double, LibC::Double, InterpAccel*, InterpAccel*, LibC::Double* -> LibC::Int)
    eval_deriv_xy : (Void*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::SizeT, LibC::Double, LibC::Double, InterpAccel*, InterpAccel*, LibC::Double* -> LibC::Int)
    eval_deriv_yy : (Void*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::SizeT, LibC::SizeT, LibC::Double, LibC::Double, InterpAccel*, InterpAccel*, LibC::Double* -> LibC::Int)
    free : (Void* -> Void)
  end

  fun interp2d_alloc = gsl_interp2d_alloc(t : Interp2dType*, xsize : LibC::SizeT, ysize : LibC::SizeT) : Interp2d*

  struct Interp2d
    type : Interp2dType*
    xmin : LibC::Double
    xmax : LibC::Double
    ymin : LibC::Double
    ymax : LibC::Double
    xsize : LibC::SizeT
    ysize : LibC::SizeT
    state : Void*
  end

  fun interp2d_name = gsl_interp2d_name(interp : Interp2d*) : LibC::Char*
  fun interp2d_min_size = gsl_interp2d_min_size(interp : Interp2d*) : LibC::SizeT
  fun interp2d_type_min_size = gsl_interp2d_type_min_size(t : Interp2dType*) : LibC::SizeT
  fun interp2d_set = gsl_interp2d_set(interp : Interp2d*, zarr : LibC::Double*, i : LibC::SizeT, j : LibC::SizeT, z : LibC::Double) : LibC::Int
  fun interp2d_get = gsl_interp2d_get(interp : Interp2d*, zarr : LibC::Double*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Double
  fun interp2d_idx = gsl_interp2d_idx(interp : Interp2d*, i : LibC::SizeT, j : LibC::SizeT) : LibC::SizeT
  fun interp2d_init = gsl_interp2d_init(interp : Interp2d*, xa : LibC::Double*, ya : LibC::Double*, za : LibC::Double*, xsize : LibC::SizeT, ysize : LibC::SizeT) : LibC::Int
  fun interp2d_free = gsl_interp2d_free(interp : Interp2d*)
  fun interp2d_eval = gsl_interp2d_eval(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun interp2d_eval_extrap = gsl_interp2d_eval_extrap(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun interp2d_eval_e = gsl_interp2d_eval_e(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun interp2d_eval_e_extrap = gsl_interp2d_eval_e_extrap(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun interp2d_eval_deriv_x = gsl_interp2d_eval_deriv_x(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun interp2d_eval_deriv_x_e = gsl_interp2d_eval_deriv_x_e(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun interp2d_eval_deriv_y = gsl_interp2d_eval_deriv_y(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun interp2d_eval_deriv_y_e = gsl_interp2d_eval_deriv_y_e(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun interp2d_eval_deriv_xx = gsl_interp2d_eval_deriv_xx(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun interp2d_eval_deriv_xx_e = gsl_interp2d_eval_deriv_xx_e(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun interp2d_eval_deriv_yy = gsl_interp2d_eval_deriv_yy(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun interp2d_eval_deriv_yy_e = gsl_interp2d_eval_deriv_yy_e(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun interp2d_eval_deriv_xy = gsl_interp2d_eval_deriv_xy(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun interp2d_eval_deriv_xy_e = gsl_interp2d_eval_deriv_xy_e(interp : Interp2d*, xarr : LibC::Double*, yarr : LibC::Double*, zarr : LibC::Double*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun linalg_matmult = gsl_linalg_matmult(a : Matrix*, b : Matrix*, c : Matrix*) : LibC::Int
  fun linalg_matmult_mod = gsl_linalg_matmult_mod(a : Matrix*, mod_a : LinalgMatrixModT, b : Matrix*, mod_b : LinalgMatrixModT, c : Matrix*) : LibC::Int
  enum LinalgMatrixModT
    GslLinalgModNone      = 0
    GslLinalgModTranspose = 1
    GslLinalgModConjugate = 2
  end
  fun linalg_exponential_ss = gsl_linalg_exponential_ss(a : Matrix*, e_a : Matrix*, mode : ModeT) : LibC::Int
  fun linalg_householder_transform = gsl_linalg_householder_transform(v : Vector*) : LibC::Double
  fun linalg_complex_householder_transform = gsl_linalg_complex_householder_transform(v : VectorComplex*) : Complex
  fun linalg_householder_hm = gsl_linalg_householder_hm(tau : LibC::Double, v : Vector*, a : Matrix*) : LibC::Int
  fun linalg_householder_mh = gsl_linalg_householder_mh(tau : LibC::Double, v : Vector*, a : Matrix*) : LibC::Int
  fun linalg_householder_hv = gsl_linalg_householder_hv(tau : LibC::Double, v : Vector*, w : Vector*) : LibC::Int
  fun linalg_householder_hm1 = gsl_linalg_householder_hm1(tau : LibC::Double, a : Matrix*) : LibC::Int
  fun linalg_complex_householder_hm = gsl_linalg_complex_householder_hm(tau : Complex, v : VectorComplex*, a : MatrixComplex*) : LibC::Int
  fun linalg_complex_householder_mh = gsl_linalg_complex_householder_mh(tau : Complex, v : VectorComplex*, a : MatrixComplex*) : LibC::Int
  fun linalg_complex_householder_hv = gsl_linalg_complex_householder_hv(tau : Complex, v : VectorComplex*, w : VectorComplex*) : LibC::Int
  fun linalg_hessenberg_decomp = gsl_linalg_hessenberg_decomp(a : Matrix*, tau : Vector*) : LibC::Int
  fun linalg_hessenberg_unpack = gsl_linalg_hessenberg_unpack(h : Matrix*, tau : Vector*, u : Matrix*) : LibC::Int
  fun linalg_hessenberg_unpack_accum = gsl_linalg_hessenberg_unpack_accum(h : Matrix*, tau : Vector*, u : Matrix*) : LibC::Int
  fun linalg_hessenberg_set_zero = gsl_linalg_hessenberg_set_zero(h : Matrix*) : LibC::Int
  fun linalg_hessenberg_submatrix = gsl_linalg_hessenberg_submatrix(m : Matrix*, a : Matrix*, top : LibC::SizeT, tau : Vector*) : LibC::Int
  fun linalg_hesstri_decomp = gsl_linalg_hesstri_decomp(a : Matrix*, b : Matrix*, u : Matrix*, v : Matrix*, work : Vector*) : LibC::Int
  fun linalg_sv_decomp = gsl_linalg_SV_decomp(a : Matrix*, v : Matrix*, s : Vector*, work : Vector*) : LibC::Int
  fun linalg_sv_decomp_mod = gsl_linalg_SV_decomp_mod(a : Matrix*, x : Matrix*, v : Matrix*, s : Vector*, work : Vector*) : LibC::Int
  fun linalg_sv_decomp_jacobi = gsl_linalg_SV_decomp_jacobi(a : Matrix*, q : Matrix*, s : Vector*) : LibC::Int
  fun linalg_sv_solve = gsl_linalg_SV_solve(u : Matrix*, q : Matrix*, s : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_sv_leverage = gsl_linalg_SV_leverage(u : Matrix*, h : Vector*) : LibC::Int
  fun linalg_lu_decomp = gsl_linalg_LU_decomp(a : Matrix*, p : Permutation*, signum : LibC::Int*) : LibC::Int
  fun linalg_lu_solve = gsl_linalg_LU_solve(lu : Matrix*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_lu_svx = gsl_linalg_LU_svx(lu : Matrix*, p : Permutation*, x : Vector*) : LibC::Int
  fun linalg_lu_refine = gsl_linalg_LU_refine(a : Matrix*, lu : Matrix*, p : Permutation*, b : Vector*, x : Vector*, work : Vector*) : LibC::Int
  fun linalg_lu_invert = gsl_linalg_LU_invert(lu : Matrix*, p : Permutation*, inverse : Matrix*) : LibC::Int
  fun linalg_lu_det = gsl_linalg_LU_det(lu : Matrix*, signum : LibC::Int) : LibC::Double
  fun linalg_lu_lndet = gsl_linalg_LU_lndet(lu : Matrix*) : LibC::Double
  fun linalg_lu_sgndet = gsl_linalg_LU_sgndet(lu : Matrix*, signum : LibC::Int) : LibC::Int
  fun linalg_complex_lu_decomp = gsl_linalg_complex_LU_decomp(a : MatrixComplex*, p : Permutation*, signum : LibC::Int*) : LibC::Int
  fun linalg_complex_lu_solve = gsl_linalg_complex_LU_solve(lu : MatrixComplex*, p : Permutation*, b : VectorComplex*, x : VectorComplex*) : LibC::Int
  fun linalg_complex_lu_svx = gsl_linalg_complex_LU_svx(lu : MatrixComplex*, p : Permutation*, x : VectorComplex*) : LibC::Int
  fun linalg_complex_lu_refine = gsl_linalg_complex_LU_refine(a : MatrixComplex*, lu : MatrixComplex*, p : Permutation*, b : VectorComplex*, x : VectorComplex*, work : VectorComplex*) : LibC::Int
  fun linalg_complex_lu_invert = gsl_linalg_complex_LU_invert(lu : MatrixComplex*, p : Permutation*, inverse : MatrixComplex*) : LibC::Int
  fun linalg_complex_lu_det = gsl_linalg_complex_LU_det(lu : MatrixComplex*, signum : LibC::Int) : Complex
  fun linalg_complex_lu_lndet = gsl_linalg_complex_LU_lndet(lu : MatrixComplex*) : LibC::Double
  fun linalg_complex_lu_sgndet = gsl_linalg_complex_LU_sgndet(lu : MatrixComplex*, signum : LibC::Int) : Complex
  fun linalg_qr_decomp = gsl_linalg_QR_decomp(a : Matrix*, tau : Vector*) : LibC::Int
  fun linalg_qr_solve = gsl_linalg_QR_solve(qr : Matrix*, tau : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_qr_svx = gsl_linalg_QR_svx(qr : Matrix*, tau : Vector*, x : Vector*) : LibC::Int
  fun linalg_qr_lssolve = gsl_linalg_QR_lssolve(qr : Matrix*, tau : Vector*, b : Vector*, x : Vector*, residual : Vector*) : LibC::Int
  fun linalg_qr_q_rsolve = gsl_linalg_QR_QRsolve(q : Matrix*, r : Matrix*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_qr_rsolve = gsl_linalg_QR_Rsolve(qr : Matrix*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_qr_rsvx = gsl_linalg_QR_Rsvx(qr : Matrix*, x : Vector*) : LibC::Int
  fun linalg_qr_update = gsl_linalg_QR_update(q : Matrix*, r : Matrix*, w : Vector*, v : Vector*) : LibC::Int
  fun linalg_qr_q_tvec = gsl_linalg_QR_QTvec(qr : Matrix*, tau : Vector*, v : Vector*) : LibC::Int
  fun linalg_qr_qvec = gsl_linalg_QR_Qvec(qr : Matrix*, tau : Vector*, v : Vector*) : LibC::Int
  fun linalg_qr_q_tmat = gsl_linalg_QR_QTmat(qr : Matrix*, tau : Vector*, a : Matrix*) : LibC::Int
  fun linalg_qr_mat_q = gsl_linalg_QR_matQ(qr : Matrix*, tau : Vector*, a : Matrix*) : LibC::Int
  fun linalg_qr_unpack = gsl_linalg_QR_unpack(qr : Matrix*, tau : Vector*, q : Matrix*, r : Matrix*) : LibC::Int
  fun linalg_r_solve = gsl_linalg_R_solve(r : Matrix*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_r_svx = gsl_linalg_R_svx(r : Matrix*, x : Vector*) : LibC::Int
  fun linalg_qrpt_decomp = gsl_linalg_QRPT_decomp(a : Matrix*, tau : Vector*, p : Permutation*, signum : LibC::Int*, norm : Vector*) : LibC::Int
  fun linalg_qrpt_decomp2 = gsl_linalg_QRPT_decomp2(a : Matrix*, q : Matrix*, r : Matrix*, tau : Vector*, p : Permutation*, signum : LibC::Int*, norm : Vector*) : LibC::Int
  fun linalg_qrpt_solve = gsl_linalg_QRPT_solve(qr : Matrix*, tau : Vector*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_qrpt_lssolve = gsl_linalg_QRPT_lssolve(qr : Matrix*, tau : Vector*, p : Permutation*, b : Vector*, x : Vector*, residual : Vector*) : LibC::Int
  fun linalg_qrpt_lssolve2 = gsl_linalg_QRPT_lssolve2(qr : Matrix*, tau : Vector*, p : Permutation*, b : Vector*, rank : LibC::SizeT, x : Vector*, residual : Vector*) : LibC::Int
  fun linalg_qrpt_svx = gsl_linalg_QRPT_svx(qr : Matrix*, tau : Vector*, p : Permutation*, x : Vector*) : LibC::Int
  fun linalg_qrpt_q_rsolve = gsl_linalg_QRPT_QRsolve(q : Matrix*, r : Matrix*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_qrpt_rsolve = gsl_linalg_QRPT_Rsolve(qr : Matrix*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_qrpt_rsvx = gsl_linalg_QRPT_Rsvx(qr : Matrix*, p : Permutation*, x : Vector*) : LibC::Int
  fun linalg_qrpt_update = gsl_linalg_QRPT_update(q : Matrix*, r : Matrix*, p : Permutation*, u : Vector*, v : Vector*) : LibC::Int
  fun linalg_qrpt_rank = gsl_linalg_QRPT_rank(qr : Matrix*, tol : LibC::Double) : LibC::SizeT
  fun linalg_qrpt_rcond = gsl_linalg_QRPT_rcond(qr : Matrix*, rcond : LibC::Double*, work : Vector*) : LibC::Int
  fun linalg_cod_decomp = gsl_linalg_COD_decomp(a : Matrix*, tau_q : Vector*, tau_z : Vector*, p : Permutation*, rank : LibC::SizeT*, work : Vector*) : LibC::Int
  fun linalg_cod_decomp_e = gsl_linalg_COD_decomp_e(a : Matrix*, tau_q : Vector*, tau_z : Vector*, p : Permutation*, tol : LibC::Double, rank : LibC::SizeT*, work : Vector*) : LibC::Int
  fun linalg_cod_lssolve = gsl_linalg_COD_lssolve(qrzt : Matrix*, tau_q : Vector*, tau_z : Vector*, perm : Permutation*, rank : LibC::SizeT, b : Vector*, x : Vector*, residual : Vector*) : LibC::Int
  fun linalg_cod_lssolve2 = gsl_linalg_COD_lssolve2(lambda : LibC::Double, qrzt : Matrix*, tau_q : Vector*, tau_z : Vector*, perm : Permutation*, rank : LibC::SizeT, b : Vector*, x : Vector*, residual : Vector*, s : Matrix*, work : Vector*) : LibC::Int
  fun linalg_cod_unpack = gsl_linalg_COD_unpack(qrzt : Matrix*, tau_q : Vector*, tau_z : Vector*, rank : LibC::SizeT, q : Matrix*, r : Matrix*, z : Matrix*) : LibC::Int
  fun linalg_cod_mat_z = gsl_linalg_COD_matZ(qrzt : Matrix*, tau_z : Vector*, rank : LibC::SizeT, a : Matrix*, work : Vector*) : LibC::Int
  fun linalg_lq_decomp = gsl_linalg_LQ_decomp(a : Matrix*, tau : Vector*) : LibC::Int
  fun linalg_lq_solve_t = gsl_linalg_LQ_solve_T(lq : Matrix*, tau : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_lq_svx_t = gsl_linalg_LQ_svx_T(lq : Matrix*, tau : Vector*, x : Vector*) : LibC::Int
  fun linalg_lq_lssolve_t = gsl_linalg_LQ_lssolve_T(lq : Matrix*, tau : Vector*, b : Vector*, x : Vector*, residual : Vector*) : LibC::Int
  fun linalg_lq_lsolve_t = gsl_linalg_LQ_Lsolve_T(lq : Matrix*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_lq_lsvx_t = gsl_linalg_LQ_Lsvx_T(lq : Matrix*, x : Vector*) : LibC::Int
  fun linalg_l_solve_t = gsl_linalg_L_solve_T(l : Matrix*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_lq_vec_q = gsl_linalg_LQ_vecQ(lq : Matrix*, tau : Vector*, v : Vector*) : LibC::Int
  fun linalg_lq_vec_qt = gsl_linalg_LQ_vecQT(lq : Matrix*, tau : Vector*, v : Vector*) : LibC::Int
  fun linalg_lq_unpack = gsl_linalg_LQ_unpack(lq : Matrix*, tau : Vector*, q : Matrix*, l : Matrix*) : LibC::Int
  fun linalg_lq_update = gsl_linalg_LQ_update(q : Matrix*, r : Matrix*, v : Vector*, w : Vector*) : LibC::Int
  fun linalg_lq_l_qsolve = gsl_linalg_LQ_LQsolve(q : Matrix*, l : Matrix*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_ptlq_decomp = gsl_linalg_PTLQ_decomp(a : Matrix*, tau : Vector*, p : Permutation*, signum : LibC::Int*, norm : Vector*) : LibC::Int
  fun linalg_ptlq_decomp2 = gsl_linalg_PTLQ_decomp2(a : Matrix*, q : Matrix*, r : Matrix*, tau : Vector*, p : Permutation*, signum : LibC::Int*, norm : Vector*) : LibC::Int
  fun linalg_ptlq_solve_t = gsl_linalg_PTLQ_solve_T(qr : Matrix*, tau : Vector*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_ptlq_svx_t = gsl_linalg_PTLQ_svx_T(lq : Matrix*, tau : Vector*, p : Permutation*, x : Vector*) : LibC::Int
  fun linalg_ptlq_l_qsolve_t = gsl_linalg_PTLQ_LQsolve_T(q : Matrix*, l : Matrix*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_ptlq_lsolve_t = gsl_linalg_PTLQ_Lsolve_T(lq : Matrix*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_ptlq_lsvx_t = gsl_linalg_PTLQ_Lsvx_T(lq : Matrix*, p : Permutation*, x : Vector*) : LibC::Int
  fun linalg_ptlq_update = gsl_linalg_PTLQ_update(q : Matrix*, l : Matrix*, p : Permutation*, v : Vector*, w : Vector*) : LibC::Int
  fun linalg_cholesky_decomp = gsl_linalg_cholesky_decomp(a : Matrix*) : LibC::Int
  fun linalg_cholesky_decomp1 = gsl_linalg_cholesky_decomp1(a : Matrix*) : LibC::Int
  fun linalg_cholesky_solve = gsl_linalg_cholesky_solve(cholesky : Matrix*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_cholesky_svx = gsl_linalg_cholesky_svx(cholesky : Matrix*, x : Vector*) : LibC::Int
  fun linalg_cholesky_invert = gsl_linalg_cholesky_invert(cholesky : Matrix*) : LibC::Int
  fun linalg_cholesky_decomp_unit = gsl_linalg_cholesky_decomp_unit(a : Matrix*, d : Vector*) : LibC::Int
  fun linalg_cholesky_scale = gsl_linalg_cholesky_scale(a : Matrix*, s : Vector*) : LibC::Int
  fun linalg_cholesky_scale_apply = gsl_linalg_cholesky_scale_apply(a : Matrix*, s : Vector*) : LibC::Int
  fun linalg_cholesky_decomp2 = gsl_linalg_cholesky_decomp2(a : Matrix*, s : Vector*) : LibC::Int
  fun linalg_cholesky_svx2 = gsl_linalg_cholesky_svx2(llt : Matrix*, s : Vector*, x : Vector*) : LibC::Int
  fun linalg_cholesky_solve2 = gsl_linalg_cholesky_solve2(llt : Matrix*, s : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_cholesky_rcond = gsl_linalg_cholesky_rcond(llt : Matrix*, rcond : LibC::Double*, work : Vector*) : LibC::Int
  fun linalg_complex_cholesky_decomp = gsl_linalg_complex_cholesky_decomp(a : MatrixComplex*) : LibC::Int
  fun linalg_complex_cholesky_solve = gsl_linalg_complex_cholesky_solve(cholesky : MatrixComplex*, b : VectorComplex*, x : VectorComplex*) : LibC::Int
  fun linalg_complex_cholesky_svx = gsl_linalg_complex_cholesky_svx(cholesky : MatrixComplex*, x : VectorComplex*) : LibC::Int
  fun linalg_complex_cholesky_invert = gsl_linalg_complex_cholesky_invert(cholesky : MatrixComplex*) : LibC::Int
  fun linalg_pcholesky_decomp = gsl_linalg_pcholesky_decomp(a : Matrix*, p : Permutation*) : LibC::Int
  fun linalg_pcholesky_solve = gsl_linalg_pcholesky_solve(ldlt : Matrix*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_pcholesky_svx = gsl_linalg_pcholesky_svx(ldlt : Matrix*, p : Permutation*, x : Vector*) : LibC::Int
  fun linalg_pcholesky_decomp2 = gsl_linalg_pcholesky_decomp2(a : Matrix*, p : Permutation*, s : Vector*) : LibC::Int
  fun linalg_pcholesky_solve2 = gsl_linalg_pcholesky_solve2(ldlt : Matrix*, p : Permutation*, s : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_pcholesky_svx2 = gsl_linalg_pcholesky_svx2(ldlt : Matrix*, p : Permutation*, s : Vector*, x : Vector*) : LibC::Int
  fun linalg_pcholesky_invert = gsl_linalg_pcholesky_invert(ldlt : Matrix*, p : Permutation*, ainv : Matrix*) : LibC::Int
  fun linalg_pcholesky_rcond = gsl_linalg_pcholesky_rcond(ldlt : Matrix*, p : Permutation*, rcond : LibC::Double*, work : Vector*) : LibC::Int
  fun linalg_mcholesky_decomp = gsl_linalg_mcholesky_decomp(a : Matrix*, p : Permutation*, e : Vector*) : LibC::Int
  fun linalg_mcholesky_solve = gsl_linalg_mcholesky_solve(ldlt : Matrix*, p : Permutation*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_mcholesky_svx = gsl_linalg_mcholesky_svx(ldlt : Matrix*, p : Permutation*, x : Vector*) : LibC::Int
  fun linalg_mcholesky_rcond = gsl_linalg_mcholesky_rcond(ldlt : Matrix*, p : Permutation*, rcond : LibC::Double*, work : Vector*) : LibC::Int
  fun linalg_mcholesky_invert = gsl_linalg_mcholesky_invert(ldlt : Matrix*, p : Permutation*, ainv : Matrix*) : LibC::Int
  fun linalg_symmtd_decomp = gsl_linalg_symmtd_decomp(a : Matrix*, tau : Vector*) : LibC::Int
  fun linalg_symmtd_unpack = gsl_linalg_symmtd_unpack(a : Matrix*, tau : Vector*, q : Matrix*, diag : Vector*, subdiag : Vector*) : LibC::Int
  fun linalg_symmtd_unpack_t = gsl_linalg_symmtd_unpack_T(a : Matrix*, diag : Vector*, subdiag : Vector*) : LibC::Int
  fun linalg_hermtd_decomp = gsl_linalg_hermtd_decomp(a : MatrixComplex*, tau : VectorComplex*) : LibC::Int
  fun linalg_hermtd_unpack = gsl_linalg_hermtd_unpack(a : MatrixComplex*, tau : VectorComplex*, u : MatrixComplex*, diag : Vector*, sudiag : Vector*) : LibC::Int
  fun linalg_hermtd_unpack_t = gsl_linalg_hermtd_unpack_T(a : MatrixComplex*, diag : Vector*, subdiag : Vector*) : LibC::Int
  fun linalg_hh_solve = gsl_linalg_HH_solve(a : Matrix*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_hh_svx = gsl_linalg_HH_svx(a : Matrix*, x : Vector*) : LibC::Int
  fun linalg_solve_symm_tridiag = gsl_linalg_solve_symm_tridiag(diag : Vector*, offdiag : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_solve_tridiag = gsl_linalg_solve_tridiag(diag : Vector*, abovediag : Vector*, belowdiag : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_solve_symm_cyc_tridiag = gsl_linalg_solve_symm_cyc_tridiag(diag : Vector*, offdiag : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_solve_cyc_tridiag = gsl_linalg_solve_cyc_tridiag(diag : Vector*, abovediag : Vector*, belowdiag : Vector*, b : Vector*, x : Vector*) : LibC::Int
  fun linalg_bidiag_decomp = gsl_linalg_bidiag_decomp(a : Matrix*, tau_u : Vector*, tau_v : Vector*) : LibC::Int
  fun linalg_bidiag_unpack = gsl_linalg_bidiag_unpack(a : Matrix*, tau_u : Vector*, u : Matrix*, tau_v : Vector*, v : Matrix*, diag : Vector*, superdiag : Vector*) : LibC::Int
  fun linalg_bidiag_unpack2 = gsl_linalg_bidiag_unpack2(a : Matrix*, tau_u : Vector*, tau_v : Vector*, v : Matrix*) : LibC::Int
  fun linalg_bidiag_unpack_b = gsl_linalg_bidiag_unpack_B(a : Matrix*, diag : Vector*, superdiag : Vector*) : LibC::Int
  fun linalg_balance_matrix = gsl_linalg_balance_matrix(a : Matrix*, d : Vector*) : LibC::Int
  fun linalg_balance_accum = gsl_linalg_balance_accum(a : Matrix*, d : Vector*) : LibC::Int
  fun linalg_balance_columns = gsl_linalg_balance_columns(a : Matrix*, d : Vector*) : LibC::Int
  fun linalg_tri_upper_rcond = gsl_linalg_tri_upper_rcond(a : Matrix*, rcond : LibC::Double*, work : Vector*) : LibC::Int
  fun linalg_tri_lower_rcond = gsl_linalg_tri_lower_rcond(a : Matrix*, rcond : LibC::Double*, work : Vector*) : LibC::Int
  fun linalg_invnorm1 = gsl_linalg_invnorm1(n : LibC::SizeT, ainvx : (CblasTransposeT, Vector*, Void* -> LibC::Int), params : Void*, ainvnorm : LibC::Double*, work : Vector*) : LibC::Int
  fun linalg_tri_upper_invert = gsl_linalg_tri_upper_invert(t : Matrix*) : LibC::Int
  fun linalg_tri_lower_invert = gsl_linalg_tri_lower_invert(t : Matrix*) : LibC::Int
  fun linalg_tri_upper_unit_invert = gsl_linalg_tri_upper_unit_invert(t : Matrix*) : LibC::Int
  fun linalg_tri_lower_unit_invert = gsl_linalg_tri_lower_unit_invert(t : Matrix*) : LibC::Int
  fun linalg_givens = gsl_linalg_givens(a : LibC::Double, b : LibC::Double, c : LibC::Double*, s : LibC::Double*)
  fun linalg_givens_gv = gsl_linalg_givens_gv(v : Vector*, i : LibC::SizeT, j : LibC::SizeT, c : LibC::Double, s : LibC::Double)
  fun message = gsl_message(message : LibC::Char*, file : LibC::Char*, line : LibC::Int, mask : LibC::UInt)
  fun min_fminimizer_alloc = gsl_min_fminimizer_alloc(t : MinFminimizerType*) : MinFminimizer*

  struct MinFminimizerType
    name : LibC::Char*
    size : LibC::SizeT
    set : (Void*, Function*, LibC::Double, LibC::Double, LibC::Double, LibC::Double, LibC::Double, LibC::Double -> LibC::Int)
    iterate : (Void*, Function*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::Double*, LibC::Double* -> LibC::Int)
  end

  struct MinFminimizer
    type : MinFminimizerType*
    function : Function*
    x_minimum : LibC::Double
    x_lower : LibC::Double
    x_upper : LibC::Double
    f_minimum : LibC::Double
    f_lower : LibC::Double
    f_upper : LibC::Double
    state : Void*
  end

  fun min_fminimizer_free = gsl_min_fminimizer_free(s : MinFminimizer*)
  fun min_fminimizer_set = gsl_min_fminimizer_set(s : MinFminimizer*, f : Function*, x_minimum : LibC::Double, x_lower : LibC::Double, x_upper : LibC::Double) : LibC::Int
  fun min_fminimizer_set_with_values = gsl_min_fminimizer_set_with_values(s : MinFminimizer*, f : Function*, x_minimum : LibC::Double, f_minimum : LibC::Double, x_lower : LibC::Double, f_lower : LibC::Double, x_upper : LibC::Double, f_upper : LibC::Double) : LibC::Int
  fun min_fminimizer_iterate = gsl_min_fminimizer_iterate(s : MinFminimizer*) : LibC::Int
  fun min_fminimizer_name = gsl_min_fminimizer_name(s : MinFminimizer*) : LibC::Char*
  fun min_fminimizer_x_minimum = gsl_min_fminimizer_x_minimum(s : MinFminimizer*) : LibC::Double
  fun min_fminimizer_x_lower = gsl_min_fminimizer_x_lower(s : MinFminimizer*) : LibC::Double
  fun min_fminimizer_x_upper = gsl_min_fminimizer_x_upper(s : MinFminimizer*) : LibC::Double
  fun min_fminimizer_f_minimum = gsl_min_fminimizer_f_minimum(s : MinFminimizer*) : LibC::Double
  fun min_fminimizer_f_lower = gsl_min_fminimizer_f_lower(s : MinFminimizer*) : LibC::Double
  fun min_fminimizer_f_upper = gsl_min_fminimizer_f_upper(s : MinFminimizer*) : LibC::Double
  fun min_fminimizer_minimum = gsl_min_fminimizer_minimum(s : MinFminimizer*) : LibC::Double
  fun min_test_interval = gsl_min_test_interval(x_lower : LibC::Double, x_upper : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double) : LibC::Int
  fun min_find_bracket = gsl_min_find_bracket(f : Function*, x_minimum : LibC::Double*, f_minimum : LibC::Double*, x_lower : LibC::Double*, f_lower : LibC::Double*, x_upper : LibC::Double*, f_upper : LibC::Double*, eval_max : LibC::SizeT) : LibC::Int

  struct MonteFunctionStruct
    f : (LibC::Double*, LibC::SizeT, Void* -> LibC::Double)
    dim : LibC::SizeT
    params : Void*
  end

  struct RngType
    name : LibC::Char*
    max : LibC::ULong
    min : LibC::ULong
    size : LibC::SizeT
    set : (Void*, LibC::ULong -> Void)
    get : (Void* -> LibC::ULong)
    get_double : (Void* -> LibC::Double)
  end

  fun rng_types_setup = gsl_rng_types_setup : RngType**
  fun rng_alloc = gsl_rng_alloc(t : RngType*) : Rng*

  struct Rng
    type : RngType*
    state : Void*
  end

  fun rng_memcpy = gsl_rng_memcpy(dest : Rng*, src : Rng*) : LibC::Int
  fun rng_clone = gsl_rng_clone(r : Rng*) : Rng*
  fun rng_free = gsl_rng_free(r : Rng*)
  fun rng_set = gsl_rng_set(r : Rng*, seed : LibC::ULong)
  fun rng_max = gsl_rng_max(r : Rng*) : LibC::ULong
  fun rng_min = gsl_rng_min(r : Rng*) : LibC::ULong
  fun rng_name = gsl_rng_name(r : Rng*) : LibC::Char*
  fun rng_fread = gsl_rng_fread(stream : File*, r : Rng*) : LibC::Int
  fun rng_fwrite = gsl_rng_fwrite(stream : File*, r : Rng*) : LibC::Int
  fun rng_size = gsl_rng_size(r : Rng*) : LibC::SizeT
  fun rng_state = gsl_rng_state(r : Rng*) : Void*
  fun rng_print_state = gsl_rng_print_state(r : Rng*)
  fun rng_env_setup = gsl_rng_env_setup : RngType*
  fun rng_get = gsl_rng_get(r : Rng*) : LibC::ULong
  fun rng_uniform = gsl_rng_uniform(r : Rng*) : LibC::Double
  fun rng_uniform_pos = gsl_rng_uniform_pos(r : Rng*) : LibC::Double
  fun rng_uniform_int = gsl_rng_uniform_int(r : Rng*, n : LibC::ULong) : LibC::ULong
  fun monte_plain_integrate = gsl_monte_plain_integrate(f : MonteFunction*, xl : LibC::Double*, xu : LibC::Double*, dim : LibC::SizeT, calls : LibC::SizeT, r : Rng*, state : MontePlainState*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  type MonteFunction = MonteFunctionStruct

  struct MontePlainState
    dim : LibC::SizeT
    x : LibC::Double*
  end

  fun monte_plain_alloc = gsl_monte_plain_alloc(dim : LibC::SizeT) : MontePlainState*
  fun monte_plain_init = gsl_monte_plain_init(state : MontePlainState*) : LibC::Int
  fun monte_plain_free = gsl_monte_plain_free(state : MontePlainState*)
  fun monte_miser_integrate = gsl_monte_miser_integrate(f : MonteFunction*, xl : LibC::Double*, xh : LibC::Double*, dim : LibC::SizeT, calls : LibC::SizeT, r : Rng*, state : MonteMiserState*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int

  struct MonteMiserState
    min_calls : LibC::SizeT
    min_calls_per_bisection : LibC::SizeT
    dither : LibC::Double
    estimate_frac : LibC::Double
    alpha : LibC::Double
    dim : LibC::SizeT
    estimate_style : LibC::Int
    depth : LibC::Int
    verbose : LibC::Int
    x : LibC::Double*
    xmid : LibC::Double*
    sigma_l : LibC::Double*
    sigma_r : LibC::Double*
    fmax_l : LibC::Double*
    fmax_r : LibC::Double*
    fmin_l : LibC::Double*
    fmin_r : LibC::Double*
    fsum_l : LibC::Double*
    fsum_r : LibC::Double*
    fsum2_l : LibC::Double*
    fsum2_r : LibC::Double*
    hits_l : LibC::SizeT*
    hits_r : LibC::SizeT*
  end

  fun monte_miser_alloc = gsl_monte_miser_alloc(dim : LibC::SizeT) : MonteMiserState*
  fun monte_miser_init = gsl_monte_miser_init(state : MonteMiserState*) : LibC::Int
  fun monte_miser_free = gsl_monte_miser_free(state : MonteMiserState*)
  fun monte_miser_params_get = gsl_monte_miser_params_get(state : MonteMiserState*, params : MonteMiserParams*)

  struct MonteMiserParams
    estimate_frac : LibC::Double
    min_calls : LibC::SizeT
    min_calls_per_bisection : LibC::SizeT
    alpha : LibC::Double
    dither : LibC::Double
  end

  fun monte_miser_params_set = gsl_monte_miser_params_set(state : MonteMiserState*, params : MonteMiserParams*)
  fun monte_vegas_integrate = gsl_monte_vegas_integrate(f : MonteFunction*, xl : LibC::Double*, xu : LibC::Double*, dim : LibC::SizeT, calls : LibC::SizeT, r : Rng*, state : MonteVegasState*, result : LibC::Double*, abserr : LibC::Double*) : LibC::Int

  struct MonteVegasState
    dim : LibC::SizeT
    bins_max : LibC::SizeT
    bins : LibC::UInt
    boxes : LibC::UInt
    xi : LibC::Double*
    xin : LibC::Double*
    delx : LibC::Double*
    weight : LibC::Double*
    vol : LibC::Double
    x : LibC::Double*
    bin : LibC::Int*
    box : LibC::Int*
    d : LibC::Double*
    alpha : LibC::Double
    mode : LibC::Int
    verbose : LibC::Int
    iterations : LibC::UInt
    stage : LibC::Int
    jac : LibC::Double
    wtd_int_sum : LibC::Double
    sum_wgts : LibC::Double
    chi_sum : LibC::Double
    chisq : LibC::Double
    result : LibC::Double
    sigma : LibC::Double
    it_start : LibC::UInt
    it_num : LibC::UInt
    samples : LibC::UInt
    calls_per_box : LibC::UInt
    ostream : File*
  end

  fun monte_vegas_alloc = gsl_monte_vegas_alloc(dim : LibC::SizeT) : MonteVegasState*
  fun monte_vegas_init = gsl_monte_vegas_init(state : MonteVegasState*) : LibC::Int
  fun monte_vegas_free = gsl_monte_vegas_free(state : MonteVegasState*)
  fun monte_vegas_chisq = gsl_monte_vegas_chisq(state : MonteVegasState*) : LibC::Double
  fun monte_vegas_runval = gsl_monte_vegas_runval(state : MonteVegasState*, result : LibC::Double*, sigma : LibC::Double*)
  fun monte_vegas_params_get = gsl_monte_vegas_params_get(state : MonteVegasState*, params : MonteVegasParams*)

  struct MonteVegasParams
    alpha : LibC::Double
    iterations : LibC::SizeT
    stage : LibC::Int
    mode : LibC::Int
    verbose : LibC::Int
    ostream : File*
  end

  fun monte_vegas_params_set = gsl_monte_vegas_params_set(state : MonteVegasState*, params : MonteVegasParams*)
  fun multifit_linear_alloc = gsl_multifit_linear_alloc(n : LibC::SizeT, p : LibC::SizeT) : MultifitLinearWorkspace*

  struct MultifitLinearWorkspace
    nmax : LibC::SizeT
    pmax : LibC::SizeT
    n : LibC::SizeT
    p : LibC::SizeT
    a : Matrix*
    q : Matrix*
    qsi : Matrix*
    s : Vector*
    t : Vector*
    xt : Vector*
    d : Vector*
    rcond : LibC::Double
  end

  fun multifit_linear_free = gsl_multifit_linear_free(w : MultifitLinearWorkspace*)
  fun multifit_linear = gsl_multifit_linear(x : Matrix*, y : Vector*, c : Vector*, cov : Matrix*, chisq : LibC::Double*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_tsvd = gsl_multifit_linear_tsvd(x : Matrix*, y : Vector*, tol : LibC::Double, c : Vector*, cov : Matrix*, chisq : LibC::Double*, rank : LibC::SizeT*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_svd = gsl_multifit_linear_svd(x : Matrix*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_bsvd = gsl_multifit_linear_bsvd(x : Matrix*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_rank = gsl_multifit_linear_rank(tol : LibC::Double, work : MultifitLinearWorkspace*) : LibC::SizeT
  fun multifit_linear_solve = gsl_multifit_linear_solve(lambda : LibC::Double, x : Matrix*, y : Vector*, c : Vector*, rnorm : LibC::Double*, snorm : LibC::Double*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_apply_w = gsl_multifit_linear_applyW(x : Matrix*, w : Vector*, y : Vector*, wx : Matrix*, wy : Vector*) : LibC::Int
  fun multifit_linear_stdform1 = gsl_multifit_linear_stdform1(l : Vector*, x : Matrix*, y : Vector*, xs : Matrix*, ys : Vector*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_wstdform1 = gsl_multifit_linear_wstdform1(l : Vector*, x : Matrix*, w : Vector*, y : Vector*, xs : Matrix*, ys : Vector*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_l_decomp = gsl_multifit_linear_L_decomp(l : Matrix*, tau : Vector*) : LibC::Int
  fun multifit_linear_stdform2 = gsl_multifit_linear_stdform2(lqr : Matrix*, ltau : Vector*, x : Matrix*, y : Vector*, xs : Matrix*, ys : Vector*, m : Matrix*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_wstdform2 = gsl_multifit_linear_wstdform2(lqr : Matrix*, ltau : Vector*, x : Matrix*, w : Vector*, y : Vector*, xs : Matrix*, ys : Vector*, m : Matrix*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_genform1 = gsl_multifit_linear_genform1(l : Vector*, cs : Vector*, c : Vector*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_genform2 = gsl_multifit_linear_genform2(lqr : Matrix*, ltau : Vector*, x : Matrix*, y : Vector*, cs : Vector*, m : Matrix*, c : Vector*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_wgenform2 = gsl_multifit_linear_wgenform2(lqr : Matrix*, ltau : Vector*, x : Matrix*, w : Vector*, y : Vector*, cs : Vector*, m : Matrix*, c : Vector*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_lreg = gsl_multifit_linear_lreg(smin : LibC::Double, smax : LibC::Double, reg_param : Vector*) : LibC::Int
  fun multifit_linear_lcurve = gsl_multifit_linear_lcurve(y : Vector*, reg_param : Vector*, rho : Vector*, eta : Vector*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_lcorner = gsl_multifit_linear_lcorner(rho : Vector*, eta : Vector*, idx : LibC::SizeT*) : LibC::Int
  fun multifit_linear_lcorner2 = gsl_multifit_linear_lcorner2(reg_param : Vector*, eta : Vector*, idx : LibC::SizeT*) : LibC::Int
  fun multifit_linear_lk = gsl_multifit_linear_Lk(p : LibC::SizeT, k : LibC::SizeT, l : Matrix*) : LibC::Int
  fun multifit_linear_lsobolev = gsl_multifit_linear_Lsobolev(p : LibC::SizeT, kmax : LibC::SizeT, alpha : Vector*, l : Matrix*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_wlinear = gsl_multifit_wlinear(x : Matrix*, w : Vector*, y : Vector*, c : Vector*, cov : Matrix*, chisq : LibC::Double*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_wlinear_tsvd = gsl_multifit_wlinear_tsvd(x : Matrix*, w : Vector*, y : Vector*, tol : LibC::Double, c : Vector*, cov : Matrix*, chisq : LibC::Double*, rank : LibC::SizeT*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_wlinear_svd = gsl_multifit_wlinear_svd(x : Matrix*, w : Vector*, y : Vector*, tol : LibC::Double, rank : LibC::SizeT*, c : Vector*, cov : Matrix*, chisq : LibC::Double*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_wlinear_usvd = gsl_multifit_wlinear_usvd(x : Matrix*, w : Vector*, y : Vector*, tol : LibC::Double, rank : LibC::SizeT*, c : Vector*, cov : Matrix*, chisq : LibC::Double*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_est = gsl_multifit_linear_est(x : Vector*, c : Vector*, cov : Matrix*, y : LibC::Double*, y_err : LibC::Double*) : LibC::Int
  fun multifit_linear_rcond = gsl_multifit_linear_rcond(w : MultifitLinearWorkspace*) : LibC::Double
  fun multifit_linear_residuals = gsl_multifit_linear_residuals(x : Matrix*, y : Vector*, c : Vector*, r : Vector*) : LibC::Int
  fun multifit_linear_gcv_init = gsl_multifit_linear_gcv_init(y : Vector*, reg_param : Vector*, u_ty : Vector*, delta0 : LibC::Double*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_gcv_curve = gsl_multifit_linear_gcv_curve(reg_param : Vector*, u_ty : Vector*, delta0 : LibC::Double, g : Vector*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_gcv_min = gsl_multifit_linear_gcv_min(reg_param : Vector*, u_ty : Vector*, g : Vector*, delta0 : LibC::Double, lambda : LibC::Double*, work : MultifitLinearWorkspace*) : LibC::Int
  fun multifit_linear_gcv_calc = gsl_multifit_linear_gcv_calc(lambda : LibC::Double, u_ty : Vector*, delta0 : LibC::Double, work : MultifitLinearWorkspace*) : LibC::Double
  fun multifit_linear_gcv = gsl_multifit_linear_gcv(y : Vector*, reg_param : Vector*, g : Vector*, lambda : LibC::Double*, g_lambda : LibC::Double*, work : MultifitLinearWorkspace*) : LibC::Int

  struct MultifitRobustType
    name : LibC::Char*
    wfun : (Vector*, Vector* -> LibC::Int)
    psi_deriv : (Vector*, Vector* -> LibC::Int)
    tuning_default : LibC::Double
  end

  fun multifit_robust_alloc = gsl_multifit_robust_alloc(t : MultifitRobustType*, n : LibC::SizeT, p : LibC::SizeT) : MultifitRobustWorkspace*

  struct MultifitRobustWorkspace
    n : LibC::SizeT
    p : LibC::SizeT
    numit : LibC::SizeT
    maxiter : LibC::SizeT
    type : MultifitRobustType*
    tune : LibC::Double
    r : Vector*
    weights : Vector*
    c_prev : Vector*
    resfac : Vector*
    psi : Vector*
    dpsi : Vector*
    qsi : Matrix*
    d : Vector*
    workn : Vector*
    stats : MultifitRobustStats
    multifit_p : MultifitLinearWorkspace*
  end

  struct MultifitRobustStats
    sigma_ols : LibC::Double
    sigma_mad : LibC::Double
    sigma_rob : LibC::Double
    sigma : LibC::Double
    rsq : LibC::Double
    adj_rsq : LibC::Double
    rmse : LibC::Double
    sse : LibC::Double
    dof : LibC::SizeT
    numit : LibC::SizeT
    weights : Vector*
    r : Vector*
  end

  fun multifit_robust_free = gsl_multifit_robust_free(w : MultifitRobustWorkspace*)
  fun multifit_robust_tune = gsl_multifit_robust_tune(tune : LibC::Double, w : MultifitRobustWorkspace*) : LibC::Int
  fun multifit_robust_maxiter = gsl_multifit_robust_maxiter(maxiter : LibC::SizeT, w : MultifitRobustWorkspace*) : LibC::Int
  fun multifit_robust_name = gsl_multifit_robust_name(w : MultifitRobustWorkspace*) : LibC::Char*
  fun multifit_robust_statistics = gsl_multifit_robust_statistics(w : MultifitRobustWorkspace*) : MultifitRobustStats
  fun multifit_robust_weights = gsl_multifit_robust_weights(r : Vector*, wts : Vector*, w : MultifitRobustWorkspace*) : LibC::Int
  fun multifit_robust = gsl_multifit_robust(x : Matrix*, y : Vector*, c : Vector*, cov : Matrix*, w : MultifitRobustWorkspace*) : LibC::Int
  fun multifit_robust_est = gsl_multifit_robust_est(x : Vector*, c : Vector*, cov : Matrix*, y : LibC::Double*, y_err : LibC::Double*) : LibC::Int
  fun multifit_robust_residuals = gsl_multifit_robust_residuals(x : Matrix*, y : Vector*, c : Vector*, r : Vector*, w : MultifitRobustWorkspace*) : LibC::Int
  fun multifit_nlinear_alloc = gsl_multifit_nlinear_alloc(t : MultifitNlinearType*, params : MultifitNlinearParameters*, n : LibC::SizeT, p : LibC::SizeT) : MultifitNlinearWorkspace*

  struct MultifitNlinearType
    name : LibC::Char*
    alloc : (MultifitNlinearParameters*, LibC::SizeT, LibC::SizeT -> Void*)
    init : (Void*, Vector*, MultifitNlinearFdf*, Vector*, Vector*, Matrix*, Vector* -> LibC::Int)
    iterate : (Void*, Vector*, MultifitNlinearFdf*, Vector*, Vector*, Matrix*, Vector*, Vector* -> LibC::Int)
    rcond : (LibC::Double*, Void* -> LibC::Int)
    avratio : (Void* -> LibC::Double)
    free : (Void* -> Void)
  end

  struct MultifitNlinearParameters
    trs : MultifitNlinearTrs*
    scale : MultifitNlinearScale*
    solver : MultifitNlinearSolver*
    fdtype : MultifitNlinearFdtype
    factor_up : LibC::Double
    factor_down : LibC::Double
    avmax : LibC::Double
    h_df : LibC::Double
    h_fvv : LibC::Double
  end

  struct MultifitNlinearTrs
    name : LibC::Char*
    alloc : (Void*, LibC::SizeT, LibC::SizeT -> Void*)
    init : (Void*, Void* -> LibC::Int)
    preloop : (Void*, Void* -> LibC::Int)
    step : (Void*, LibC::Double, Vector*, Void* -> LibC::Int)
    preduction : (Void*, Vector*, LibC::Double*, Void* -> LibC::Int)
    free : (Void* -> Void)
  end

  struct MultifitNlinearScale
    name : LibC::Char*
    init : (Matrix*, Vector* -> LibC::Int)
    update : (Matrix*, Vector* -> LibC::Int)
  end

  struct MultifitNlinearSolver
    name : LibC::Char*
    alloc : (LibC::SizeT, LibC::SizeT -> Void*)
    init : (Void*, Void* -> LibC::Int)
    presolve : (LibC::Double, Void*, Void* -> LibC::Int)
    solve : (Vector*, Vector*, Void*, Void* -> LibC::Int)
    rcond : (LibC::Double*, Void* -> LibC::Int)
    free : (Void* -> Void)
  end

  enum MultifitNlinearFdtype
    GslMultifitNlinearFwdiff  = 0
    GslMultifitNlinearCtrdiff = 1
  end

  struct MultifitNlinearFdf
    f : (Vector*, Void*, Vector* -> LibC::Int)
    df : (Vector*, Void*, Matrix* -> LibC::Int)
    fvv : (Vector*, Vector*, Void*, Vector* -> LibC::Int)
    n : LibC::SizeT
    p : LibC::SizeT
    params : Void*
    nevalf : LibC::SizeT
    nevaldf : LibC::SizeT
    nevalfvv : LibC::SizeT
  end

  struct MultifitNlinearWorkspace
    type : MultifitNlinearType*
    fdf : MultifitNlinearFdf*
    x : Vector*
    f : Vector*
    dx : Vector*
    g : Vector*
    j : Matrix*
    sqrt_wts_work : Vector*
    sqrt_wts : Vector*
    niter : LibC::SizeT
    params : MultifitNlinearParameters
    state : Void*
  end

  fun multifit_nlinear_free = gsl_multifit_nlinear_free(w : MultifitNlinearWorkspace*)
  fun multifit_nlinear_default_parameters = gsl_multifit_nlinear_default_parameters : MultifitNlinearParameters
  fun multifit_nlinear_init = gsl_multifit_nlinear_init(x : Vector*, fdf : MultifitNlinearFdf*, w : MultifitNlinearWorkspace*) : LibC::Int
  fun multifit_nlinear_winit = gsl_multifit_nlinear_winit(x : Vector*, wts : Vector*, fdf : MultifitNlinearFdf*, w : MultifitNlinearWorkspace*) : LibC::Int
  fun multifit_nlinear_iterate = gsl_multifit_nlinear_iterate(w : MultifitNlinearWorkspace*) : LibC::Int
  fun multifit_nlinear_avratio = gsl_multifit_nlinear_avratio(w : MultifitNlinearWorkspace*) : LibC::Double
  fun multifit_nlinear_driver = gsl_multifit_nlinear_driver(maxiter : LibC::SizeT, xtol : LibC::Double, gtol : LibC::Double, ftol : LibC::Double, callback : (LibC::SizeT, Void*, MultifitNlinearWorkspace* -> Void), callback_params : Void*, info : LibC::Int*, w : MultifitNlinearWorkspace*) : LibC::Int
  fun multifit_nlinear_jac = gsl_multifit_nlinear_jac(w : MultifitNlinearWorkspace*) : Matrix*
  fun multifit_nlinear_name = gsl_multifit_nlinear_name(w : MultifitNlinearWorkspace*) : LibC::Char*
  fun multifit_nlinear_position = gsl_multifit_nlinear_position(w : MultifitNlinearWorkspace*) : Vector*
  fun multifit_nlinear_residual = gsl_multifit_nlinear_residual(w : MultifitNlinearWorkspace*) : Vector*
  fun multifit_nlinear_niter = gsl_multifit_nlinear_niter(w : MultifitNlinearWorkspace*) : LibC::SizeT
  fun multifit_nlinear_rcond = gsl_multifit_nlinear_rcond(rcond : LibC::Double*, w : MultifitNlinearWorkspace*) : LibC::Int
  fun multifit_nlinear_trs_name = gsl_multifit_nlinear_trs_name(w : MultifitNlinearWorkspace*) : LibC::Char*
  fun multifit_nlinear_eval_f = gsl_multifit_nlinear_eval_f(fdf : MultifitNlinearFdf*, x : Vector*, swts : Vector*, y : Vector*) : LibC::Int
  fun multifit_nlinear_eval_df = gsl_multifit_nlinear_eval_df(x : Vector*, f : Vector*, swts : Vector*, h : LibC::Double, fdtype : MultifitNlinearFdtype, fdf : MultifitNlinearFdf*, df : Matrix*, work : Vector*) : LibC::Int
  fun multifit_nlinear_eval_fvv = gsl_multifit_nlinear_eval_fvv(h : LibC::Double, x : Vector*, v : Vector*, f : Vector*, j : Matrix*, swts : Vector*, fdf : MultifitNlinearFdf*, yvv : Vector*, work : Vector*) : LibC::Int
  fun multifit_nlinear_covar = gsl_multifit_nlinear_covar(j : Matrix*, epsrel : LibC::Double, covar : Matrix*) : LibC::Int
  fun multifit_nlinear_test = gsl_multifit_nlinear_test(xtol : LibC::Double, gtol : LibC::Double, ftol : LibC::Double, info : LibC::Int*, w : MultifitNlinearWorkspace*) : LibC::Int
  fun multifit_nlinear_df = gsl_multifit_nlinear_df(h : LibC::Double, fdtype : MultifitNlinearFdtype, x : Vector*, wts : Vector*, fdf : MultifitNlinearFdf*, f : Vector*, j : Matrix*, work : Vector*) : LibC::Int
  fun multifit_nlinear_fdfvv = gsl_multifit_nlinear_fdfvv(h : LibC::Double, x : Vector*, v : Vector*, f : Vector*, j : Matrix*, swts : Vector*, fdf : MultifitNlinearFdf*, fvv : Vector*, work : Vector*) : LibC::Int
  fun multifit_gradient = gsl_multifit_gradient(j : Matrix*, f : Vector*, g : Vector*) : LibC::Int
  fun multifit_covar = gsl_multifit_covar(j : Matrix*, epsrel : LibC::Double, covar : Matrix*) : LibC::Int
  fun multifit_covar_qrpt = gsl_multifit_covar_QRPT(r : Matrix*, perm : Permutation*, epsrel : LibC::Double, covar : Matrix*) : LibC::Int

  struct MultifitFunctionStruct
    f : (Vector*, Void*, Vector* -> LibC::Int)
    n : LibC::SizeT
    p : LibC::SizeT
    params : Void*
  end

  fun multifit_fsolver_alloc = gsl_multifit_fsolver_alloc(t : MultifitFsolverType*, n : LibC::SizeT, p : LibC::SizeT) : MultifitFsolver*

  struct MultifitFsolverType
    name : LibC::Char*
    size : LibC::SizeT
    alloc : (Void*, LibC::SizeT, LibC::SizeT -> LibC::Int)
    set : (Void*, MultifitFunction*, Vector*, Vector*, Vector* -> LibC::Int)
    iterate : (Void*, MultifitFunction*, Vector*, Vector*, Vector* -> LibC::Int)
    free : (Void* -> Void)
  end

  type MultifitFunction = MultifitFunctionStruct

  struct MultifitFsolver
    type : MultifitFsolverType*
    function : MultifitFunction*
    x : Vector*
    f : Vector*
    dx : Vector*
    state : Void*
  end

  fun multifit_fsolver_free = gsl_multifit_fsolver_free(s : MultifitFsolver*)
  fun multifit_fsolver_set = gsl_multifit_fsolver_set(s : MultifitFsolver*, f : MultifitFunction*, x : Vector*) : LibC::Int
  fun multifit_fsolver_iterate = gsl_multifit_fsolver_iterate(s : MultifitFsolver*) : LibC::Int
  fun multifit_fsolver_driver = gsl_multifit_fsolver_driver(s : MultifitFsolver*, maxiter : LibC::SizeT, epsabs : LibC::Double, epsrel : LibC::Double) : LibC::Int
  fun multifit_fsolver_name = gsl_multifit_fsolver_name(s : MultifitFsolver*) : LibC::Char*
  fun multifit_fsolver_position = gsl_multifit_fsolver_position(s : MultifitFsolver*) : Vector*

  struct MultifitFunctionFdfStruct
    f : (Vector*, Void*, Vector* -> LibC::Int)
    df : (Vector*, Void*, Matrix* -> LibC::Int)
    fdf : (Vector*, Void*, Vector*, Matrix* -> LibC::Int)
    n : LibC::SizeT
    p : LibC::SizeT
    params : Void*
    nevalf : LibC::SizeT
    nevaldf : LibC::SizeT
  end

  fun multifit_fdfsolver_alloc = gsl_multifit_fdfsolver_alloc(t : MultifitFdfsolverType*, n : LibC::SizeT, p : LibC::SizeT) : MultifitFdfsolver*

  struct MultifitFdfsolverType
    name : LibC::Char*
    size : LibC::SizeT
    alloc : (Void*, LibC::SizeT, LibC::SizeT -> LibC::Int)
    set : (Void*, Vector*, MultifitFunctionFdf*, Vector*, Vector*, Vector* -> LibC::Int)
    iterate : (Void*, Vector*, MultifitFunctionFdf*, Vector*, Vector*, Vector* -> LibC::Int)
    gradient : (Void*, Vector* -> LibC::Int)
    jac : (Void*, Matrix* -> LibC::Int)
    free : (Void* -> Void)
  end

  type MultifitFunctionFdf = MultifitFunctionFdfStruct

  struct MultifitFdfsolver
    type : MultifitFdfsolverType*
    fdf : MultifitFunctionFdf*
    x : Vector*
    f : Vector*
    dx : Vector*
    g : Vector*
    sqrt_wts : Vector*
    niter : LibC::SizeT
    state : Void*
  end

  fun multifit_fdfsolver_set = gsl_multifit_fdfsolver_set(s : MultifitFdfsolver*, fdf : MultifitFunctionFdf*, x : Vector*) : LibC::Int
  fun multifit_fdfsolver_wset = gsl_multifit_fdfsolver_wset(s : MultifitFdfsolver*, f : MultifitFunctionFdf*, x : Vector*, wts : Vector*) : LibC::Int
  fun multifit_fdfsolver_iterate = gsl_multifit_fdfsolver_iterate(s : MultifitFdfsolver*) : LibC::Int
  fun multifit_fdfsolver_driver = gsl_multifit_fdfsolver_driver(s : MultifitFdfsolver*, maxiter : LibC::SizeT, xtol : LibC::Double, gtol : LibC::Double, ftol : LibC::Double, info : LibC::Int*) : LibC::Int
  fun multifit_fdfsolver_jac = gsl_multifit_fdfsolver_jac(s : MultifitFdfsolver*, j : Matrix*) : LibC::Int
  fun multifit_fdfsolver_free = gsl_multifit_fdfsolver_free(s : MultifitFdfsolver*)
  fun multifit_fdfsolver_name = gsl_multifit_fdfsolver_name(s : MultifitFdfsolver*) : LibC::Char*
  fun multifit_fdfsolver_position = gsl_multifit_fdfsolver_position(s : MultifitFdfsolver*) : Vector*
  fun multifit_fdfsolver_residual = gsl_multifit_fdfsolver_residual(s : MultifitFdfsolver*) : Vector*
  fun multifit_fdfsolver_niter = gsl_multifit_fdfsolver_niter(s : MultifitFdfsolver*) : LibC::SizeT
  fun multifit_eval_wf = gsl_multifit_eval_wf(fdf : MultifitFunctionFdf*, x : Vector*, wts : Vector*, y : Vector*) : LibC::Int
  fun multifit_eval_wdf = gsl_multifit_eval_wdf(fdf : MultifitFunctionFdf*, x : Vector*, wts : Vector*, dy : Matrix*) : LibC::Int
  fun multifit_fdfsolver_test = gsl_multifit_fdfsolver_test(s : MultifitFdfsolver*, xtol : LibC::Double, gtol : LibC::Double, ftol : LibC::Double, info : LibC::Int*) : LibC::Int
  fun multifit_test_delta = gsl_multifit_test_delta(dx : Vector*, x : Vector*, epsabs : LibC::Double, epsrel : LibC::Double) : LibC::Int
  fun multifit_test_gradient = gsl_multifit_test_gradient(g : Vector*, epsabs : LibC::Double) : LibC::Int
  fun multifit_fdfsolver_dif_df = gsl_multifit_fdfsolver_dif_df(x : Vector*, wts : Vector*, fdf : MultifitFunctionFdf*, f : Vector*, j : Matrix*) : LibC::Int
  fun multifit_fdfsolver_dif_fdf = gsl_multifit_fdfsolver_dif_fdf(x : Vector*, fdf : MultifitFunctionFdf*, f : Vector*, j : Matrix*) : LibC::Int
  fun multifit_fdfridge_alloc = gsl_multifit_fdfridge_alloc(t : MultifitFdfsolverType*, n : LibC::SizeT, p : LibC::SizeT) : MultifitFdfridge*

  struct MultifitFdfridge
    n : LibC::SizeT
    p : LibC::SizeT
    lambda : LibC::Double
    l_diag : Vector*
    l : Matrix*
    f : Vector*
    wts : Vector*
    s : MultifitFdfsolver*
    fdf : MultifitFunctionFdf*
    fdftik : MultifitFunctionFdf
  end

  fun multifit_fdfridge_free = gsl_multifit_fdfridge_free(work : MultifitFdfridge*)
  fun multifit_fdfridge_name = gsl_multifit_fdfridge_name(w : MultifitFdfridge*) : LibC::Char*
  fun multifit_fdfridge_position = gsl_multifit_fdfridge_position(w : MultifitFdfridge*) : Vector*
  fun multifit_fdfridge_residual = gsl_multifit_fdfridge_residual(w : MultifitFdfridge*) : Vector*
  fun multifit_fdfridge_niter = gsl_multifit_fdfridge_niter(w : MultifitFdfridge*) : LibC::SizeT
  fun multifit_fdfridge_set = gsl_multifit_fdfridge_set(w : MultifitFdfridge*, f : MultifitFunctionFdf*, x : Vector*, lambda : LibC::Double) : LibC::Int
  fun multifit_fdfridge_wset = gsl_multifit_fdfridge_wset(w : MultifitFdfridge*, f : MultifitFunctionFdf*, x : Vector*, lambda : LibC::Double, wts : Vector*) : LibC::Int
  fun multifit_fdfridge_set2 = gsl_multifit_fdfridge_set2(w : MultifitFdfridge*, f : MultifitFunctionFdf*, x : Vector*, lambda : Vector*) : LibC::Int
  fun multifit_fdfridge_wset2 = gsl_multifit_fdfridge_wset2(w : MultifitFdfridge*, f : MultifitFunctionFdf*, x : Vector*, lambda : Vector*, wts : Vector*) : LibC::Int
  fun multifit_fdfridge_set3 = gsl_multifit_fdfridge_set3(w : MultifitFdfridge*, f : MultifitFunctionFdf*, x : Vector*, l : Matrix*) : LibC::Int
  fun multifit_fdfridge_wset3 = gsl_multifit_fdfridge_wset3(w : MultifitFdfridge*, f : MultifitFunctionFdf*, x : Vector*, l : Matrix*, wts : Vector*) : LibC::Int
  fun multifit_fdfridge_iterate = gsl_multifit_fdfridge_iterate(w : MultifitFdfridge*) : LibC::Int
  fun multifit_fdfridge_driver = gsl_multifit_fdfridge_driver(w : MultifitFdfridge*, maxiter : LibC::SizeT, xtol : LibC::Double, gtol : LibC::Double, ftol : LibC::Double, info : LibC::Int*) : LibC::Int

  struct MultilargeLinearType
    name : LibC::Char*
    alloc : (LibC::SizeT -> Void*)
    reset : (Void* -> LibC::Int)
    accumulate : (Matrix*, Vector*, Void* -> LibC::Int)
    solve : (LibC::Double, Vector*, LibC::Double*, LibC::Double*, Void* -> LibC::Int)
    rcond : (LibC::Double*, Void* -> LibC::Int)
    lcurve : (Vector*, Vector*, Vector*, Void* -> LibC::Int)
    free : (Void* -> Void)
  end

  fun multilarge_linear_alloc = gsl_multilarge_linear_alloc(t : MultilargeLinearType*, p : LibC::SizeT) : MultilargeLinearWorkspace*

  struct MultilargeLinearWorkspace
    type : MultilargeLinearType*
    state : Void*
    p : LibC::SizeT
  end

  fun multilarge_linear_free = gsl_multilarge_linear_free(w : MultilargeLinearWorkspace*)
  fun multilarge_linear_name = gsl_multilarge_linear_name(w : MultilargeLinearWorkspace*) : LibC::Char*
  fun multilarge_linear_reset = gsl_multilarge_linear_reset(w : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_accumulate = gsl_multilarge_linear_accumulate(x : Matrix*, y : Vector*, w : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_solve = gsl_multilarge_linear_solve(lambda : LibC::Double, c : Vector*, rnorm : LibC::Double*, snorm : LibC::Double*, w : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_rcond = gsl_multilarge_linear_rcond(rcond : LibC::Double*, w : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_lcurve = gsl_multilarge_linear_lcurve(reg_param : Vector*, rho : Vector*, eta : Vector*, w : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_wstdform1 = gsl_multilarge_linear_wstdform1(l : Vector*, x : Matrix*, w : Vector*, y : Vector*, xs : Matrix*, ys : Vector*, work : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_stdform1 = gsl_multilarge_linear_stdform1(l : Vector*, x : Matrix*, y : Vector*, xs : Matrix*, ys : Vector*, work : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_l_decomp = gsl_multilarge_linear_L_decomp(l : Matrix*, tau : Vector*) : LibC::Int
  fun multilarge_linear_wstdform2 = gsl_multilarge_linear_wstdform2(lqr : Matrix*, ltau : Vector*, x : Matrix*, w : Vector*, y : Vector*, xs : Matrix*, ys : Vector*, work : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_stdform2 = gsl_multilarge_linear_stdform2(lqr : Matrix*, ltau : Vector*, x : Matrix*, y : Vector*, xs : Matrix*, ys : Vector*, work : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_genform1 = gsl_multilarge_linear_genform1(l : Vector*, cs : Vector*, c : Vector*, work : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_linear_genform2 = gsl_multilarge_linear_genform2(lqr : Matrix*, ltau : Vector*, cs : Vector*, c : Vector*, work : MultilargeLinearWorkspace*) : LibC::Int
  fun multilarge_nlinear_alloc = gsl_multilarge_nlinear_alloc(t : MultilargeNlinearType*, params : MultilargeNlinearParameters*, n : LibC::SizeT, p : LibC::SizeT) : MultilargeNlinearWorkspace*

  struct MultilargeNlinearType
    name : LibC::Char*
    alloc : (MultilargeNlinearParameters*, LibC::SizeT, LibC::SizeT -> Void*)
    init : (Void*, Vector*, MultilargeNlinearFdf*, Vector*, Vector*, Vector*, Matrix* -> LibC::Int)
    iterate : (Void*, Vector*, MultilargeNlinearFdf*, Vector*, Vector*, Vector*, Matrix*, Vector* -> LibC::Int)
    rcond : (LibC::Double*, Matrix*, Void* -> LibC::Int)
    covar : (Matrix*, Matrix*, Void* -> LibC::Int)
    avratio : (Void* -> LibC::Double)
    free : (Void* -> Void)
  end

  struct MultilargeNlinearParameters
    trs : MultilargeNlinearTrs*
    scale : MultilargeNlinearScale*
    solver : MultilargeNlinearSolver*
    fdtype : MultilargeNlinearFdtype
    factor_up : LibC::Double
    factor_down : LibC::Double
    avmax : LibC::Double
    h_df : LibC::Double
    h_fvv : LibC::Double
    max_iter : LibC::SizeT
    tol : LibC::Double
  end

  struct MultilargeNlinearTrs
    name : LibC::Char*
    alloc : (Void*, LibC::SizeT, LibC::SizeT -> Void*)
    init : (Void*, Void* -> LibC::Int)
    preloop : (Void*, Void* -> LibC::Int)
    step : (Void*, LibC::Double, Vector*, Void* -> LibC::Int)
    preduction : (Void*, Vector*, LibC::Double*, Void* -> LibC::Int)
    free : (Void* -> Void)
  end

  struct MultilargeNlinearScale
    name : LibC::Char*
    init : (Matrix*, Vector* -> LibC::Int)
    update : (Matrix*, Vector* -> LibC::Int)
  end

  struct MultilargeNlinearSolver
    name : LibC::Char*
    alloc : (LibC::SizeT, LibC::SizeT -> Void*)
    init : (Void*, Void* -> LibC::Int)
    presolve : (LibC::Double, Void*, Void* -> LibC::Int)
    solve : (Vector*, Vector*, Void*, Void* -> LibC::Int)
    rcond : (LibC::Double*, Matrix*, Void* -> LibC::Int)
    covar : (Matrix*, Matrix*, Void* -> LibC::Int)
    free : (Void* -> Void)
  end

  enum MultilargeNlinearFdtype
    GslMultilargeNlinearFwdiff  = 0
    GslMultilargeNlinearCtrdiff = 1
  end

  struct MultilargeNlinearFdf
    f : (Vector*, Void*, Vector* -> LibC::Int)
    df : (CblasTransposeT, Vector*, Vector*, Void*, Vector*, Matrix* -> LibC::Int)
    fvv : (Vector*, Vector*, Void*, Vector* -> LibC::Int)
    n : LibC::SizeT
    p : LibC::SizeT
    params : Void*
    nevalf : LibC::SizeT
    nevaldfu : LibC::SizeT
    nevaldf2 : LibC::SizeT
    nevalfvv : LibC::SizeT
  end

  struct MultilargeNlinearWorkspace
    type : MultilargeNlinearType*
    fdf : MultilargeNlinearFdf*
    x : Vector*
    f : Vector*
    dx : Vector*
    g : Vector*
    jtj : Matrix*
    sqrt_wts_work : Vector*
    sqrt_wts : Vector*
    n : LibC::SizeT
    p : LibC::SizeT
    niter : LibC::SizeT
    params : MultilargeNlinearParameters
    state : Void*
  end

  fun multilarge_nlinear_free = gsl_multilarge_nlinear_free(w : MultilargeNlinearWorkspace*)
  fun multilarge_nlinear_default_parameters = gsl_multilarge_nlinear_default_parameters : MultilargeNlinearParameters
  fun multilarge_nlinear_init = gsl_multilarge_nlinear_init(x : Vector*, fdf : MultilargeNlinearFdf*, w : MultilargeNlinearWorkspace*) : LibC::Int
  fun multilarge_nlinear_winit = gsl_multilarge_nlinear_winit(x : Vector*, wts : Vector*, fdf : MultilargeNlinearFdf*, w : MultilargeNlinearWorkspace*) : LibC::Int
  fun multilarge_nlinear_iterate = gsl_multilarge_nlinear_iterate(w : MultilargeNlinearWorkspace*) : LibC::Int
  fun multilarge_nlinear_avratio = gsl_multilarge_nlinear_avratio(w : MultilargeNlinearWorkspace*) : LibC::Double
  fun multilarge_nlinear_rcond = gsl_multilarge_nlinear_rcond(rcond : LibC::Double*, w : MultilargeNlinearWorkspace*) : LibC::Int
  fun multilarge_nlinear_covar = gsl_multilarge_nlinear_covar(covar : Matrix*, w : MultilargeNlinearWorkspace*) : LibC::Int
  fun multilarge_nlinear_driver = gsl_multilarge_nlinear_driver(maxiter : LibC::SizeT, xtol : LibC::Double, gtol : LibC::Double, ftol : LibC::Double, callback : (LibC::SizeT, Void*, MultilargeNlinearWorkspace* -> Void), callback_params : Void*, info : LibC::Int*, w : MultilargeNlinearWorkspace*) : LibC::Int
  fun multilarge_nlinear_name = gsl_multilarge_nlinear_name(w : MultilargeNlinearWorkspace*) : LibC::Char*
  fun multilarge_nlinear_position = gsl_multilarge_nlinear_position(w : MultilargeNlinearWorkspace*) : Vector*
  fun multilarge_nlinear_residual = gsl_multilarge_nlinear_residual(w : MultilargeNlinearWorkspace*) : Vector*
  fun multilarge_nlinear_step = gsl_multilarge_nlinear_step(w : MultilargeNlinearWorkspace*) : Vector*
  fun multilarge_nlinear_niter = gsl_multilarge_nlinear_niter(w : MultilargeNlinearWorkspace*) : LibC::SizeT
  fun multilarge_nlinear_trs_name = gsl_multilarge_nlinear_trs_name(w : MultilargeNlinearWorkspace*) : LibC::Char*
  fun multilarge_nlinear_eval_f = gsl_multilarge_nlinear_eval_f(fdf : MultilargeNlinearFdf*, x : Vector*, swts : Vector*, y : Vector*) : LibC::Int
  fun multilarge_nlinear_eval_df = gsl_multilarge_nlinear_eval_df(trans_j : CblasTransposeT, x : Vector*, f : Vector*, u : Vector*, swts : Vector*, h : LibC::Double, fdtype : MultilargeNlinearFdtype, fdf : MultilargeNlinearFdf*, v : Vector*, jtj : Matrix*, work : Vector*) : LibC::Int
  fun multilarge_nlinear_eval_fvv = gsl_multilarge_nlinear_eval_fvv(h : LibC::Double, x : Vector*, v : Vector*, f : Vector*, swts : Vector*, fdf : MultilargeNlinearFdf*, yvv : Vector*, work : Vector*) : LibC::Int
  fun multilarge_nlinear_test = gsl_multilarge_nlinear_test(xtol : LibC::Double, gtol : LibC::Double, ftol : LibC::Double, info : LibC::Int*, w : MultilargeNlinearWorkspace*) : LibC::Int
  fun multilarge_nlinear_df = gsl_multilarge_nlinear_df(h : LibC::Double, fdtype : MultilargeNlinearFdtype, x : Vector*, wts : Vector*, fdf : MultilargeNlinearFdf*, f : Vector*, j : Matrix*, work : Vector*) : LibC::Int
  fun multilarge_nlinear_fdfvv = gsl_multilarge_nlinear_fdfvv(h : LibC::Double, x : Vector*, v : Vector*, f : Vector*, j : Matrix*, swts : Vector*, fdf : MultilargeNlinearFdf*, fvv : Vector*, work : Vector*) : LibC::Int

  struct MultiminFunctionStruct
    f : (Vector*, Void* -> LibC::Double)
    n : LibC::SizeT
    params : Void*
  end

  struct MultiminFunctionFdfStruct
    f : (Vector*, Void* -> LibC::Double)
    df : (Vector*, Void*, Vector* -> Void)
    fdf : (Vector*, Void*, LibC::Double*, Vector* -> Void)
    n : LibC::SizeT
    params : Void*
  end

  fun multimin_diff = gsl_multimin_diff(f : MultiminFunction*, x : Vector*, g : Vector*) : LibC::Int
  type MultiminFunction = MultiminFunctionStruct
  fun multimin_fminimizer_alloc = gsl_multimin_fminimizer_alloc(t : MultiminFminimizerType*, n : LibC::SizeT) : MultiminFminimizer*

  struct MultiminFminimizerType
    name : LibC::Char*
    size : LibC::SizeT
    alloc : (Void*, LibC::SizeT -> LibC::Int)
    set : (Void*, MultiminFunction*, Vector*, LibC::Double*, Vector* -> LibC::Int)
    iterate : (Void*, MultiminFunction*, Vector*, LibC::Double*, LibC::Double* -> LibC::Int)
    free : (Void* -> Void)
  end

  struct MultiminFminimizer
    type : MultiminFminimizerType*
    f : MultiminFunction*
    fval : LibC::Double
    x : Vector*
    size : LibC::Double
    state : Void*
  end

  fun multimin_fminimizer_set = gsl_multimin_fminimizer_set(s : MultiminFminimizer*, f : MultiminFunction*, x : Vector*, step_size : Vector*) : LibC::Int
  fun multimin_fminimizer_free = gsl_multimin_fminimizer_free(s : MultiminFminimizer*)
  fun multimin_fminimizer_name = gsl_multimin_fminimizer_name(s : MultiminFminimizer*) : LibC::Char*
  fun multimin_fminimizer_iterate = gsl_multimin_fminimizer_iterate(s : MultiminFminimizer*) : LibC::Int
  fun multimin_fminimizer_x = gsl_multimin_fminimizer_x(s : MultiminFminimizer*) : Vector*
  fun multimin_fminimizer_minimum = gsl_multimin_fminimizer_minimum(s : MultiminFminimizer*) : LibC::Double
  fun multimin_fminimizer_size = gsl_multimin_fminimizer_size(s : MultiminFminimizer*) : LibC::Double
  fun multimin_test_gradient = gsl_multimin_test_gradient(g : Vector*, epsabs : LibC::Double) : LibC::Int
  fun multimin_test_size = gsl_multimin_test_size(size : LibC::Double, epsabs : LibC::Double) : LibC::Int
  fun multimin_fdfminimizer_alloc = gsl_multimin_fdfminimizer_alloc(t : MultiminFdfminimizerType*, n : LibC::SizeT) : MultiminFdfminimizer*

  struct MultiminFdfminimizerType
    name : LibC::Char*
    size : LibC::SizeT
    alloc : (Void*, LibC::SizeT -> LibC::Int)
    set : (Void*, MultiminFunctionFdf*, Vector*, LibC::Double*, Vector*, LibC::Double, LibC::Double -> LibC::Int)
    iterate : (Void*, MultiminFunctionFdf*, Vector*, LibC::Double*, Vector*, Vector* -> LibC::Int)
    restart : (Void* -> LibC::Int)
    free : (Void* -> Void)
  end

  type MultiminFunctionFdf = MultiminFunctionFdfStruct

  struct MultiminFdfminimizer
    type : MultiminFdfminimizerType*
    fdf : MultiminFunctionFdf*
    f : LibC::Double
    x : Vector*
    gradient : Vector*
    dx : Vector*
    state : Void*
  end

  fun multimin_fdfminimizer_set = gsl_multimin_fdfminimizer_set(s : MultiminFdfminimizer*, fdf : MultiminFunctionFdf*, x : Vector*, step_size : LibC::Double, tol : LibC::Double) : LibC::Int
  fun multimin_fdfminimizer_free = gsl_multimin_fdfminimizer_free(s : MultiminFdfminimizer*)
  fun multimin_fdfminimizer_name = gsl_multimin_fdfminimizer_name(s : MultiminFdfminimizer*) : LibC::Char*
  fun multimin_fdfminimizer_iterate = gsl_multimin_fdfminimizer_iterate(s : MultiminFdfminimizer*) : LibC::Int
  fun multimin_fdfminimizer_restart = gsl_multimin_fdfminimizer_restart(s : MultiminFdfminimizer*) : LibC::Int
  fun multimin_fdfminimizer_x = gsl_multimin_fdfminimizer_x(s : MultiminFdfminimizer*) : Vector*
  fun multimin_fdfminimizer_dx = gsl_multimin_fdfminimizer_dx(s : MultiminFdfminimizer*) : Vector*
  fun multimin_fdfminimizer_gradient = gsl_multimin_fdfminimizer_gradient(s : MultiminFdfminimizer*) : Vector*
  fun multimin_fdfminimizer_minimum = gsl_multimin_fdfminimizer_minimum(s : MultiminFdfminimizer*) : LibC::Double

  struct MultirootFunctionStruct
    f : (Vector*, Void*, Vector* -> LibC::Int)
    n : LibC::SizeT
    params : Void*
  end

  fun multiroot_fdjacobian = gsl_multiroot_fdjacobian(f : MultirootFunction*, x : Vector*, f : Vector*, epsrel : LibC::Double, jacobian : Matrix*) : LibC::Int
  type MultirootFunction = MultirootFunctionStruct
  fun multiroot_fsolver_alloc = gsl_multiroot_fsolver_alloc(t : MultirootFsolverType*, n : LibC::SizeT) : MultirootFsolver*

  struct MultirootFsolverType
    name : LibC::Char*
    size : LibC::SizeT
    alloc : (Void*, LibC::SizeT -> LibC::Int)
    set : (Void*, MultirootFunction*, Vector*, Vector*, Vector* -> LibC::Int)
    iterate : (Void*, MultirootFunction*, Vector*, Vector*, Vector* -> LibC::Int)
    free : (Void* -> Void)
  end

  struct MultirootFsolver
    type : MultirootFsolverType*
    function : MultirootFunction*
    x : Vector*
    f : Vector*
    dx : Vector*
    state : Void*
  end

  fun multiroot_fsolver_free = gsl_multiroot_fsolver_free(s : MultirootFsolver*)
  fun multiroot_fsolver_set = gsl_multiroot_fsolver_set(s : MultirootFsolver*, f : MultirootFunction*, x : Vector*) : LibC::Int
  fun multiroot_fsolver_iterate = gsl_multiroot_fsolver_iterate(s : MultirootFsolver*) : LibC::Int
  fun multiroot_fsolver_name = gsl_multiroot_fsolver_name(s : MultirootFsolver*) : LibC::Char*
  fun multiroot_fsolver_root = gsl_multiroot_fsolver_root(s : MultirootFsolver*) : Vector*
  fun multiroot_fsolver_dx = gsl_multiroot_fsolver_dx(s : MultirootFsolver*) : Vector*
  fun multiroot_fsolver_f = gsl_multiroot_fsolver_f(s : MultirootFsolver*) : Vector*

  struct MultirootFunctionFdfStruct
    f : (Vector*, Void*, Vector* -> LibC::Int)
    df : (Vector*, Void*, Matrix* -> LibC::Int)
    fdf : (Vector*, Void*, Vector*, Matrix* -> LibC::Int)
    n : LibC::SizeT
    params : Void*
  end

  fun multiroot_fdfsolver_alloc = gsl_multiroot_fdfsolver_alloc(t : MultirootFdfsolverType*, n : LibC::SizeT) : MultirootFdfsolver*

  struct MultirootFdfsolverType
    name : LibC::Char*
    size : LibC::SizeT
    alloc : (Void*, LibC::SizeT -> LibC::Int)
    set : (Void*, MultirootFunctionFdf*, Vector*, Vector*, Matrix*, Vector* -> LibC::Int)
    iterate : (Void*, MultirootFunctionFdf*, Vector*, Vector*, Matrix*, Vector* -> LibC::Int)
    free : (Void* -> Void)
  end

  type MultirootFunctionFdf = MultirootFunctionFdfStruct

  struct MultirootFdfsolver
    type : MultirootFdfsolverType*
    fdf : MultirootFunctionFdf*
    x : Vector*
    f : Vector*
    j : Matrix*
    dx : Vector*
    state : Void*
  end

  fun multiroot_fdfsolver_set = gsl_multiroot_fdfsolver_set(s : MultirootFdfsolver*, fdf : MultirootFunctionFdf*, x : Vector*) : LibC::Int
  fun multiroot_fdfsolver_iterate = gsl_multiroot_fdfsolver_iterate(s : MultirootFdfsolver*) : LibC::Int
  fun multiroot_fdfsolver_free = gsl_multiroot_fdfsolver_free(s : MultirootFdfsolver*)
  fun multiroot_fdfsolver_name = gsl_multiroot_fdfsolver_name(s : MultirootFdfsolver*) : LibC::Char*
  fun multiroot_fdfsolver_root = gsl_multiroot_fdfsolver_root(s : MultirootFdfsolver*) : Vector*
  fun multiroot_fdfsolver_dx = gsl_multiroot_fdfsolver_dx(s : MultirootFdfsolver*) : Vector*
  fun multiroot_fdfsolver_f = gsl_multiroot_fdfsolver_f(s : MultirootFdfsolver*) : Vector*
  fun multiroot_test_delta = gsl_multiroot_test_delta(dx : Vector*, x : Vector*, epsabs : LibC::Double, epsrel : LibC::Double) : LibC::Int
  fun multiroot_test_residual = gsl_multiroot_test_residual(f : Vector*, epsabs : LibC::Double) : LibC::Int

  struct MultisetStruct
    n : LibC::SizeT
    k : LibC::SizeT
    data : LibC::SizeT*
  end

  fun multiset_alloc = gsl_multiset_alloc(n : LibC::SizeT, k : LibC::SizeT) : Multiset*
  type Multiset = MultisetStruct
  fun multiset_calloc = gsl_multiset_calloc(n : LibC::SizeT, k : LibC::SizeT) : Multiset*
  fun multiset_init_first = gsl_multiset_init_first(c : Multiset*)
  fun multiset_init_last = gsl_multiset_init_last(c : Multiset*)
  fun multiset_free = gsl_multiset_free(c : Multiset*)
  fun multiset_memcpy = gsl_multiset_memcpy(dest : Multiset*, src : Multiset*) : LibC::Int
  fun multiset_fread = gsl_multiset_fread(stream : File*, c : Multiset*) : LibC::Int
  fun multiset_fwrite = gsl_multiset_fwrite(stream : File*, c : Multiset*) : LibC::Int
  fun multiset_fscanf = gsl_multiset_fscanf(stream : File*, c : Multiset*) : LibC::Int
  fun multiset_fprintf = gsl_multiset_fprintf(stream : File*, c : Multiset*, format : LibC::Char*) : LibC::Int
  fun multiset_n = gsl_multiset_n(c : Multiset*) : LibC::SizeT
  fun multiset_k = gsl_multiset_k(c : Multiset*) : LibC::SizeT
  fun multiset_data = gsl_multiset_data(c : Multiset*) : LibC::SizeT*
  fun multiset_valid = gsl_multiset_valid(c : Multiset*) : LibC::Int
  fun multiset_next = gsl_multiset_next(c : Multiset*) : LibC::Int
  fun multiset_prev = gsl_multiset_prev(c : Multiset*) : LibC::Int
  fun multiset_get = gsl_multiset_get(c : Multiset*, i : LibC::SizeT) : LibC::SizeT
  fun ntuple_open = gsl_ntuple_open(filename : LibC::Char*, ntuple_data : Void*, size : LibC::SizeT) : Ntuple*

  struct Ntuple
    file : File*
    ntuple_data : Void*
    size : LibC::SizeT
  end

  fun ntuple_create = gsl_ntuple_create(filename : LibC::Char*, ntuple_data : Void*, size : LibC::SizeT) : Ntuple*
  fun ntuple_write = gsl_ntuple_write(ntuple : Ntuple*) : LibC::Int
  fun ntuple_read = gsl_ntuple_read(ntuple : Ntuple*) : LibC::Int
  fun ntuple_bookdata = gsl_ntuple_bookdata(ntuple : Ntuple*) : LibC::Int
  fun ntuple_project = gsl_ntuple_project(h : Histogram*, ntuple : Ntuple*, value_func : NtupleValueFn*, select_func : NtupleSelectFn*) : LibC::Int

  struct NtupleValueFn
    function : (Void*, Void* -> LibC::Double)
    params : Void*
  end

  struct NtupleSelectFn
    function : (Void*, Void* -> LibC::Int)
    params : Void*
  end

  fun ntuple_close = gsl_ntuple_close(ntuple : Ntuple*) : LibC::Int

  struct Odeiv2StepStruct
    type : Odeiv2StepType*
    dimension : LibC::SizeT
    state : Void*
  end

  struct Odeiv2StepType
    name : LibC::Char*
    can_use_dydt_in : LibC::Int
    gives_exact_dydt_out : LibC::Int
    alloc : (LibC::SizeT -> Void*)
    apply : (Void*, LibC::SizeT, LibC::Double, LibC::Double, LibC::Double*, LibC::Double*, LibC::Double*, LibC::Double*, Odeiv2System* -> LibC::Int)
    set_driver : (Void*, Odeiv2Driver* -> LibC::Int)
    reset : (Void*, LibC::SizeT -> LibC::Int)
    order : (Void* -> LibC::UInt)
    free : (Void* -> Void)
  end

  struct Odeiv2System
    function : (LibC::Double, LibC::Double*, LibC::Double*, Void* -> LibC::Int)
    jacobian : (LibC::Double, LibC::Double*, LibC::Double*, LibC::Double*, Void* -> LibC::Int)
    dimension : LibC::SizeT
    params : Void*
  end

  struct Odeiv2DriverStruct
    sys : Odeiv2System*
    s : Odeiv2Step*
    c : Odeiv2Control*
    e : Odeiv2Evolve*
    h : LibC::Double
    hmin : LibC::Double
    hmax : LibC::Double
    n : LibC::ULong
    nmax : LibC::ULong
  end

  type Odeiv2Driver = Odeiv2DriverStruct
  type Odeiv2Step = Odeiv2StepStruct

  struct Odeiv2ControlStruct
    type : Odeiv2ControlType*
    state : Void*
  end

  type Odeiv2Control = Odeiv2ControlStruct

  struct Odeiv2ControlType
    name : LibC::Char*
    alloc : (-> Void*)
    init : (Void*, LibC::Double, LibC::Double, LibC::Double, LibC::Double -> LibC::Int)
    hadjust : (Void*, LibC::SizeT, LibC::UInt, LibC::Double*, LibC::Double*, LibC::Double*, LibC::Double* -> LibC::Int)
    errlevel : (Void*, LibC::Double, LibC::Double, LibC::Double, LibC::SizeT, LibC::Double* -> LibC::Int)
    set_driver : (Void*, Odeiv2Driver* -> LibC::Int)
    free : (Void* -> Void)
  end

  struct Odeiv2EvolveStruct
    dimension : LibC::SizeT
    y0 : LibC::Double*
    yerr : LibC::Double*
    dydt_in : LibC::Double*
    dydt_out : LibC::Double*
    last_step : LibC::Double
    count : LibC::ULong
    failed_steps : LibC::ULong
    driver : Odeiv2Driver*
  end

  type Odeiv2Evolve = Odeiv2EvolveStruct
  fun odeiv2_step_alloc = gsl_odeiv2_step_alloc(t : Odeiv2StepType*, dim : LibC::SizeT) : Odeiv2Step*
  fun odeiv2_step_reset = gsl_odeiv2_step_reset(s : Odeiv2Step*) : LibC::Int
  fun odeiv2_step_free = gsl_odeiv2_step_free(s : Odeiv2Step*)
  fun odeiv2_step_name = gsl_odeiv2_step_name(s : Odeiv2Step*) : LibC::Char*
  fun odeiv2_step_order = gsl_odeiv2_step_order(s : Odeiv2Step*) : LibC::UInt
  fun odeiv2_step_apply = gsl_odeiv2_step_apply(s : Odeiv2Step*, t : LibC::Double, h : LibC::Double, y : LibC::Double*, yerr : LibC::Double*, dydt_in : LibC::Double*, dydt_out : LibC::Double*, dydt : Odeiv2System*) : LibC::Int
  fun odeiv2_step_set_driver = gsl_odeiv2_step_set_driver(s : Odeiv2Step*, d : Odeiv2Driver*) : LibC::Int
  fun odeiv2_control_alloc = gsl_odeiv2_control_alloc(t : Odeiv2ControlType*) : Odeiv2Control*
  fun odeiv2_control_init = gsl_odeiv2_control_init(c : Odeiv2Control*, eps_abs : LibC::Double, eps_rel : LibC::Double, a_y : LibC::Double, a_dydt : LibC::Double) : LibC::Int
  fun odeiv2_control_free = gsl_odeiv2_control_free(c : Odeiv2Control*)
  fun odeiv2_control_hadjust = gsl_odeiv2_control_hadjust(c : Odeiv2Control*, s : Odeiv2Step*, y : LibC::Double*, yerr : LibC::Double*, dydt : LibC::Double*, h : LibC::Double*) : LibC::Int
  fun odeiv2_control_name = gsl_odeiv2_control_name(c : Odeiv2Control*) : LibC::Char*
  fun odeiv2_control_errlevel = gsl_odeiv2_control_errlevel(c : Odeiv2Control*, y : LibC::Double, dydt : LibC::Double, h : LibC::Double, ind : LibC::SizeT, errlev : LibC::Double*) : LibC::Int
  fun odeiv2_control_set_driver = gsl_odeiv2_control_set_driver(c : Odeiv2Control*, d : Odeiv2Driver*) : LibC::Int
  fun odeiv2_control_standard_new = gsl_odeiv2_control_standard_new(eps_abs : LibC::Double, eps_rel : LibC::Double, a_y : LibC::Double, a_dydt : LibC::Double) : Odeiv2Control*
  fun odeiv2_control_y_new = gsl_odeiv2_control_y_new(eps_abs : LibC::Double, eps_rel : LibC::Double) : Odeiv2Control*
  fun odeiv2_control_yp_new = gsl_odeiv2_control_yp_new(eps_abs : LibC::Double, eps_rel : LibC::Double) : Odeiv2Control*
  fun odeiv2_control_scaled_new = gsl_odeiv2_control_scaled_new(eps_abs : LibC::Double, eps_rel : LibC::Double, a_y : LibC::Double, a_dydt : LibC::Double, scale_abs : LibC::Double*, dim : LibC::SizeT) : Odeiv2Control*
  fun odeiv2_evolve_alloc = gsl_odeiv2_evolve_alloc(dim : LibC::SizeT) : Odeiv2Evolve*
  fun odeiv2_evolve_apply = gsl_odeiv2_evolve_apply(e : Odeiv2Evolve*, con : Odeiv2Control*, step : Odeiv2Step*, dydt : Odeiv2System*, t : LibC::Double*, t1 : LibC::Double, h : LibC::Double*, y : LibC::Double*) : LibC::Int
  fun odeiv2_evolve_apply_fixed_step = gsl_odeiv2_evolve_apply_fixed_step(e : Odeiv2Evolve*, con : Odeiv2Control*, step : Odeiv2Step*, dydt : Odeiv2System*, t : LibC::Double*, h0 : LibC::Double, y : LibC::Double*) : LibC::Int
  fun odeiv2_evolve_reset = gsl_odeiv2_evolve_reset(e : Odeiv2Evolve*) : LibC::Int
  fun odeiv2_evolve_free = gsl_odeiv2_evolve_free(e : Odeiv2Evolve*)
  fun odeiv2_evolve_set_driver = gsl_odeiv2_evolve_set_driver(e : Odeiv2Evolve*, d : Odeiv2Driver*) : LibC::Int
  fun odeiv2_driver_alloc_y_new = gsl_odeiv2_driver_alloc_y_new(sys : Odeiv2System*, t : Odeiv2StepType*, hstart : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double) : Odeiv2Driver*
  fun odeiv2_driver_alloc_yp_new = gsl_odeiv2_driver_alloc_yp_new(sys : Odeiv2System*, t : Odeiv2StepType*, hstart : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double) : Odeiv2Driver*
  fun odeiv2_driver_alloc_scaled_new = gsl_odeiv2_driver_alloc_scaled_new(sys : Odeiv2System*, t : Odeiv2StepType*, hstart : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, a_y : LibC::Double, a_dydt : LibC::Double, scale_abs : LibC::Double*) : Odeiv2Driver*
  fun odeiv2_driver_alloc_standard_new = gsl_odeiv2_driver_alloc_standard_new(sys : Odeiv2System*, t : Odeiv2StepType*, hstart : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double, a_y : LibC::Double, a_dydt : LibC::Double) : Odeiv2Driver*
  fun odeiv2_driver_set_hmin = gsl_odeiv2_driver_set_hmin(d : Odeiv2Driver*, hmin : LibC::Double) : LibC::Int
  fun odeiv2_driver_set_hmax = gsl_odeiv2_driver_set_hmax(d : Odeiv2Driver*, hmax : LibC::Double) : LibC::Int
  fun odeiv2_driver_set_nmax = gsl_odeiv2_driver_set_nmax(d : Odeiv2Driver*, nmax : LibC::ULong) : LibC::Int
  fun odeiv2_driver_apply = gsl_odeiv2_driver_apply(d : Odeiv2Driver*, t : LibC::Double*, t1 : LibC::Double, y : LibC::Double*) : LibC::Int
  fun odeiv2_driver_apply_fixed_step = gsl_odeiv2_driver_apply_fixed_step(d : Odeiv2Driver*, t : LibC::Double*, h : LibC::Double, n : LibC::ULong, y : LibC::Double*) : LibC::Int
  fun odeiv2_driver_reset = gsl_odeiv2_driver_reset(d : Odeiv2Driver*) : LibC::Int
  fun odeiv2_driver_reset_hstart = gsl_odeiv2_driver_reset_hstart(d : Odeiv2Driver*, hstart : LibC::Double) : LibC::Int
  fun odeiv2_driver_free = gsl_odeiv2_driver_free(state : Odeiv2Driver*)

  struct OdeivStepType
    name : LibC::Char*
    can_use_dydt_in : LibC::Int
    gives_exact_dydt_out : LibC::Int
    alloc : (LibC::SizeT -> Void*)
    apply : (Void*, LibC::SizeT, LibC::Double, LibC::Double, LibC::Double*, LibC::Double*, LibC::Double*, LibC::Double*, OdeivSystem* -> LibC::Int)
    reset : (Void*, LibC::SizeT -> LibC::Int)
    order : (Void* -> LibC::UInt)
    free : (Void* -> Void)
  end

  struct OdeivSystem
    function : (LibC::Double, LibC::Double*, LibC::Double*, Void* -> LibC::Int)
    jacobian : (LibC::Double, LibC::Double*, LibC::Double*, LibC::Double*, Void* -> LibC::Int)
    dimension : LibC::SizeT
    params : Void*
  end

  fun odeiv_step_alloc = gsl_odeiv_step_alloc(t : OdeivStepType*, dim : LibC::SizeT) : OdeivStep*

  struct OdeivStep
    type : OdeivStepType*
    dimension : LibC::SizeT
    state : Void*
  end

  fun odeiv_step_reset = gsl_odeiv_step_reset(s : OdeivStep*) : LibC::Int
  fun odeiv_step_free = gsl_odeiv_step_free(s : OdeivStep*)
  fun odeiv_step_name = gsl_odeiv_step_name(s : OdeivStep*) : LibC::Char*
  fun odeiv_step_order = gsl_odeiv_step_order(s : OdeivStep*) : LibC::UInt
  fun odeiv_step_apply = gsl_odeiv_step_apply(s : OdeivStep*, t : LibC::Double, h : LibC::Double, y : LibC::Double*, yerr : LibC::Double*, dydt_in : LibC::Double*, dydt_out : LibC::Double*, dydt : OdeivSystem*) : LibC::Int
  fun odeiv_control_alloc = gsl_odeiv_control_alloc(t : OdeivControlType*) : OdeivControl*

  struct OdeivControlType
    name : LibC::Char*
    alloc : (-> Void*)
    init : (Void*, LibC::Double, LibC::Double, LibC::Double, LibC::Double -> LibC::Int)
    hadjust : (Void*, LibC::SizeT, LibC::UInt, LibC::Double*, LibC::Double*, LibC::Double*, LibC::Double* -> LibC::Int)
    free : (Void* -> Void)
  end

  struct OdeivControl
    type : OdeivControlType*
    state : Void*
  end

  fun odeiv_control_init = gsl_odeiv_control_init(c : OdeivControl*, eps_abs : LibC::Double, eps_rel : LibC::Double, a_y : LibC::Double, a_dydt : LibC::Double) : LibC::Int
  fun odeiv_control_free = gsl_odeiv_control_free(c : OdeivControl*)
  fun odeiv_control_hadjust = gsl_odeiv_control_hadjust(c : OdeivControl*, s : OdeivStep*, y : LibC::Double*, yerr : LibC::Double*, dydt : LibC::Double*, h : LibC::Double*) : LibC::Int
  fun odeiv_control_name = gsl_odeiv_control_name(c : OdeivControl*) : LibC::Char*
  fun odeiv_control_standard_new = gsl_odeiv_control_standard_new(eps_abs : LibC::Double, eps_rel : LibC::Double, a_y : LibC::Double, a_dydt : LibC::Double) : OdeivControl*
  fun odeiv_control_y_new = gsl_odeiv_control_y_new(eps_abs : LibC::Double, eps_rel : LibC::Double) : OdeivControl*
  fun odeiv_control_yp_new = gsl_odeiv_control_yp_new(eps_abs : LibC::Double, eps_rel : LibC::Double) : OdeivControl*
  fun odeiv_control_scaled_new = gsl_odeiv_control_scaled_new(eps_abs : LibC::Double, eps_rel : LibC::Double, a_y : LibC::Double, a_dydt : LibC::Double, scale_abs : LibC::Double*, dim : LibC::SizeT) : OdeivControl*
  fun odeiv_evolve_alloc = gsl_odeiv_evolve_alloc(dim : LibC::SizeT) : OdeivEvolve*

  struct OdeivEvolve
    dimension : LibC::SizeT
    y0 : LibC::Double*
    yerr : LibC::Double*
    dydt_in : LibC::Double*
    dydt_out : LibC::Double*
    last_step : LibC::Double
    count : LibC::ULong
    failed_steps : LibC::ULong
  end

  fun odeiv_evolve_apply = gsl_odeiv_evolve_apply(e : OdeivEvolve*, con : OdeivControl*, step : OdeivStep*, dydt : OdeivSystem*, t : LibC::Double*, t1 : LibC::Double, h : LibC::Double*, y : LibC::Double*) : LibC::Int
  fun odeiv_evolve_reset = gsl_odeiv_evolve_reset(e : OdeivEvolve*) : LibC::Int
  fun odeiv_evolve_free = gsl_odeiv_evolve_free(e : OdeivEvolve*)
  fun permute_char = gsl_permute_char(p : LibC::SizeT*, data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_char_inverse = gsl_permute_char_inverse(p : LibC::SizeT*, data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_complex = gsl_permute_complex(p : LibC::SizeT*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_complex_inverse = gsl_permute_complex_inverse(p : LibC::SizeT*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_complex_float = gsl_permute_complex_float(p : LibC::SizeT*, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_complex_float_inverse = gsl_permute_complex_float_inverse(p : LibC::SizeT*, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute = gsl_permute(p : LibC::SizeT*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_inverse = gsl_permute_inverse(p : LibC::SizeT*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_float = gsl_permute_float(p : LibC::SizeT*, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_float_inverse = gsl_permute_float_inverse(p : LibC::SizeT*, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  # fun permute_complex_long_double = gsl_permute_complex_long_double(p : LibC::SizeT*, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  # fun permute_complex_long_double_inverse = gsl_permute_complex_long_double_inverse(p : LibC::SizeT*, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  # fun permute_long_double = gsl_permute_long_double(p : LibC::SizeT*, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  # fun permute_long_double_inverse = gsl_permute_long_double_inverse(p : LibC::SizeT*, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_ulong = gsl_permute_ulong(p : LibC::SizeT*, data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_ulong_inverse = gsl_permute_ulong_inverse(p : LibC::SizeT*, data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_long = gsl_permute_long(p : LibC::SizeT*, data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_long_inverse = gsl_permute_long_inverse(p : LibC::SizeT*, data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_uint = gsl_permute_uint(p : LibC::SizeT*, data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_uint_inverse = gsl_permute_uint_inverse(p : LibC::SizeT*, data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_int = gsl_permute_int(p : LibC::SizeT*, data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_int_inverse = gsl_permute_int_inverse(p : LibC::SizeT*, data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_ushort = gsl_permute_ushort(p : LibC::SizeT*, data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_ushort_inverse = gsl_permute_ushort_inverse(p : LibC::SizeT*, data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_short = gsl_permute_short(p : LibC::SizeT*, data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_short_inverse = gsl_permute_short_inverse(p : LibC::SizeT*, data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_uchar = gsl_permute_uchar(p : LibC::SizeT*, data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_uchar_inverse = gsl_permute_uchar_inverse(p : LibC::SizeT*, data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun permute_matrix_char = gsl_permute_matrix_char(p : Permutation*, a : MatrixChar*) : LibC::Int
  fun permute_matrix_complex = gsl_permute_matrix_complex(p : Permutation*, a : MatrixComplex*) : LibC::Int
  fun permute_matrix_complex_float = gsl_permute_matrix_complex_float(p : Permutation*, a : MatrixComplexFloat*) : LibC::Int
  fun permute_matrix = gsl_permute_matrix(p : Permutation*, a : Matrix*) : LibC::Int
  fun permute_matrix_float = gsl_permute_matrix_float(p : Permutation*, a : MatrixFloat*) : LibC::Int
  # fun permute_matrix_complex_long_double = gsl_permute_matrix_complex_long_double(p : Permutation*, a : MatrixComplexLongDouble*) : LibC::Int
  # fun permute_matrix_long_double = gsl_permute_matrix_long_double(p : Permutation*, a : MatrixLongDouble*) : LibC::Int
  fun permute_matrix_ulong = gsl_permute_matrix_ulong(p : Permutation*, a : MatrixUlong*) : LibC::Int
  fun permute_matrix_long = gsl_permute_matrix_long(p : Permutation*, a : MatrixLong*) : LibC::Int
  fun permute_matrix_uint = gsl_permute_matrix_uint(p : Permutation*, a : MatrixUint*) : LibC::Int
  fun permute_matrix_int = gsl_permute_matrix_int(p : Permutation*, a : MatrixInt*) : LibC::Int
  fun permute_matrix_ushort = gsl_permute_matrix_ushort(p : Permutation*, a : MatrixUshort*) : LibC::Int
  fun permute_matrix_short = gsl_permute_matrix_short(p : Permutation*, a : MatrixShort*) : LibC::Int
  fun permute_matrix_uchar = gsl_permute_matrix_uchar(p : Permutation*, a : MatrixUchar*) : LibC::Int
  fun permute_vector_char = gsl_permute_vector_char(p : Permutation*, v : VectorChar*) : LibC::Int
  fun permute_vector_char_inverse = gsl_permute_vector_char_inverse(p : Permutation*, v : VectorChar*) : LibC::Int
  fun permute_vector_complex = gsl_permute_vector_complex(p : Permutation*, v : VectorComplex*) : LibC::Int
  fun permute_vector_complex_inverse = gsl_permute_vector_complex_inverse(p : Permutation*, v : VectorComplex*) : LibC::Int
  fun permute_vector_complex_float = gsl_permute_vector_complex_float(p : Permutation*, v : VectorComplexFloat*) : LibC::Int
  fun permute_vector_complex_float_inverse = gsl_permute_vector_complex_float_inverse(p : Permutation*, v : VectorComplexFloat*) : LibC::Int
  fun permute_vector = gsl_permute_vector(p : Permutation*, v : Vector*) : LibC::Int
  fun permute_vector_inverse = gsl_permute_vector_inverse(p : Permutation*, v : Vector*) : LibC::Int
  fun permute_vector_float = gsl_permute_vector_float(p : Permutation*, v : VectorFloat*) : LibC::Int
  fun permute_vector_float_inverse = gsl_permute_vector_float_inverse(p : Permutation*, v : VectorFloat*) : LibC::Int
  # fun permute_vector_complex_long_double = gsl_permute_vector_complex_long_double(p : Permutation*, v : VectorComplexLongDouble*) : LibC::Int
  # fun permute_vector_complex_long_double_inverse = gsl_permute_vector_complex_long_double_inverse(p : Permutation*, v : VectorComplexLongDouble*) : LibC::Int
  # fun permute_vector_long_double = gsl_permute_vector_long_double(p : Permutation*, v : VectorLongDouble*) : LibC::Int
  # fun permute_vector_long_double_inverse = gsl_permute_vector_long_double_inverse(p : Permutation*, v : VectorLongDouble*) : LibC::Int
  fun permute_vector_ulong = gsl_permute_vector_ulong(p : Permutation*, v : VectorUlong*) : LibC::Int
  fun permute_vector_ulong_inverse = gsl_permute_vector_ulong_inverse(p : Permutation*, v : VectorUlong*) : LibC::Int
  fun permute_vector_long = gsl_permute_vector_long(p : Permutation*, v : VectorLong*) : LibC::Int
  fun permute_vector_long_inverse = gsl_permute_vector_long_inverse(p : Permutation*, v : VectorLong*) : LibC::Int
  fun permute_vector_uint = gsl_permute_vector_uint(p : Permutation*, v : VectorUint*) : LibC::Int
  fun permute_vector_uint_inverse = gsl_permute_vector_uint_inverse(p : Permutation*, v : VectorUint*) : LibC::Int
  fun permute_vector_int = gsl_permute_vector_int(p : Permutation*, v : VectorInt*) : LibC::Int
  fun permute_vector_int_inverse = gsl_permute_vector_int_inverse(p : Permutation*, v : VectorInt*) : LibC::Int
  fun permute_vector_ushort = gsl_permute_vector_ushort(p : Permutation*, v : VectorUshort*) : LibC::Int
  fun permute_vector_ushort_inverse = gsl_permute_vector_ushort_inverse(p : Permutation*, v : VectorUshort*) : LibC::Int
  fun permute_vector_short = gsl_permute_vector_short(p : Permutation*, v : VectorShort*) : LibC::Int
  fun permute_vector_short_inverse = gsl_permute_vector_short_inverse(p : Permutation*, v : VectorShort*) : LibC::Int
  fun permute_vector_uchar = gsl_permute_vector_uchar(p : Permutation*, v : VectorUchar*) : LibC::Int
  fun permute_vector_uchar_inverse = gsl_permute_vector_uchar_inverse(p : Permutation*, v : VectorUchar*) : LibC::Int
  fun poly_eval = gsl_poly_eval(c : LibC::Double*, len : LibC::Int, x : LibC::Double) : LibC::Double
  fun poly_complex_eval = gsl_poly_complex_eval(c : LibC::Double*, len : LibC::Int, z : Complex) : Complex
  fun complex_poly_complex_eval = gsl_complex_poly_complex_eval(c : Complex*, len : LibC::Int, z : Complex) : Complex
  fun poly_eval_derivs = gsl_poly_eval_derivs(c : LibC::Double*, lenc : LibC::SizeT, x : LibC::Double, res : LibC::Double*, lenres : LibC::SizeT) : LibC::Int
  fun poly_dd_init = gsl_poly_dd_init(dd : LibC::Double*, x : LibC::Double*, y : LibC::Double*, size : LibC::SizeT) : LibC::Int
  fun poly_dd_eval = gsl_poly_dd_eval(dd : LibC::Double*, xa : LibC::Double*, size : LibC::SizeT, x : LibC::Double) : LibC::Double
  fun poly_dd_taylor = gsl_poly_dd_taylor(c : LibC::Double*, xp : LibC::Double, dd : LibC::Double*, x : LibC::Double*, size : LibC::SizeT, w : LibC::Double*) : LibC::Int
  fun poly_dd_hermite_init = gsl_poly_dd_hermite_init(dd : LibC::Double*, z : LibC::Double*, xa : LibC::Double*, ya : LibC::Double*, dya : LibC::Double*, size : LibC::SizeT) : LibC::Int
  fun poly_solve_quadratic = gsl_poly_solve_quadratic(a : LibC::Double, b : LibC::Double, c : LibC::Double, x0 : LibC::Double*, x1 : LibC::Double*) : LibC::Int
  fun poly_complex_solve_quadratic = gsl_poly_complex_solve_quadratic(a : LibC::Double, b : LibC::Double, c : LibC::Double, z0 : Complex*, z1 : Complex*) : LibC::Int
  fun poly_solve_cubic = gsl_poly_solve_cubic(a : LibC::Double, b : LibC::Double, c : LibC::Double, x0 : LibC::Double*, x1 : LibC::Double*, x2 : LibC::Double*) : LibC::Int
  fun poly_complex_solve_cubic = gsl_poly_complex_solve_cubic(a : LibC::Double, b : LibC::Double, c : LibC::Double, z0 : Complex*, z1 : Complex*, z2 : Complex*) : LibC::Int
  fun poly_complex_workspace_alloc = gsl_poly_complex_workspace_alloc(n : LibC::SizeT) : PolyComplexWorkspace*

  struct PolyComplexWorkspace
    nc : LibC::SizeT
    matrix : LibC::Double*
  end

  fun poly_complex_workspace_free = gsl_poly_complex_workspace_free(w : PolyComplexWorkspace*)
  fun poly_complex_solve = gsl_poly_complex_solve(a : LibC::Double*, n : LibC::SizeT, w : PolyComplexWorkspace*, z : ComplexPackedPtr) : LibC::Int
  alias ComplexPackedPtr = LibC::Double*

  struct QrngType
    name : LibC::Char*
    max_dimension : LibC::UInt
    state_size : (LibC::UInt -> LibC::SizeT)
    init_state : (Void*, LibC::UInt -> LibC::Int)
    get : (Void*, LibC::UInt, LibC::Double* -> LibC::Int)
  end

  fun qrng_alloc = gsl_qrng_alloc(t : QrngType*, dimension : LibC::UInt) : Qrng*

  struct Qrng
    type : QrngType*
    dimension : LibC::UInt
    state_size : LibC::SizeT
    state : Void*
  end

  fun qrng_memcpy = gsl_qrng_memcpy(dest : Qrng*, src : Qrng*) : LibC::Int
  fun qrng_clone = gsl_qrng_clone(q : Qrng*) : Qrng*
  fun qrng_free = gsl_qrng_free(q : Qrng*)
  fun qrng_init = gsl_qrng_init(q : Qrng*)
  fun qrng_name = gsl_qrng_name(q : Qrng*) : LibC::Char*
  fun qrng_size = gsl_qrng_size(q : Qrng*) : LibC::SizeT
  fun qrng_state = gsl_qrng_state(q : Qrng*) : Void*
  fun qrng_get = gsl_qrng_get(q : Qrng*, x : LibC::Double*) : LibC::Int
  fun ran_bernoulli = gsl_ran_bernoulli(r : Rng*, p : LibC::Double) : LibC::UInt
  fun ran_bernoulli_pdf = gsl_ran_bernoulli_pdf(k : LibC::UInt, p : LibC::Double) : LibC::Double
  fun ran_beta = gsl_ran_beta(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_beta_pdf = gsl_ran_beta_pdf(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_binomial = gsl_ran_binomial(r : Rng*, p : LibC::Double, n : LibC::UInt) : LibC::UInt
  fun ran_binomial_knuth = gsl_ran_binomial_knuth(r : Rng*, p : LibC::Double, n : LibC::UInt) : LibC::UInt
  fun ran_binomial_tpe = gsl_ran_binomial_tpe(r : Rng*, p : LibC::Double, n : LibC::UInt) : LibC::UInt
  fun ran_binomial_pdf = gsl_ran_binomial_pdf(k : LibC::UInt, p : LibC::Double, n : LibC::UInt) : LibC::Double
  fun ran_exponential = gsl_ran_exponential(r : Rng*, mu : LibC::Double) : LibC::Double
  fun ran_exponential_pdf = gsl_ran_exponential_pdf(x : LibC::Double, mu : LibC::Double) : LibC::Double
  fun ran_exppow = gsl_ran_exppow(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_exppow_pdf = gsl_ran_exppow_pdf(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_cauchy = gsl_ran_cauchy(r : Rng*, a : LibC::Double) : LibC::Double
  fun ran_cauchy_pdf = gsl_ran_cauchy_pdf(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun ran_chisq = gsl_ran_chisq(r : Rng*, nu : LibC::Double) : LibC::Double
  fun ran_chisq_pdf = gsl_ran_chisq_pdf(x : LibC::Double, nu : LibC::Double) : LibC::Double
  fun ran_dirichlet = gsl_ran_dirichlet(r : Rng*, k : LibC::SizeT, alpha : LibC::Double*, theta : LibC::Double*)
  fun ran_dirichlet_pdf = gsl_ran_dirichlet_pdf(k : LibC::SizeT, alpha : LibC::Double*, theta : LibC::Double*) : LibC::Double
  fun ran_dirichlet_lnpdf = gsl_ran_dirichlet_lnpdf(k : LibC::SizeT, alpha : LibC::Double*, theta : LibC::Double*) : LibC::Double
  fun ran_erlang = gsl_ran_erlang(r : Rng*, a : LibC::Double, n : LibC::Double) : LibC::Double
  fun ran_erlang_pdf = gsl_ran_erlang_pdf(x : LibC::Double, a : LibC::Double, n : LibC::Double) : LibC::Double
  fun ran_fdist = gsl_ran_fdist(r : Rng*, nu1 : LibC::Double, nu2 : LibC::Double) : LibC::Double
  fun ran_fdist_pdf = gsl_ran_fdist_pdf(x : LibC::Double, nu1 : LibC::Double, nu2 : LibC::Double) : LibC::Double
  fun ran_flat = gsl_ran_flat(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_flat_pdf = gsl_ran_flat_pdf(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_gamma = gsl_ran_gamma(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_gamma_int = gsl_ran_gamma_int(r : Rng*, a : LibC::UInt) : LibC::Double
  fun ran_gamma_pdf = gsl_ran_gamma_pdf(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_gamma_mt = gsl_ran_gamma_mt(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_gamma_knuth = gsl_ran_gamma_knuth(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_gaussian = gsl_ran_gaussian(r : Rng*, sigma : LibC::Double) : LibC::Double
  fun ran_gaussian_ratio_method = gsl_ran_gaussian_ratio_method(r : Rng*, sigma : LibC::Double) : LibC::Double
  fun ran_gaussian_ziggurat = gsl_ran_gaussian_ziggurat(r : Rng*, sigma : LibC::Double) : LibC::Double
  fun ran_gaussian_pdf = gsl_ran_gaussian_pdf(x : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun ran_ugaussian = gsl_ran_ugaussian(r : Rng*) : LibC::Double
  fun ran_ugaussian_ratio_method = gsl_ran_ugaussian_ratio_method(r : Rng*) : LibC::Double
  fun ran_ugaussian_pdf = gsl_ran_ugaussian_pdf(x : LibC::Double) : LibC::Double
  fun ran_gaussian_tail = gsl_ran_gaussian_tail(r : Rng*, a : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun ran_gaussian_tail_pdf = gsl_ran_gaussian_tail_pdf(x : LibC::Double, a : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun ran_ugaussian_tail = gsl_ran_ugaussian_tail(r : Rng*, a : LibC::Double) : LibC::Double
  fun ran_ugaussian_tail_pdf = gsl_ran_ugaussian_tail_pdf(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun ran_bivariate_gaussian = gsl_ran_bivariate_gaussian(r : Rng*, sigma_x : LibC::Double, sigma_y : LibC::Double, rho : LibC::Double, x : LibC::Double*, y : LibC::Double*)
  fun ran_bivariate_gaussian_pdf = gsl_ran_bivariate_gaussian_pdf(x : LibC::Double, y : LibC::Double, sigma_x : LibC::Double, sigma_y : LibC::Double, rho : LibC::Double) : LibC::Double
  fun ran_multivariate_gaussian = gsl_ran_multivariate_gaussian(r : Rng*, mu : Vector*, l : Matrix*, result : Vector*) : LibC::Int
  fun ran_multivariate_gaussian_log_pdf = gsl_ran_multivariate_gaussian_log_pdf(x : Vector*, mu : Vector*, l : Matrix*, result : LibC::Double*, work : Vector*) : LibC::Int
  fun ran_multivariate_gaussian_pdf = gsl_ran_multivariate_gaussian_pdf(x : Vector*, mu : Vector*, l : Matrix*, result : LibC::Double*, work : Vector*) : LibC::Int
  fun ran_multivariate_gaussian_mean = gsl_ran_multivariate_gaussian_mean(x : Matrix*, mu_hat : Vector*) : LibC::Int
  fun ran_multivariate_gaussian_vcov = gsl_ran_multivariate_gaussian_vcov(x : Matrix*, sigma_hat : Matrix*) : LibC::Int
  fun ran_landau = gsl_ran_landau(r : Rng*) : LibC::Double
  fun ran_landau_pdf = gsl_ran_landau_pdf(x : LibC::Double) : LibC::Double
  fun ran_geometric = gsl_ran_geometric(r : Rng*, p : LibC::Double) : LibC::UInt
  fun ran_geometric_pdf = gsl_ran_geometric_pdf(k : LibC::UInt, p : LibC::Double) : LibC::Double
  fun ran_hypergeometric = gsl_ran_hypergeometric(r : Rng*, n1 : LibC::UInt, n2 : LibC::UInt, t : LibC::UInt) : LibC::UInt
  fun ran_hypergeometric_pdf = gsl_ran_hypergeometric_pdf(k : LibC::UInt, n1 : LibC::UInt, n2 : LibC::UInt, t : LibC::UInt) : LibC::Double
  fun ran_gumbel1 = gsl_ran_gumbel1(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_gumbel1_pdf = gsl_ran_gumbel1_pdf(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_gumbel2 = gsl_ran_gumbel2(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_gumbel2_pdf = gsl_ran_gumbel2_pdf(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_logistic = gsl_ran_logistic(r : Rng*, a : LibC::Double) : LibC::Double
  fun ran_logistic_pdf = gsl_ran_logistic_pdf(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun ran_lognormal = gsl_ran_lognormal(r : Rng*, zeta : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun ran_lognormal_pdf = gsl_ran_lognormal_pdf(x : LibC::Double, zeta : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun ran_logarithmic = gsl_ran_logarithmic(r : Rng*, p : LibC::Double) : LibC::UInt
  fun ran_logarithmic_pdf = gsl_ran_logarithmic_pdf(k : LibC::UInt, p : LibC::Double) : LibC::Double
  fun ran_multinomial = gsl_ran_multinomial(r : Rng*, k : LibC::SizeT, n : LibC::UInt, p : LibC::Double*, n : LibC::UInt*)
  fun ran_multinomial_pdf = gsl_ran_multinomial_pdf(k : LibC::SizeT, p : LibC::Double*, n : LibC::UInt*) : LibC::Double
  fun ran_multinomial_lnpdf = gsl_ran_multinomial_lnpdf(k : LibC::SizeT, p : LibC::Double*, n : LibC::UInt*) : LibC::Double
  fun ran_negative_binomial = gsl_ran_negative_binomial(r : Rng*, p : LibC::Double, n : LibC::Double) : LibC::UInt
  fun ran_negative_binomial_pdf = gsl_ran_negative_binomial_pdf(k : LibC::UInt, p : LibC::Double, n : LibC::Double) : LibC::Double
  fun ran_pascal = gsl_ran_pascal(r : Rng*, p : LibC::Double, n : LibC::UInt) : LibC::UInt
  fun ran_pascal_pdf = gsl_ran_pascal_pdf(k : LibC::UInt, p : LibC::Double, n : LibC::UInt) : LibC::Double
  fun ran_pareto = gsl_ran_pareto(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_pareto_pdf = gsl_ran_pareto_pdf(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_poisson = gsl_ran_poisson(r : Rng*, mu : LibC::Double) : LibC::UInt
  fun ran_poisson_array = gsl_ran_poisson_array(r : Rng*, n : LibC::SizeT, array : LibC::UInt*, mu : LibC::Double)
  fun ran_poisson_pdf = gsl_ran_poisson_pdf(k : LibC::UInt, mu : LibC::Double) : LibC::Double
  fun ran_rayleigh = gsl_ran_rayleigh(r : Rng*, sigma : LibC::Double) : LibC::Double
  fun ran_rayleigh_pdf = gsl_ran_rayleigh_pdf(x : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun ran_rayleigh_tail = gsl_ran_rayleigh_tail(r : Rng*, a : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun ran_rayleigh_tail_pdf = gsl_ran_rayleigh_tail_pdf(x : LibC::Double, a : LibC::Double, sigma : LibC::Double) : LibC::Double
  fun ran_tdist = gsl_ran_tdist(r : Rng*, nu : LibC::Double) : LibC::Double
  fun ran_tdist_pdf = gsl_ran_tdist_pdf(x : LibC::Double, nu : LibC::Double) : LibC::Double
  fun ran_laplace = gsl_ran_laplace(r : Rng*, a : LibC::Double) : LibC::Double
  fun ran_laplace_pdf = gsl_ran_laplace_pdf(x : LibC::Double, a : LibC::Double) : LibC::Double
  fun ran_levy = gsl_ran_levy(r : Rng*, c : LibC::Double, alpha : LibC::Double) : LibC::Double
  fun ran_levy_skew = gsl_ran_levy_skew(r : Rng*, c : LibC::Double, alpha : LibC::Double, beta : LibC::Double) : LibC::Double
  fun ran_weibull = gsl_ran_weibull(r : Rng*, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_weibull_pdf = gsl_ran_weibull_pdf(x : LibC::Double, a : LibC::Double, b : LibC::Double) : LibC::Double
  fun ran_dir_2d = gsl_ran_dir_2d(r : Rng*, x : LibC::Double*, y : LibC::Double*)
  fun ran_dir_2d_trig_method = gsl_ran_dir_2d_trig_method(r : Rng*, x : LibC::Double*, y : LibC::Double*)
  fun ran_dir_3d = gsl_ran_dir_3d(r : Rng*, x : LibC::Double*, y : LibC::Double*, z : LibC::Double*)
  fun ran_dir_nd = gsl_ran_dir_nd(r : Rng*, n : LibC::SizeT, x : LibC::Double*)
  fun ran_shuffle = gsl_ran_shuffle(r : Rng*, base : Void*, nmembm : LibC::SizeT, size : LibC::SizeT)
  fun ran_choose = gsl_ran_choose(r : Rng*, dest : Void*, k : LibC::SizeT, src : Void*, n : LibC::SizeT, size : LibC::SizeT) : LibC::Int
  fun ran_sample = gsl_ran_sample(r : Rng*, dest : Void*, k : LibC::SizeT, src : Void*, n : LibC::SizeT, size : LibC::SizeT)
  fun ran_discrete_preproc = gsl_ran_discrete_preproc(k : LibC::SizeT, p : LibC::Double*) : RanDiscreteT*

  struct RanDiscreteT
    k : LibC::SizeT
    a : LibC::SizeT*
    f : LibC::Double*
  end

  fun ran_discrete_free = gsl_ran_discrete_free(g : RanDiscreteT*)
  fun ran_discrete = gsl_ran_discrete(r : Rng*, g : RanDiscreteT*) : LibC::SizeT
  fun ran_discrete_pdf = gsl_ran_discrete_pdf(k : LibC::SizeT, g : RanDiscreteT*) : LibC::Double
  fun root_fsolver_alloc = gsl_root_fsolver_alloc(t : RootFsolverType*) : RootFsolver*

  struct RootFsolverType
    name : LibC::Char*
    size : LibC::SizeT
    set : (Void*, Function*, LibC::Double*, LibC::Double, LibC::Double -> LibC::Int)
    iterate : (Void*, Function*, LibC::Double*, LibC::Double*, LibC::Double* -> LibC::Int)
  end

  struct RootFsolver
    type : RootFsolverType*
    function : Function*
    root : LibC::Double
    x_lower : LibC::Double
    x_upper : LibC::Double
    state : Void*
  end

  fun root_fsolver_free = gsl_root_fsolver_free(s : RootFsolver*)
  fun root_fsolver_set = gsl_root_fsolver_set(s : RootFsolver*, f : Function*, x_lower : LibC::Double, x_upper : LibC::Double) : LibC::Int
  fun root_fsolver_iterate = gsl_root_fsolver_iterate(s : RootFsolver*) : LibC::Int
  fun root_fsolver_name = gsl_root_fsolver_name(s : RootFsolver*) : LibC::Char*
  fun root_fsolver_root = gsl_root_fsolver_root(s : RootFsolver*) : LibC::Double
  fun root_fsolver_x_lower = gsl_root_fsolver_x_lower(s : RootFsolver*) : LibC::Double
  fun root_fsolver_x_upper = gsl_root_fsolver_x_upper(s : RootFsolver*) : LibC::Double
  fun root_fdfsolver_alloc = gsl_root_fdfsolver_alloc(t : RootFdfsolverType*) : RootFdfsolver*

  struct RootFdfsolverType
    name : LibC::Char*
    size : LibC::SizeT
    set : (Void*, FunctionFdf*, LibC::Double* -> LibC::Int)
    iterate : (Void*, FunctionFdf*, LibC::Double* -> LibC::Int)
  end

  type FunctionFdf = FunctionFdfStruct

  struct RootFdfsolver
    type : RootFdfsolverType*
    fdf : FunctionFdf*
    root : LibC::Double
    state : Void*
  end

  fun root_fdfsolver_set = gsl_root_fdfsolver_set(s : RootFdfsolver*, fdf : FunctionFdf*, root : LibC::Double) : LibC::Int
  fun root_fdfsolver_iterate = gsl_root_fdfsolver_iterate(s : RootFdfsolver*) : LibC::Int
  fun root_fdfsolver_free = gsl_root_fdfsolver_free(s : RootFdfsolver*)
  fun root_fdfsolver_name = gsl_root_fdfsolver_name(s : RootFdfsolver*) : LibC::Char*
  fun root_fdfsolver_root = gsl_root_fdfsolver_root(s : RootFdfsolver*) : LibC::Double
  fun root_test_interval = gsl_root_test_interval(x_lower : LibC::Double, x_upper : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double) : LibC::Int
  fun root_test_residual = gsl_root_test_residual(f : LibC::Double, epsabs : LibC::Double) : LibC::Int
  fun root_test_delta = gsl_root_test_delta(x1 : LibC::Double, x0 : LibC::Double, epsabs : LibC::Double, epsrel : LibC::Double) : LibC::Int
  fun rstat_quantile_alloc = gsl_rstat_quantile_alloc(p : LibC::Double) : RstatQuantileWorkspace*

  struct RstatQuantileWorkspace
    p : LibC::Double
    q : LibC::Double[5]
    npos : LibC::Int[5]
    np : LibC::Double[5]
    dnp : LibC::Double[5]
    n : LibC::SizeT
  end

  fun rstat_quantile_free = gsl_rstat_quantile_free(w : RstatQuantileWorkspace*)
  fun rstat_quantile_reset = gsl_rstat_quantile_reset(w : RstatQuantileWorkspace*) : LibC::Int
  fun rstat_quantile_add = gsl_rstat_quantile_add(x : LibC::Double, w : RstatQuantileWorkspace*) : LibC::Int
  fun rstat_quantile_get = gsl_rstat_quantile_get(w : RstatQuantileWorkspace*) : LibC::Double
  fun rstat_alloc = gsl_rstat_alloc : RstatWorkspace*

  struct RstatWorkspace
    min : LibC::Double
    max : LibC::Double
    mean : LibC::Double
    m2 : LibC::Double
    m3 : LibC::Double
    m4 : LibC::Double
    n : LibC::SizeT
    median_workspace_p : RstatQuantileWorkspace*
  end

  fun rstat_free = gsl_rstat_free(w : RstatWorkspace*)
  fun rstat_n = gsl_rstat_n(w : RstatWorkspace*) : LibC::SizeT
  fun rstat_add = gsl_rstat_add(x : LibC::Double, w : RstatWorkspace*) : LibC::Int
  fun rstat_min = gsl_rstat_min(w : RstatWorkspace*) : LibC::Double
  fun rstat_max = gsl_rstat_max(w : RstatWorkspace*) : LibC::Double
  fun rstat_mean = gsl_rstat_mean(w : RstatWorkspace*) : LibC::Double
  fun rstat_variance = gsl_rstat_variance(w : RstatWorkspace*) : LibC::Double
  fun rstat_sd = gsl_rstat_sd(w : RstatWorkspace*) : LibC::Double
  fun rstat_rms = gsl_rstat_rms(w : RstatWorkspace*) : LibC::Double
  fun rstat_sd_mean = gsl_rstat_sd_mean(w : RstatWorkspace*) : LibC::Double
  fun rstat_median = gsl_rstat_median(w : RstatWorkspace*) : LibC::Double
  fun rstat_skew = gsl_rstat_skew(w : RstatWorkspace*) : LibC::Double
  fun rstat_kurtosis = gsl_rstat_kurtosis(w : RstatWorkspace*) : LibC::Double
  fun rstat_reset = gsl_rstat_reset(w : RstatWorkspace*) : LibC::Int

  struct SfResultStruct
    val : LibC::Double
    err : LibC::Double
  end

  struct SfResultE10Struct
    val : LibC::Double
    err : LibC::Double
    e10 : LibC::Int
  end

  fun sf_result_smash_e = gsl_sf_result_smash_e(re : SfResultE10*, r : SfResult*) : LibC::Int
  type SfResultE10 = SfResultE10Struct
  type SfResult = SfResultStruct
  fun sf_airy_ai_e = gsl_sf_airy_Ai_e(x : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_airy_ai = gsl_sf_airy_Ai(x : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_airy_bi_e = gsl_sf_airy_Bi_e(x : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_airy_bi = gsl_sf_airy_Bi(x : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_airy_ai_scaled_e = gsl_sf_airy_Ai_scaled_e(x : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_airy_ai_scaled = gsl_sf_airy_Ai_scaled(x : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_airy_bi_scaled_e = gsl_sf_airy_Bi_scaled_e(x : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_airy_bi_scaled = gsl_sf_airy_Bi_scaled(x : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_airy_ai_deriv_e = gsl_sf_airy_Ai_deriv_e(x : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_airy_ai_deriv = gsl_sf_airy_Ai_deriv(x : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_airy_bi_deriv_e = gsl_sf_airy_Bi_deriv_e(x : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_airy_bi_deriv = gsl_sf_airy_Bi_deriv(x : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_airy_ai_deriv_scaled_e = gsl_sf_airy_Ai_deriv_scaled_e(x : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_airy_ai_deriv_scaled = gsl_sf_airy_Ai_deriv_scaled(x : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_airy_bi_deriv_scaled_e = gsl_sf_airy_Bi_deriv_scaled_e(x : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_airy_bi_deriv_scaled = gsl_sf_airy_Bi_deriv_scaled(x : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_airy_zero_ai_e = gsl_sf_airy_zero_Ai_e(s : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_airy_zero_ai = gsl_sf_airy_zero_Ai(s : LibC::UInt) : LibC::Double
  fun sf_airy_zero_bi_e = gsl_sf_airy_zero_Bi_e(s : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_airy_zero_bi = gsl_sf_airy_zero_Bi(s : LibC::UInt) : LibC::Double
  fun sf_airy_zero_ai_deriv_e = gsl_sf_airy_zero_Ai_deriv_e(s : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_airy_zero_ai_deriv = gsl_sf_airy_zero_Ai_deriv(s : LibC::UInt) : LibC::Double
  fun sf_airy_zero_bi_deriv_e = gsl_sf_airy_zero_Bi_deriv_e(s : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_airy_zero_bi_deriv = gsl_sf_airy_zero_Bi_deriv(s : LibC::UInt) : LibC::Double
  fun sf_bessel_j0_e = gsl_sf_bessel_J0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_j0 = gsl_sf_bessel_J0(x : LibC::Double) : LibC::Double
  fun sf_bessel_j1_e = gsl_sf_bessel_J1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_j1 = gsl_sf_bessel_J1(x : LibC::Double) : LibC::Double
  fun sf_bessel_jn_e = gsl_sf_bessel_Jn_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_jn = gsl_sf_bessel_Jn(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_jn_array = gsl_sf_bessel_Jn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_y0_e = gsl_sf_bessel_Y0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_y0 = gsl_sf_bessel_Y0(x : LibC::Double) : LibC::Double
  fun sf_bessel_y1_e = gsl_sf_bessel_Y1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_y1 = gsl_sf_bessel_Y1(x : LibC::Double) : LibC::Double
  fun sf_bessel_yn_e = gsl_sf_bessel_Yn_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_yn = gsl_sf_bessel_Yn(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_yn_array = gsl_sf_bessel_Yn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_i0_e = gsl_sf_bessel_I0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_i0 = gsl_sf_bessel_I0(x : LibC::Double) : LibC::Double
  fun sf_bessel_i1_e = gsl_sf_bessel_I1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_i1 = gsl_sf_bessel_I1(x : LibC::Double) : LibC::Double
  fun sf_bessel_in_e = gsl_sf_bessel_In_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_in = gsl_sf_bessel_In(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_in_array = gsl_sf_bessel_In_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_i0_scaled_e = gsl_sf_bessel_I0_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_i0_scaled = gsl_sf_bessel_I0_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_i1_scaled_e = gsl_sf_bessel_I1_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_i1_scaled = gsl_sf_bessel_I1_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_in_scaled_e = gsl_sf_bessel_In_scaled_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_in_scaled = gsl_sf_bessel_In_scaled(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_in_scaled_array = gsl_sf_bessel_In_scaled_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_k0_e = gsl_sf_bessel_K0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_k0 = gsl_sf_bessel_K0(x : LibC::Double) : LibC::Double
  fun sf_bessel_k1_e = gsl_sf_bessel_K1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_k1 = gsl_sf_bessel_K1(x : LibC::Double) : LibC::Double
  fun sf_bessel_kn_e = gsl_sf_bessel_Kn_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_kn = gsl_sf_bessel_Kn(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_kn_array = gsl_sf_bessel_Kn_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_k0_scaled_e = gsl_sf_bessel_K0_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_k0_scaled = gsl_sf_bessel_K0_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_k1_scaled_e = gsl_sf_bessel_K1_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_k1_scaled = gsl_sf_bessel_K1_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_kn_scaled_e = gsl_sf_bessel_Kn_scaled_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_kn_scaled = gsl_sf_bessel_Kn_scaled(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_kn_scaled_array = gsl_sf_bessel_Kn_scaled_array(nmin : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_j0_e = gsl_sf_bessel_j0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_j0 = gsl_sf_bessel_j0(x : LibC::Double) : LibC::Double
  fun sf_bessel_j1_e = gsl_sf_bessel_j1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_j1 = gsl_sf_bessel_j1(x : LibC::Double) : LibC::Double
  fun sf_bessel_j2_e = gsl_sf_bessel_j2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_j2 = gsl_sf_bessel_j2(x : LibC::Double) : LibC::Double
  fun sf_bessel_jl_e = gsl_sf_bessel_jl_e(l : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_jl = gsl_sf_bessel_jl(l : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_jl_array = gsl_sf_bessel_jl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_jl_steed_array = gsl_sf_bessel_jl_steed_array(lmax : LibC::Int, x : LibC::Double, jl_x_array : LibC::Double*) : LibC::Int
  fun sf_bessel_y0_e = gsl_sf_bessel_y0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_y0 = gsl_sf_bessel_y0(x : LibC::Double) : LibC::Double
  fun sf_bessel_y1_e = gsl_sf_bessel_y1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_y1 = gsl_sf_bessel_y1(x : LibC::Double) : LibC::Double
  fun sf_bessel_y2_e = gsl_sf_bessel_y2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_y2 = gsl_sf_bessel_y2(x : LibC::Double) : LibC::Double
  fun sf_bessel_yl_e = gsl_sf_bessel_yl_e(l : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_yl = gsl_sf_bessel_yl(l : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_yl_array = gsl_sf_bessel_yl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_i0_scaled_e = gsl_sf_bessel_i0_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_i0_scaled = gsl_sf_bessel_i0_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_i1_scaled_e = gsl_sf_bessel_i1_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_i1_scaled = gsl_sf_bessel_i1_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_i2_scaled_e = gsl_sf_bessel_i2_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_i2_scaled = gsl_sf_bessel_i2_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_il_scaled_e = gsl_sf_bessel_il_scaled_e(l : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_il_scaled = gsl_sf_bessel_il_scaled(l : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_il_scaled_array = gsl_sf_bessel_il_scaled_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_k0_scaled_e = gsl_sf_bessel_k0_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_k0_scaled = gsl_sf_bessel_k0_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_k1_scaled_e = gsl_sf_bessel_k1_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_k1_scaled = gsl_sf_bessel_k1_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_k2_scaled_e = gsl_sf_bessel_k2_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_k2_scaled = gsl_sf_bessel_k2_scaled(x : LibC::Double) : LibC::Double
  fun sf_bessel_kl_scaled_e = gsl_sf_bessel_kl_scaled_e(l : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_kl_scaled = gsl_sf_bessel_kl_scaled(l : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_bessel_kl_scaled_array = gsl_sf_bessel_kl_scaled_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_bessel_jnu_e = gsl_sf_bessel_Jnu_e(nu : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_jnu = gsl_sf_bessel_Jnu(nu : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_bessel_ynu_e = gsl_sf_bessel_Ynu_e(nu : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_ynu = gsl_sf_bessel_Ynu(nu : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_bessel_sequence_jnu_e = gsl_sf_bessel_sequence_Jnu_e(nu : LibC::Double, mode : ModeT, size : LibC::SizeT, v : LibC::Double*) : LibC::Int
  fun sf_bessel_inu_scaled_e = gsl_sf_bessel_Inu_scaled_e(nu : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_inu_scaled = gsl_sf_bessel_Inu_scaled(nu : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_bessel_inu_e = gsl_sf_bessel_Inu_e(nu : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_inu = gsl_sf_bessel_Inu(nu : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_bessel_knu_scaled_e = gsl_sf_bessel_Knu_scaled_e(nu : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_knu_scaled = gsl_sf_bessel_Knu_scaled(nu : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_bessel_knu_scaled_e10_e = gsl_sf_bessel_Knu_scaled_e10_e(nu : LibC::Double, x : LibC::Double, result : SfResultE10*) : LibC::Int
  fun sf_bessel_knu_e = gsl_sf_bessel_Knu_e(nu : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_knu = gsl_sf_bessel_Knu(nu : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_bessel_ln_knu_e = gsl_sf_bessel_lnKnu_e(nu : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_bessel_ln_knu = gsl_sf_bessel_lnKnu(nu : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_bessel_zero_j0_e = gsl_sf_bessel_zero_J0_e(s : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_bessel_zero_j0 = gsl_sf_bessel_zero_J0(s : LibC::UInt) : LibC::Double
  fun sf_bessel_zero_j1_e = gsl_sf_bessel_zero_J1_e(s : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_bessel_zero_j1 = gsl_sf_bessel_zero_J1(s : LibC::UInt) : LibC::Double
  fun sf_bessel_zero_jnu_e = gsl_sf_bessel_zero_Jnu_e(nu : LibC::Double, s : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_bessel_zero_jnu = gsl_sf_bessel_zero_Jnu(nu : LibC::Double, s : LibC::UInt) : LibC::Double
  fun sf_clausen_e = gsl_sf_clausen_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_clausen = gsl_sf_clausen(x : LibC::Double) : LibC::Double
  fun sf_hydrogenic_r_1_e = gsl_sf_hydrogenicR_1_e(z : LibC::Double, r : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hydrogenic_r_1 = gsl_sf_hydrogenicR_1(z : LibC::Double, r : LibC::Double) : LibC::Double
  fun sf_hydrogenic_r_e = gsl_sf_hydrogenicR_e(n : LibC::Int, l : LibC::Int, z : LibC::Double, r : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hydrogenic_r = gsl_sf_hydrogenicR(n : LibC::Int, l : LibC::Int, z : LibC::Double, r : LibC::Double) : LibC::Double
  fun sf_coulomb_wave_fg_e = gsl_sf_coulomb_wave_FG_e(eta : LibC::Double, x : LibC::Double, lam_f : LibC::Double, k_lam_g : LibC::Int, f : SfResult*, fp : SfResult*, g : SfResult*, gp : SfResult*, exp_f : LibC::Double*, exp_g : LibC::Double*) : LibC::Int
  fun sf_coulomb_wave_f_array = gsl_sf_coulomb_wave_F_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, f_exponent : LibC::Double*) : LibC::Int
  fun sf_coulomb_wave_fg_array = gsl_sf_coulomb_wave_FG_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, gc_array : LibC::Double*, f_exponent : LibC::Double*, g_exponent : LibC::Double*) : LibC::Int
  fun sf_coulomb_wave_f_gp_array = gsl_sf_coulomb_wave_FGp_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, fcp_array : LibC::Double*, gc_array : LibC::Double*, gcp_array : LibC::Double*, f_exponent : LibC::Double*, g_exponent : LibC::Double*) : LibC::Int
  fun sf_coulomb_wave_sph_f_array = gsl_sf_coulomb_wave_sphF_array(lam_min : LibC::Double, kmax : LibC::Int, eta : LibC::Double, x : LibC::Double, fc_array : LibC::Double*, f_exponent : LibC::Double*) : LibC::Int
  fun sf_coulomb_cl_e = gsl_sf_coulomb_CL_e(l : LibC::Double, eta : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_coulomb_cl_array = gsl_sf_coulomb_CL_array(lmin : LibC::Double, kmax : LibC::Int, eta : LibC::Double, cl : LibC::Double*) : LibC::Int
  fun sf_coupling_3j_e = gsl_sf_coupling_3j_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_ma : LibC::Int, two_mb : LibC::Int, two_mc : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_coupling_3j = gsl_sf_coupling_3j(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_ma : LibC::Int, two_mb : LibC::Int, two_mc : LibC::Int) : LibC::Double
  fun sf_coupling_6j_e = gsl_sf_coupling_6j_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_coupling_6j = gsl_sf_coupling_6j(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int) : LibC::Double
  fun sf_coupling_racah_w_e = gsl_sf_coupling_RacahW_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_coupling_racah_w = gsl_sf_coupling_RacahW(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int) : LibC::Double
  fun sf_coupling_9j_e = gsl_sf_coupling_9j_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, two_jg : LibC::Int, two_jh : LibC::Int, two_ji : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_coupling_9j = gsl_sf_coupling_9j(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, two_jg : LibC::Int, two_jh : LibC::Int, two_ji : LibC::Int) : LibC::Double
  fun sf_coupling_6j_incorrect_e = gsl_sf_coupling_6j_INCORRECT_e(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_coupling_6j_incorrect = gsl_sf_coupling_6j_INCORRECT(two_ja : LibC::Int, two_jb : LibC::Int, two_jc : LibC::Int, two_jd : LibC::Int, two_je : LibC::Int, two_jf : LibC::Int) : LibC::Double
  fun sf_dawson_e = gsl_sf_dawson_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_dawson = gsl_sf_dawson(x : LibC::Double) : LibC::Double
  fun sf_debye_1_e = gsl_sf_debye_1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_debye_1 = gsl_sf_debye_1(x : LibC::Double) : LibC::Double
  fun sf_debye_2_e = gsl_sf_debye_2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_debye_2 = gsl_sf_debye_2(x : LibC::Double) : LibC::Double
  fun sf_debye_3_e = gsl_sf_debye_3_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_debye_3 = gsl_sf_debye_3(x : LibC::Double) : LibC::Double
  fun sf_debye_4_e = gsl_sf_debye_4_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_debye_4 = gsl_sf_debye_4(x : LibC::Double) : LibC::Double
  fun sf_debye_5_e = gsl_sf_debye_5_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_debye_5 = gsl_sf_debye_5(x : LibC::Double) : LibC::Double
  fun sf_debye_6_e = gsl_sf_debye_6_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_debye_6 = gsl_sf_debye_6(x : LibC::Double) : LibC::Double
  fun sf_dilog_e = gsl_sf_dilog_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_dilog = gsl_sf_dilog(x : LibC::Double) : LibC::Double
  fun sf_complex_dilog_xy_e = gsl_sf_complex_dilog_xy_e(x : LibC::Double, y : LibC::Double, result_re : SfResult*, result_im : SfResult*) : LibC::Int
  fun sf_complex_dilog_e = gsl_sf_complex_dilog_e(r : LibC::Double, theta : LibC::Double, result_re : SfResult*, result_im : SfResult*) : LibC::Int
  fun sf_complex_spence_xy_e = gsl_sf_complex_spence_xy_e(x : LibC::Double, y : LibC::Double, real_sp : SfResult*, imag_sp : SfResult*) : LibC::Int
  fun sf_multiply_e = gsl_sf_multiply_e(x : LibC::Double, y : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_multiply = gsl_sf_multiply(x : LibC::Double, y : LibC::Double) : LibC::Double
  fun sf_multiply_err_e = gsl_sf_multiply_err_e(x : LibC::Double, dx : LibC::Double, y : LibC::Double, dy : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_ellint_kcomp_e = gsl_sf_ellint_Kcomp_e(k : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_kcomp = gsl_sf_ellint_Kcomp(k : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_ecomp_e = gsl_sf_ellint_Ecomp_e(k : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_ecomp = gsl_sf_ellint_Ecomp(k : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_pcomp_e = gsl_sf_ellint_Pcomp_e(k : LibC::Double, n : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_pcomp = gsl_sf_ellint_Pcomp(k : LibC::Double, n : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_dcomp_e = gsl_sf_ellint_Dcomp_e(k : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_dcomp = gsl_sf_ellint_Dcomp(k : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_f_e = gsl_sf_ellint_F_e(phi : LibC::Double, k : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_f = gsl_sf_ellint_F(phi : LibC::Double, k : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_e_e = gsl_sf_ellint_E_e(phi : LibC::Double, k : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_e = gsl_sf_ellint_E(phi : LibC::Double, k : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_p_e = gsl_sf_ellint_P_e(phi : LibC::Double, k : LibC::Double, n : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_p = gsl_sf_ellint_P(phi : LibC::Double, k : LibC::Double, n : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_d_e = gsl_sf_ellint_D_e(phi : LibC::Double, k : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_d = gsl_sf_ellint_D(phi : LibC::Double, k : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_rc_e = gsl_sf_ellint_RC_e(x : LibC::Double, y : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_rc = gsl_sf_ellint_RC(x : LibC::Double, y : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_rd_e = gsl_sf_ellint_RD_e(x : LibC::Double, y : LibC::Double, z : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_rd = gsl_sf_ellint_RD(x : LibC::Double, y : LibC::Double, z : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_rf_e = gsl_sf_ellint_RF_e(x : LibC::Double, y : LibC::Double, z : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_rf = gsl_sf_ellint_RF(x : LibC::Double, y : LibC::Double, z : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_ellint_rj_e = gsl_sf_ellint_RJ_e(x : LibC::Double, y : LibC::Double, z : LibC::Double, p : LibC::Double, mode : ModeT, result : SfResult*) : LibC::Int
  fun sf_ellint_rj = gsl_sf_ellint_RJ(x : LibC::Double, y : LibC::Double, z : LibC::Double, p : LibC::Double, mode : ModeT) : LibC::Double
  fun sf_elljac_e = gsl_sf_elljac_e(u : LibC::Double, m : LibC::Double, sn : LibC::Double*, cn : LibC::Double*, dn : LibC::Double*) : LibC::Int
  fun sf_erfc_e = gsl_sf_erfc_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_erfc = gsl_sf_erfc(x : LibC::Double) : LibC::Double
  fun sf_log_erfc_e = gsl_sf_log_erfc_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_log_erfc = gsl_sf_log_erfc(x : LibC::Double) : LibC::Double
  fun sf_erf_e = gsl_sf_erf_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_erf = gsl_sf_erf(x : LibC::Double) : LibC::Double
  fun sf_erf_z_e = gsl_sf_erf_Z_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_erf_q_e = gsl_sf_erf_Q_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_erf_z = gsl_sf_erf_Z(x : LibC::Double) : LibC::Double
  fun sf_erf_q = gsl_sf_erf_Q(x : LibC::Double) : LibC::Double
  fun sf_hazard_e = gsl_sf_hazard_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hazard = gsl_sf_hazard(x : LibC::Double) : LibC::Double
  fun sf_exp_e = gsl_sf_exp_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_exp = gsl_sf_exp(x : LibC::Double) : LibC::Double
  fun sf_exp_e10_e = gsl_sf_exp_e10_e(x : LibC::Double, result : SfResultE10*) : LibC::Int
  fun sf_exp_mult_e = gsl_sf_exp_mult_e(x : LibC::Double, y : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_exp_mult = gsl_sf_exp_mult(x : LibC::Double, y : LibC::Double) : LibC::Double
  fun sf_exp_mult_e10_e = gsl_sf_exp_mult_e10_e(x : LibC::Double, y : LibC::Double, result : SfResultE10*) : LibC::Int
  fun sf_expm1_e = gsl_sf_expm1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expm1 = gsl_sf_expm1(x : LibC::Double) : LibC::Double
  fun sf_exprel_e = gsl_sf_exprel_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_exprel = gsl_sf_exprel(x : LibC::Double) : LibC::Double
  fun sf_exprel_2_e = gsl_sf_exprel_2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_exprel_2 = gsl_sf_exprel_2(x : LibC::Double) : LibC::Double
  fun sf_exprel_n_e = gsl_sf_exprel_n_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_exprel_n = gsl_sf_exprel_n(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_exprel_n_cf_e = gsl_sf_exprel_n_CF_e(n : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_exp_err_e = gsl_sf_exp_err_e(x : LibC::Double, dx : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_exp_err_e10_e = gsl_sf_exp_err_e10_e(x : LibC::Double, dx : LibC::Double, result : SfResultE10*) : LibC::Int
  fun sf_exp_mult_err_e = gsl_sf_exp_mult_err_e(x : LibC::Double, dx : LibC::Double, y : LibC::Double, dy : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_exp_mult_err_e10_e = gsl_sf_exp_mult_err_e10_e(x : LibC::Double, dx : LibC::Double, y : LibC::Double, dy : LibC::Double, result : SfResultE10*) : LibC::Int
  fun sf_expint_e1_e = gsl_sf_expint_E1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_e1 = gsl_sf_expint_E1(x : LibC::Double) : LibC::Double
  fun sf_expint_e2_e = gsl_sf_expint_E2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_e2 = gsl_sf_expint_E2(x : LibC::Double) : LibC::Double
  fun sf_expint_en_e = gsl_sf_expint_En_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_en = gsl_sf_expint_En(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_expint_e1_scaled_e = gsl_sf_expint_E1_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_e1_scaled = gsl_sf_expint_E1_scaled(x : LibC::Double) : LibC::Double
  fun sf_expint_e2_scaled_e = gsl_sf_expint_E2_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_e2_scaled = gsl_sf_expint_E2_scaled(x : LibC::Double) : LibC::Double
  fun sf_expint_en_scaled_e = gsl_sf_expint_En_scaled_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_en_scaled = gsl_sf_expint_En_scaled(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_expint_ei_e = gsl_sf_expint_Ei_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_ei = gsl_sf_expint_Ei(x : LibC::Double) : LibC::Double
  fun sf_expint_ei_scaled_e = gsl_sf_expint_Ei_scaled_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_ei_scaled = gsl_sf_expint_Ei_scaled(x : LibC::Double) : LibC::Double
  fun sf_shi_e = gsl_sf_Shi_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_shi = gsl_sf_Shi(x : LibC::Double) : LibC::Double
  fun sf_chi_e = gsl_sf_Chi_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_chi = gsl_sf_Chi(x : LibC::Double) : LibC::Double
  fun sf_expint_3_e = gsl_sf_expint_3_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_expint_3 = gsl_sf_expint_3(x : LibC::Double) : LibC::Double
  fun sf_si_e = gsl_sf_Si_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_si = gsl_sf_Si(x : LibC::Double) : LibC::Double
  fun sf_ci_e = gsl_sf_Ci_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_ci = gsl_sf_Ci(x : LibC::Double) : LibC::Double
  fun sf_atanint_e = gsl_sf_atanint_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_atanint = gsl_sf_atanint(x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_m1_e = gsl_sf_fermi_dirac_m1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_m1 = gsl_sf_fermi_dirac_m1(x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_0_e = gsl_sf_fermi_dirac_0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_0 = gsl_sf_fermi_dirac_0(x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_1_e = gsl_sf_fermi_dirac_1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_1 = gsl_sf_fermi_dirac_1(x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_2_e = gsl_sf_fermi_dirac_2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_2 = gsl_sf_fermi_dirac_2(x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_int_e = gsl_sf_fermi_dirac_int_e(j : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_int = gsl_sf_fermi_dirac_int(j : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_mhalf_e = gsl_sf_fermi_dirac_mhalf_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_mhalf = gsl_sf_fermi_dirac_mhalf(x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_half_e = gsl_sf_fermi_dirac_half_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_half = gsl_sf_fermi_dirac_half(x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_3half_e = gsl_sf_fermi_dirac_3half_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_3half = gsl_sf_fermi_dirac_3half(x : LibC::Double) : LibC::Double
  fun sf_fermi_dirac_inc_0_e = gsl_sf_fermi_dirac_inc_0_e(x : LibC::Double, b : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_fermi_dirac_inc_0 = gsl_sf_fermi_dirac_inc_0(x : LibC::Double, b : LibC::Double) : LibC::Double
  fun sf_lngamma_e = gsl_sf_lngamma_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_lngamma = gsl_sf_lngamma(x : LibC::Double) : LibC::Double
  fun sf_lngamma_sgn_e = gsl_sf_lngamma_sgn_e(x : LibC::Double, result_lg : SfResult*, sgn : LibC::Double*) : LibC::Int
  fun sf_gamma_e = gsl_sf_gamma_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gamma = gsl_sf_gamma(x : LibC::Double) : LibC::Double
  fun sf_gammastar_e = gsl_sf_gammastar_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gammastar = gsl_sf_gammastar(x : LibC::Double) : LibC::Double
  fun sf_gammainv_e = gsl_sf_gammainv_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gammainv = gsl_sf_gammainv(x : LibC::Double) : LibC::Double
  fun sf_lngamma_complex_e = gsl_sf_lngamma_complex_e(zr : LibC::Double, zi : LibC::Double, lnr : SfResult*, arg : SfResult*) : LibC::Int
  fun sf_taylorcoeff_e = gsl_sf_taylorcoeff_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_taylorcoeff = gsl_sf_taylorcoeff(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_fact_e = gsl_sf_fact_e(n : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_fact = gsl_sf_fact(n : LibC::UInt) : LibC::Double
  fun sf_doublefact_e = gsl_sf_doublefact_e(n : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_doublefact = gsl_sf_doublefact(n : LibC::UInt) : LibC::Double
  fun sf_lnfact_e = gsl_sf_lnfact_e(n : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_lnfact = gsl_sf_lnfact(n : LibC::UInt) : LibC::Double
  fun sf_lndoublefact_e = gsl_sf_lndoublefact_e(n : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_lndoublefact = gsl_sf_lndoublefact(n : LibC::UInt) : LibC::Double
  fun sf_lnchoose_e = gsl_sf_lnchoose_e(n : LibC::UInt, m : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_lnchoose = gsl_sf_lnchoose(n : LibC::UInt, m : LibC::UInt) : LibC::Double
  fun sf_choose_e = gsl_sf_choose_e(n : LibC::UInt, m : LibC::UInt, result : SfResult*) : LibC::Int
  fun sf_choose = gsl_sf_choose(n : LibC::UInt, m : LibC::UInt) : LibC::Double
  fun sf_lnpoch_e = gsl_sf_lnpoch_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_lnpoch = gsl_sf_lnpoch(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_lnpoch_sgn_e = gsl_sf_lnpoch_sgn_e(a : LibC::Double, x : LibC::Double, result : SfResult*, sgn : LibC::Double*) : LibC::Int
  fun sf_poch_e = gsl_sf_poch_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_poch = gsl_sf_poch(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_pochrel_e = gsl_sf_pochrel_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_pochrel = gsl_sf_pochrel(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_gamma_inc_q_e = gsl_sf_gamma_inc_Q_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gamma_inc_q = gsl_sf_gamma_inc_Q(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_gamma_inc_p_e = gsl_sf_gamma_inc_P_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gamma_inc_p = gsl_sf_gamma_inc_P(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_gamma_inc_e = gsl_sf_gamma_inc_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gamma_inc = gsl_sf_gamma_inc(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_lnbeta_e = gsl_sf_lnbeta_e(a : LibC::Double, b : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_lnbeta = gsl_sf_lnbeta(a : LibC::Double, b : LibC::Double) : LibC::Double
  fun sf_lnbeta_sgn_e = gsl_sf_lnbeta_sgn_e(x : LibC::Double, y : LibC::Double, result : SfResult*, sgn : LibC::Double*) : LibC::Int
  fun sf_beta_e = gsl_sf_beta_e(a : LibC::Double, b : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_beta = gsl_sf_beta(a : LibC::Double, b : LibC::Double) : LibC::Double
  fun sf_beta_inc_e = gsl_sf_beta_inc_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_beta_inc = gsl_sf_beta_inc(a : LibC::Double, b : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_gegenpoly_1_e = gsl_sf_gegenpoly_1_e(lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gegenpoly_2_e = gsl_sf_gegenpoly_2_e(lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gegenpoly_3_e = gsl_sf_gegenpoly_3_e(lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gegenpoly_1 = gsl_sf_gegenpoly_1(lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_gegenpoly_2 = gsl_sf_gegenpoly_2(lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_gegenpoly_3 = gsl_sf_gegenpoly_3(lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_gegenpoly_n_e = gsl_sf_gegenpoly_n_e(n : LibC::Int, lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_gegenpoly_n = gsl_sf_gegenpoly_n(n : LibC::Int, lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_gegenpoly_array = gsl_sf_gegenpoly_array(nmax : LibC::Int, lambda : LibC::Double, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_hermite_prob_e = gsl_sf_hermite_prob_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hermite_prob = gsl_sf_hermite_prob(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_hermite_prob_der_e = gsl_sf_hermite_prob_der_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hermite_prob_der = gsl_sf_hermite_prob_der(m : LibC::Int, n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_hermite_phys_e = gsl_sf_hermite_phys_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hermite_phys = gsl_sf_hermite_phys(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_hermite_phys_der_e = gsl_sf_hermite_phys_der_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hermite_phys_der = gsl_sf_hermite_phys_der(m : LibC::Int, n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_hermite_func_e = gsl_sf_hermite_func_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hermite_func = gsl_sf_hermite_func(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_hermite_prob_array = gsl_sf_hermite_prob_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_hermite_prob_array_der = gsl_sf_hermite_prob_array_der(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_hermite_prob_der_array = gsl_sf_hermite_prob_der_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_hermite_prob_series_e = gsl_sf_hermite_prob_series_e(n : LibC::Int, x : LibC::Double, a : LibC::Double*, result : SfResult*) : LibC::Int
  fun sf_hermite_prob_series = gsl_sf_hermite_prob_series(n : LibC::Int, x : LibC::Double, a : LibC::Double*) : LibC::Double
  fun sf_hermite_phys_array = gsl_sf_hermite_phys_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_hermite_phys_array_der = gsl_sf_hermite_phys_array_der(m : LibC::Int, nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_hermite_phys_der_array = gsl_sf_hermite_phys_der_array(mmax : LibC::Int, n : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_hermite_phys_series_e = gsl_sf_hermite_phys_series_e(n : LibC::Int, x : LibC::Double, a : LibC::Double*, result : SfResult*) : LibC::Int
  fun sf_hermite_phys_series = gsl_sf_hermite_phys_series(n : LibC::Int, x : LibC::Double, a : LibC::Double*) : LibC::Double
  fun sf_hermite_func_array = gsl_sf_hermite_func_array(nmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_hermite_func_series_e = gsl_sf_hermite_func_series_e(n : LibC::Int, x : LibC::Double, a : LibC::Double*, result : SfResult*) : LibC::Int
  fun sf_hermite_func_series = gsl_sf_hermite_func_series(n : LibC::Int, x : LibC::Double, a : LibC::Double*) : LibC::Double
  fun sf_hermite_func_der_e = gsl_sf_hermite_func_der_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hermite_func_der = gsl_sf_hermite_func_der(m : LibC::Int, n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_hermite_prob_zero_e = gsl_sf_hermite_prob_zero_e(n : LibC::Int, s : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_hermite_prob_zero = gsl_sf_hermite_prob_zero(n : LibC::Int, s : LibC::Int) : LibC::Double
  fun sf_hermite_phys_zero_e = gsl_sf_hermite_phys_zero_e(n : LibC::Int, s : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_hermite_phys_zero = gsl_sf_hermite_phys_zero(n : LibC::Int, s : LibC::Int) : LibC::Double
  fun sf_hermite_func_zero_e = gsl_sf_hermite_func_zero_e(n : LibC::Int, s : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_hermite_func_zero = gsl_sf_hermite_func_zero(n : LibC::Int, s : LibC::Int) : LibC::Double
  fun sf_hyperg_0_f1_e = gsl_sf_hyperg_0F1_e(c : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_0_f1 = gsl_sf_hyperg_0F1(c : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_hyperg_1_f1_int_e = gsl_sf_hyperg_1F1_int_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_1_f1_int = gsl_sf_hyperg_1F1_int(m : LibC::Int, n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_hyperg_1_f1_e = gsl_sf_hyperg_1F1_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_1_f1 = gsl_sf_hyperg_1F1(a : LibC::Double, b : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_hyperg_u_int_e = gsl_sf_hyperg_U_int_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_u_int = gsl_sf_hyperg_U_int(m : LibC::Int, n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_hyperg_u_int_e10_e = gsl_sf_hyperg_U_int_e10_e(m : LibC::Int, n : LibC::Int, x : LibC::Double, result : SfResultE10*) : LibC::Int
  fun sf_hyperg_u_e = gsl_sf_hyperg_U_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_u = gsl_sf_hyperg_U(a : LibC::Double, b : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_hyperg_u_e10_e = gsl_sf_hyperg_U_e10_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : SfResultE10*) : LibC::Int
  fun sf_hyperg_2_f1_e = gsl_sf_hyperg_2F1_e(a : LibC::Double, b : LibC::Double, c : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_2_f1 = gsl_sf_hyperg_2F1(a : LibC::Double, b : LibC::Double, c : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_hyperg_2_f1_conj_e = gsl_sf_hyperg_2F1_conj_e(a_r : LibC::Double, a_i : LibC::Double, c : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_2_f1_conj = gsl_sf_hyperg_2F1_conj(a_r : LibC::Double, a_i : LibC::Double, c : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_hyperg_2_f1_renorm_e = gsl_sf_hyperg_2F1_renorm_e(a : LibC::Double, b : LibC::Double, c : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_2_f1_renorm = gsl_sf_hyperg_2F1_renorm(a : LibC::Double, b : LibC::Double, c : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_hyperg_2_f1_conj_renorm_e = gsl_sf_hyperg_2F1_conj_renorm_e(a_r : LibC::Double, a_i : LibC::Double, c : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_2_f1_conj_renorm = gsl_sf_hyperg_2F1_conj_renorm(a_r : LibC::Double, a_i : LibC::Double, c : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_hyperg_2_f0_e = gsl_sf_hyperg_2F0_e(a : LibC::Double, b : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hyperg_2_f0 = gsl_sf_hyperg_2F0(a : LibC::Double, b : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_laguerre_1_e = gsl_sf_laguerre_1_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_laguerre_2_e = gsl_sf_laguerre_2_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_laguerre_3_e = gsl_sf_laguerre_3_e(a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_laguerre_1 = gsl_sf_laguerre_1(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_laguerre_2 = gsl_sf_laguerre_2(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_laguerre_3 = gsl_sf_laguerre_3(a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_laguerre_n_e = gsl_sf_laguerre_n_e(n : LibC::Int, a : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_laguerre_n = gsl_sf_laguerre_n(n : LibC::Int, a : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_lambert_w0_e = gsl_sf_lambert_W0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_lambert_w0 = gsl_sf_lambert_W0(x : LibC::Double) : LibC::Double
  fun sf_lambert_wm1_e = gsl_sf_lambert_Wm1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_lambert_wm1 = gsl_sf_lambert_Wm1(x : LibC::Double) : LibC::Double
  fun sf_legendre_pl_e = gsl_sf_legendre_Pl_e(l : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_pl = gsl_sf_legendre_Pl(l : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_legendre_pl_array = gsl_sf_legendre_Pl_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_legendre_pl_deriv_array = gsl_sf_legendre_Pl_deriv_array(lmax : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
  fun sf_legendre_p1_e = gsl_sf_legendre_P1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_p2_e = gsl_sf_legendre_P2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_p3_e = gsl_sf_legendre_P3_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_p1 = gsl_sf_legendre_P1(x : LibC::Double) : LibC::Double
  fun sf_legendre_p2 = gsl_sf_legendre_P2(x : LibC::Double) : LibC::Double
  fun sf_legendre_p3 = gsl_sf_legendre_P3(x : LibC::Double) : LibC::Double
  fun sf_legendre_q0_e = gsl_sf_legendre_Q0_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_q0 = gsl_sf_legendre_Q0(x : LibC::Double) : LibC::Double
  fun sf_legendre_q1_e = gsl_sf_legendre_Q1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_q1 = gsl_sf_legendre_Q1(x : LibC::Double) : LibC::Double
  fun sf_legendre_ql_e = gsl_sf_legendre_Ql_e(l : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_ql = gsl_sf_legendre_Ql(l : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_legendre_plm_e = gsl_sf_legendre_Plm_e(l : LibC::Int, m : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_plm = gsl_sf_legendre_Plm(l : LibC::Int, m : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_legendre_plm_array = gsl_sf_legendre_Plm_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_legendre_plm_deriv_array = gsl_sf_legendre_Plm_deriv_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
  fun sf_legendre_sph_plm_e = gsl_sf_legendre_sphPlm_e(l : LibC::Int, m : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_sph_plm = gsl_sf_legendre_sphPlm(l : LibC::Int, m : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_legendre_sph_plm_array = gsl_sf_legendre_sphPlm_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_legendre_sph_plm_deriv_array = gsl_sf_legendre_sphPlm_deriv_array(lmax : LibC::Int, m : LibC::Int, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
  fun sf_legendre_array_size = gsl_sf_legendre_array_size(lmax : LibC::Int, m : LibC::Int) : LibC::Int
  fun sf_conical_p_half_e = gsl_sf_conicalP_half_e(lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_conical_p_half = gsl_sf_conicalP_half(lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_conical_p_mhalf_e = gsl_sf_conicalP_mhalf_e(lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_conical_p_mhalf = gsl_sf_conicalP_mhalf(lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_conical_p_0_e = gsl_sf_conicalP_0_e(lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_conical_p_0 = gsl_sf_conicalP_0(lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_conical_p_1_e = gsl_sf_conicalP_1_e(lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_conical_p_1 = gsl_sf_conicalP_1(lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_conical_p_sph_reg_e = gsl_sf_conicalP_sph_reg_e(l : LibC::Int, lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_conical_p_sph_reg = gsl_sf_conicalP_sph_reg(l : LibC::Int, lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_conical_p_cyl_reg_e = gsl_sf_conicalP_cyl_reg_e(m : LibC::Int, lambda : LibC::Double, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_conical_p_cyl_reg = gsl_sf_conicalP_cyl_reg(m : LibC::Int, lambda : LibC::Double, x : LibC::Double) : LibC::Double
  fun sf_legendre_h3d_0_e = gsl_sf_legendre_H3d_0_e(lambda : LibC::Double, eta : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_h3d_0 = gsl_sf_legendre_H3d_0(lambda : LibC::Double, eta : LibC::Double) : LibC::Double
  fun sf_legendre_h3d_1_e = gsl_sf_legendre_H3d_1_e(lambda : LibC::Double, eta : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_h3d_1 = gsl_sf_legendre_H3d_1(lambda : LibC::Double, eta : LibC::Double) : LibC::Double
  fun sf_legendre_h3d_e = gsl_sf_legendre_H3d_e(l : LibC::Int, lambda : LibC::Double, eta : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_legendre_h3d = gsl_sf_legendre_H3d(l : LibC::Int, lambda : LibC::Double, eta : LibC::Double) : LibC::Double
  fun sf_legendre_h3d_array = gsl_sf_legendre_H3d_array(lmax : LibC::Int, lambda : LibC::Double, eta : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_legendre_array = gsl_sf_legendre_array(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*) : LibC::Int
  enum SfLegendreT
    GslSfLegendreSchmidt = 0
    GslSfLegendreSpharm  = 1
    GslSfLegendreFull    = 2
    GslSfLegendreNone    = 3
  end
  fun sf_legendre_array_e = gsl_sf_legendre_array_e(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*) : LibC::Int
  fun sf_legendre_deriv_array = gsl_sf_legendre_deriv_array(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
  fun sf_legendre_deriv_array_e = gsl_sf_legendre_deriv_array_e(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
  fun sf_legendre_deriv_alt_array = gsl_sf_legendre_deriv_alt_array(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
  fun sf_legendre_deriv_alt_array_e = gsl_sf_legendre_deriv_alt_array_e(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*) : LibC::Int
  fun sf_legendre_deriv2_array = gsl_sf_legendre_deriv2_array(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
  fun sf_legendre_deriv2_array_e = gsl_sf_legendre_deriv2_array_e(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
  fun sf_legendre_deriv2_alt_array = gsl_sf_legendre_deriv2_alt_array(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
  fun sf_legendre_deriv2_alt_array_e = gsl_sf_legendre_deriv2_alt_array_e(norm : SfLegendreT, lmax : LibC::SizeT, x : LibC::Double, csphase : LibC::Double, result_array : LibC::Double*, result_deriv_array : LibC::Double*, result_deriv2_array : LibC::Double*) : LibC::Int
  fun sf_legendre_array_n = gsl_sf_legendre_array_n(lmax : LibC::SizeT) : LibC::SizeT
  fun sf_legendre_array_index = gsl_sf_legendre_array_index(l : LibC::SizeT, m : LibC::SizeT) : LibC::SizeT
  fun sf_legendre_nlm = gsl_sf_legendre_nlm(lmax : LibC::SizeT) : LibC::SizeT
  fun sf_log_e = gsl_sf_log_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_log = gsl_sf_log(x : LibC::Double) : LibC::Double
  fun sf_log_abs_e = gsl_sf_log_abs_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_log_abs = gsl_sf_log_abs(x : LibC::Double) : LibC::Double
  fun sf_complex_log_e = gsl_sf_complex_log_e(zr : LibC::Double, zi : LibC::Double, lnr : SfResult*, theta : SfResult*) : LibC::Int
  fun sf_log_1plusx_e = gsl_sf_log_1plusx_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_log_1plusx = gsl_sf_log_1plusx(x : LibC::Double) : LibC::Double
  fun sf_log_1plusx_mx_e = gsl_sf_log_1plusx_mx_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_log_1plusx_mx = gsl_sf_log_1plusx_mx(x : LibC::Double) : LibC::Double
  fun sf_mathieu_a_array = gsl_sf_mathieu_a_array(order_min : LibC::Int, order_max : LibC::Int, qq : LibC::Double, work : SfMathieuWorkspace*, result_array : LibC::Double*) : LibC::Int

  struct SfMathieuWorkspace
    size : LibC::SizeT
    even_order : LibC::SizeT
    odd_order : LibC::SizeT
    extra_values : LibC::Int
    qa : LibC::Double
    qb : LibC::Double
    aa : LibC::Double*
    bb : LibC::Double*
    dd : LibC::Double*
    ee : LibC::Double*
    tt : LibC::Double*
    e2 : LibC::Double*
    zz : LibC::Double*
    eval : Vector*
    evec : Matrix*
    wmat : EigenSymmvWorkspace*
  end

  fun sf_mathieu_b_array = gsl_sf_mathieu_b_array(order_min : LibC::Int, order_max : LibC::Int, qq : LibC::Double, work : SfMathieuWorkspace*, result_array : LibC::Double*) : LibC::Int
  fun sf_mathieu_a_e = gsl_sf_mathieu_a_e(order : LibC::Int, qq : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_mathieu_a = gsl_sf_mathieu_a(order : LibC::Int, qq : LibC::Double) : LibC::Double
  fun sf_mathieu_b_e = gsl_sf_mathieu_b_e(order : LibC::Int, qq : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_mathieu_b = gsl_sf_mathieu_b(order : LibC::Int, qq : LibC::Double) : LibC::Double
  fun sf_mathieu_a_coeff = gsl_sf_mathieu_a_coeff(order : LibC::Int, qq : LibC::Double, aa : LibC::Double, coeff : LibC::Double*) : LibC::Int
  fun sf_mathieu_b_coeff = gsl_sf_mathieu_b_coeff(order : LibC::Int, qq : LibC::Double, aa : LibC::Double, coeff : LibC::Double*) : LibC::Int
  fun sf_mathieu_alloc = gsl_sf_mathieu_alloc(nn : LibC::SizeT, qq : LibC::Double) : SfMathieuWorkspace*
  fun sf_mathieu_free = gsl_sf_mathieu_free(workspace : SfMathieuWorkspace*)
  fun sf_mathieu_ce_e = gsl_sf_mathieu_ce_e(order : LibC::Int, qq : LibC::Double, zz : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_mathieu_ce = gsl_sf_mathieu_ce(order : LibC::Int, qq : LibC::Double, zz : LibC::Double) : LibC::Double
  fun sf_mathieu_se_e = gsl_sf_mathieu_se_e(order : LibC::Int, qq : LibC::Double, zz : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_mathieu_se = gsl_sf_mathieu_se(order : LibC::Int, qq : LibC::Double, zz : LibC::Double) : LibC::Double
  fun sf_mathieu_ce_array = gsl_sf_mathieu_ce_array(nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : SfMathieuWorkspace*, result_array : LibC::Double*) : LibC::Int
  fun sf_mathieu_se_array = gsl_sf_mathieu_se_array(nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : SfMathieuWorkspace*, result_array : LibC::Double*) : LibC::Int
  fun sf_mathieu_mc_e = gsl_sf_mathieu_Mc_e(kind : LibC::Int, order : LibC::Int, qq : LibC::Double, zz : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_mathieu_mc = gsl_sf_mathieu_Mc(kind : LibC::Int, order : LibC::Int, qq : LibC::Double, zz : LibC::Double) : LibC::Double
  fun sf_mathieu_ms_e = gsl_sf_mathieu_Ms_e(kind : LibC::Int, order : LibC::Int, qq : LibC::Double, zz : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_mathieu_ms = gsl_sf_mathieu_Ms(kind : LibC::Int, order : LibC::Int, qq : LibC::Double, zz : LibC::Double) : LibC::Double
  fun sf_mathieu_mc_array = gsl_sf_mathieu_Mc_array(kind : LibC::Int, nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : SfMathieuWorkspace*, result_array : LibC::Double*) : LibC::Int
  fun sf_mathieu_ms_array = gsl_sf_mathieu_Ms_array(kind : LibC::Int, nmin : LibC::Int, nmax : LibC::Int, qq : LibC::Double, zz : LibC::Double, work : SfMathieuWorkspace*, result_array : LibC::Double*) : LibC::Int
  fun sf_pow_int_e = gsl_sf_pow_int_e(x : LibC::Double, n : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_pow_int = gsl_sf_pow_int(x : LibC::Double, n : LibC::Int) : LibC::Double
  fun sf_psi_int_e = gsl_sf_psi_int_e(n : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_psi_int = gsl_sf_psi_int(n : LibC::Int) : LibC::Double
  fun sf_psi_e = gsl_sf_psi_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_psi = gsl_sf_psi(x : LibC::Double) : LibC::Double
  fun sf_psi_1piy_e = gsl_sf_psi_1piy_e(y : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_psi_1piy = gsl_sf_psi_1piy(y : LibC::Double) : LibC::Double
  fun sf_complex_psi_e = gsl_sf_complex_psi_e(x : LibC::Double, y : LibC::Double, result_re : SfResult*, result_im : SfResult*) : LibC::Int
  fun sf_psi_1_int_e = gsl_sf_psi_1_int_e(n : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_psi_1_int = gsl_sf_psi_1_int(n : LibC::Int) : LibC::Double
  fun sf_psi_1_e = gsl_sf_psi_1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_psi_1 = gsl_sf_psi_1(x : LibC::Double) : LibC::Double
  fun sf_psi_n_e = gsl_sf_psi_n_e(n : LibC::Int, x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_psi_n = gsl_sf_psi_n(n : LibC::Int, x : LibC::Double) : LibC::Double
  fun sf_synchrotron_1_e = gsl_sf_synchrotron_1_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_synchrotron_1 = gsl_sf_synchrotron_1(x : LibC::Double) : LibC::Double
  fun sf_synchrotron_2_e = gsl_sf_synchrotron_2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_synchrotron_2 = gsl_sf_synchrotron_2(x : LibC::Double) : LibC::Double
  fun sf_transport_2_e = gsl_sf_transport_2_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_transport_2 = gsl_sf_transport_2(x : LibC::Double) : LibC::Double
  fun sf_transport_3_e = gsl_sf_transport_3_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_transport_3 = gsl_sf_transport_3(x : LibC::Double) : LibC::Double
  fun sf_transport_4_e = gsl_sf_transport_4_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_transport_4 = gsl_sf_transport_4(x : LibC::Double) : LibC::Double
  fun sf_transport_5_e = gsl_sf_transport_5_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_transport_5 = gsl_sf_transport_5(x : LibC::Double) : LibC::Double
  fun sf_sin_e = gsl_sf_sin_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_sin = gsl_sf_sin(x : LibC::Double) : LibC::Double
  fun sf_cos_e = gsl_sf_cos_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_cos = gsl_sf_cos(x : LibC::Double) : LibC::Double
  fun sf_hypot_e = gsl_sf_hypot_e(x : LibC::Double, y : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hypot = gsl_sf_hypot(x : LibC::Double, y : LibC::Double) : LibC::Double
  fun sf_complex_sin_e = gsl_sf_complex_sin_e(zr : LibC::Double, zi : LibC::Double, szr : SfResult*, szi : SfResult*) : LibC::Int
  fun sf_complex_cos_e = gsl_sf_complex_cos_e(zr : LibC::Double, zi : LibC::Double, czr : SfResult*, czi : SfResult*) : LibC::Int
  fun sf_complex_logsin_e = gsl_sf_complex_logsin_e(zr : LibC::Double, zi : LibC::Double, lszr : SfResult*, lszi : SfResult*) : LibC::Int
  fun sf_sinc_e = gsl_sf_sinc_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_sinc = gsl_sf_sinc(x : LibC::Double) : LibC::Double
  fun sf_lnsinh_e = gsl_sf_lnsinh_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_lnsinh = gsl_sf_lnsinh(x : LibC::Double) : LibC::Double
  fun sf_lncosh_e = gsl_sf_lncosh_e(x : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_lncosh = gsl_sf_lncosh(x : LibC::Double) : LibC::Double
  fun sf_polar_to_rect = gsl_sf_polar_to_rect(r : LibC::Double, theta : LibC::Double, x : SfResult*, y : SfResult*) : LibC::Int
  fun sf_rect_to_polar = gsl_sf_rect_to_polar(x : LibC::Double, y : LibC::Double, r : SfResult*, theta : SfResult*) : LibC::Int
  fun sf_sin_err_e = gsl_sf_sin_err_e(x : LibC::Double, dx : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_cos_err_e = gsl_sf_cos_err_e(x : LibC::Double, dx : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_angle_restrict_symm_e = gsl_sf_angle_restrict_symm_e(theta : LibC::Double*) : LibC::Int
  fun sf_angle_restrict_symm = gsl_sf_angle_restrict_symm(theta : LibC::Double) : LibC::Double
  fun sf_angle_restrict_pos_e = gsl_sf_angle_restrict_pos_e(theta : LibC::Double*) : LibC::Int
  fun sf_angle_restrict_pos = gsl_sf_angle_restrict_pos(theta : LibC::Double) : LibC::Double
  fun sf_angle_restrict_symm_err_e = gsl_sf_angle_restrict_symm_err_e(theta : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_angle_restrict_pos_err_e = gsl_sf_angle_restrict_pos_err_e(theta : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_zeta_int_e = gsl_sf_zeta_int_e(n : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_zeta_int = gsl_sf_zeta_int(n : LibC::Int) : LibC::Double
  fun sf_zeta_e = gsl_sf_zeta_e(s : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_zeta = gsl_sf_zeta(s : LibC::Double) : LibC::Double
  fun sf_zetam1_e = gsl_sf_zetam1_e(s : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_zetam1 = gsl_sf_zetam1(s : LibC::Double) : LibC::Double
  fun sf_zetam1_int_e = gsl_sf_zetam1_int_e(s : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_zetam1_int = gsl_sf_zetam1_int(s : LibC::Int) : LibC::Double
  fun sf_hzeta_e = gsl_sf_hzeta_e(s : LibC::Double, q : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_hzeta = gsl_sf_hzeta(s : LibC::Double, q : LibC::Double) : LibC::Double
  fun sf_eta_int_e = gsl_sf_eta_int_e(n : LibC::Int, result : SfResult*) : LibC::Int
  fun sf_eta_int = gsl_sf_eta_int(n : LibC::Int) : LibC::Double
  fun sf_eta_e = gsl_sf_eta_e(s : LibC::Double, result : SfResult*) : LibC::Int
  fun sf_eta = gsl_sf_eta(s : LibC::Double) : LibC::Double
  fun siman_solve = gsl_siman_solve(r : Rng*, x0_p : Void*, ef : SimanEfuncT, take_step : SimanStepT, distance : SimanMetricT, print_position : SimanPrintT, copyfunc : SimanCopyT, copy_constructor : SimanCopyConstructT, destructor : SimanDestroyT, element_size : LibC::SizeT, params : SimanParamsT)
  alias SimanEfuncT = (Void* -> LibC::Double)
  alias SimanStepT = (Rng*, Void*, LibC::Double -> Void)
  alias SimanMetricT = (Void*, Void* -> LibC::Double)
  alias SimanPrintT = (Void* -> Void)
  alias SimanCopyT = (Void*, Void* -> Void)
  alias SimanCopyConstructT = (Void* -> Void*)
  alias SimanDestroyT = (Void* -> Void)

  struct SimanParamsT
    n_tries : LibC::Int
    iters_fixed_t : LibC::Int
    step_size : LibC::Double
    k : LibC::Double
    t_initial : LibC::Double
    mu_t : LibC::Double
    t_min : LibC::Double
  end

  fun siman_solve_many = gsl_siman_solve_many(r : Rng*, x0_p : Void*, ef : SimanEfuncT, take_step : SimanStepT, distance : SimanMetricT, print_position : SimanPrintT, element_size : LibC::SizeT, params : SimanParamsT)
  fun sort_char = gsl_sort_char(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_char = gsl_sort2_char(data1 : LibC::Char*, stride1 : LibC::SizeT, data2 : LibC::Char*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_char_index = gsl_sort_char_index(p : LibC::SizeT*, data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_char_smallest = gsl_sort_char_smallest(dest : LibC::Char*, k : LibC::SizeT, src : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_char_smallest_index = gsl_sort_char_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_char_largest = gsl_sort_char_largest(dest : LibC::Char*, k : LibC::SizeT, src : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_char_largest_index = gsl_sort_char_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort = gsl_sort(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2 = gsl_sort2(data1 : LibC::Double*, stride1 : LibC::SizeT, data2 : LibC::Double*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_index = gsl_sort_index(p : LibC::SizeT*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_smallest = gsl_sort_smallest(dest : LibC::Double*, k : LibC::SizeT, src : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_smallest_index = gsl_sort_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_largest = gsl_sort_largest(dest : LibC::Double*, k : LibC::SizeT, src : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_largest_index = gsl_sort_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_float = gsl_sort_float(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_float = gsl_sort2_float(data1 : LibC::Float*, stride1 : LibC::SizeT, data2 : LibC::Float*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_float_index = gsl_sort_float_index(p : LibC::SizeT*, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_float_smallest = gsl_sort_float_smallest(dest : LibC::Float*, k : LibC::SizeT, src : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_float_smallest_index = gsl_sort_float_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_float_largest = gsl_sort_float_largest(dest : LibC::Float*, k : LibC::SizeT, src : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_float_largest_index = gsl_sort_float_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  # fun sort_long_double = gsl_sort_long_double(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT)
  # fun sort2_long_double = gsl_sort2_long_double(data1 : LibC::LongDouble*, stride1 : LibC::SizeT, data2 : LibC::LongDouble*, stride2 : LibC::SizeT, n : LibC::SizeT)
  # fun sort_long_double_index = gsl_sort_long_double_index(p : LibC::SizeT*, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT)
  # fun sort_long_double_smallest = gsl_sort_long_double_smallest(dest : LibC::LongDouble*, k : LibC::SizeT, src : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  # fun sort_long_double_smallest_index = gsl_sort_long_double_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  # fun sort_long_double_largest = gsl_sort_long_double_largest(dest : LibC::LongDouble*, k : LibC::SizeT, src : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  # fun sort_long_double_largest_index = gsl_sort_long_double_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_ulong = gsl_sort_ulong(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_ulong = gsl_sort2_ulong(data1 : LibC::ULong*, stride1 : LibC::SizeT, data2 : LibC::ULong*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_ulong_index = gsl_sort_ulong_index(p : LibC::SizeT*, data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_ulong_smallest = gsl_sort_ulong_smallest(dest : LibC::ULong*, k : LibC::SizeT, src : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_ulong_smallest_index = gsl_sort_ulong_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_ulong_largest = gsl_sort_ulong_largest(dest : LibC::ULong*, k : LibC::SizeT, src : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_ulong_largest_index = gsl_sort_ulong_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_long = gsl_sort_long(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_long = gsl_sort2_long(data1 : LibC::Long*, stride1 : LibC::SizeT, data2 : LibC::Long*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_long_index = gsl_sort_long_index(p : LibC::SizeT*, data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_long_smallest = gsl_sort_long_smallest(dest : LibC::Long*, k : LibC::SizeT, src : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_long_smallest_index = gsl_sort_long_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_long_largest = gsl_sort_long_largest(dest : LibC::Long*, k : LibC::SizeT, src : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_long_largest_index = gsl_sort_long_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_uint = gsl_sort_uint(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_uint = gsl_sort2_uint(data1 : LibC::UInt*, stride1 : LibC::SizeT, data2 : LibC::UInt*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_uint_index = gsl_sort_uint_index(p : LibC::SizeT*, data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_uint_smallest = gsl_sort_uint_smallest(dest : LibC::UInt*, k : LibC::SizeT, src : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_uint_smallest_index = gsl_sort_uint_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_uint_largest = gsl_sort_uint_largest(dest : LibC::UInt*, k : LibC::SizeT, src : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_uint_largest_index = gsl_sort_uint_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_int = gsl_sort_int(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_int = gsl_sort2_int(data1 : LibC::Int*, stride1 : LibC::SizeT, data2 : LibC::Int*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_int_index = gsl_sort_int_index(p : LibC::SizeT*, data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_int_smallest = gsl_sort_int_smallest(dest : LibC::Int*, k : LibC::SizeT, src : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_int_smallest_index = gsl_sort_int_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_int_largest = gsl_sort_int_largest(dest : LibC::Int*, k : LibC::SizeT, src : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_int_largest_index = gsl_sort_int_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_ushort = gsl_sort_ushort(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_ushort = gsl_sort2_ushort(data1 : LibC::UShort*, stride1 : LibC::SizeT, data2 : LibC::UShort*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_ushort_index = gsl_sort_ushort_index(p : LibC::SizeT*, data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_ushort_smallest = gsl_sort_ushort_smallest(dest : LibC::UShort*, k : LibC::SizeT, src : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_ushort_smallest_index = gsl_sort_ushort_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_ushort_largest = gsl_sort_ushort_largest(dest : LibC::UShort*, k : LibC::SizeT, src : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_ushort_largest_index = gsl_sort_ushort_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_short = gsl_sort_short(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_short = gsl_sort2_short(data1 : LibC::Short*, stride1 : LibC::SizeT, data2 : LibC::Short*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_short_index = gsl_sort_short_index(p : LibC::SizeT*, data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_short_smallest = gsl_sort_short_smallest(dest : LibC::Short*, k : LibC::SizeT, src : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_short_smallest_index = gsl_sort_short_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_short_largest = gsl_sort_short_largest(dest : LibC::Short*, k : LibC::SizeT, src : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_short_largest_index = gsl_sort_short_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_uchar = gsl_sort_uchar(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort2_uchar = gsl_sort2_uchar(data1 : UInt8*, stride1 : LibC::SizeT, data2 : UInt8*, stride2 : LibC::SizeT, n : LibC::SizeT)
  fun sort_uchar_index = gsl_sort_uchar_index(p : LibC::SizeT*, data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT)
  fun sort_uchar_smallest = gsl_sort_uchar_smallest(dest : UInt8*, k : LibC::SizeT, src : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_uchar_smallest_index = gsl_sort_uchar_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, src : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_uchar_largest = gsl_sort_uchar_largest(dest : UInt8*, k : LibC::SizeT, src : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_uchar_largest_index = gsl_sort_uchar_largest_index(p : LibC::SizeT*, k : LibC::SizeT, src : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun sort_vector_char = gsl_sort_vector_char(v : VectorChar*)
  fun sort_vector2_char = gsl_sort_vector2_char(v1 : VectorChar*, v2 : VectorChar*)
  fun sort_vector_char_index = gsl_sort_vector_char_index(p : Permutation*, v : VectorChar*) : LibC::Int
  fun sort_vector_char_smallest = gsl_sort_vector_char_smallest(dest : LibC::Char*, k : LibC::SizeT, v : VectorChar*) : LibC::Int
  fun sort_vector_char_largest = gsl_sort_vector_char_largest(dest : LibC::Char*, k : LibC::SizeT, v : VectorChar*) : LibC::Int
  fun sort_vector_char_smallest_index = gsl_sort_vector_char_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorChar*) : LibC::Int
  fun sort_vector_char_largest_index = gsl_sort_vector_char_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorChar*) : LibC::Int
  fun sort_vector = gsl_sort_vector(v : Vector*)
  fun sort_vector2 = gsl_sort_vector2(v1 : Vector*, v2 : Vector*)
  fun sort_vector_index = gsl_sort_vector_index(p : Permutation*, v : Vector*) : LibC::Int
  fun sort_vector_smallest = gsl_sort_vector_smallest(dest : LibC::Double*, k : LibC::SizeT, v : Vector*) : LibC::Int
  fun sort_vector_largest = gsl_sort_vector_largest(dest : LibC::Double*, k : LibC::SizeT, v : Vector*) : LibC::Int
  fun sort_vector_smallest_index = gsl_sort_vector_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : Vector*) : LibC::Int
  fun sort_vector_largest_index = gsl_sort_vector_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : Vector*) : LibC::Int
  fun sort_vector_float = gsl_sort_vector_float(v : VectorFloat*)
  fun sort_vector2_float = gsl_sort_vector2_float(v1 : VectorFloat*, v2 : VectorFloat*)
  fun sort_vector_float_index = gsl_sort_vector_float_index(p : Permutation*, v : VectorFloat*) : LibC::Int
  fun sort_vector_float_smallest = gsl_sort_vector_float_smallest(dest : LibC::Float*, k : LibC::SizeT, v : VectorFloat*) : LibC::Int
  fun sort_vector_float_largest = gsl_sort_vector_float_largest(dest : LibC::Float*, k : LibC::SizeT, v : VectorFloat*) : LibC::Int
  fun sort_vector_float_smallest_index = gsl_sort_vector_float_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorFloat*) : LibC::Int
  fun sort_vector_float_largest_index = gsl_sort_vector_float_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorFloat*) : LibC::Int
  # fun sort_vector_long_double = gsl_sort_vector_long_double(v : VectorLongDouble*)
  # fun sort_vector2_long_double = gsl_sort_vector2_long_double(v1 : VectorLongDouble*, v2 : VectorLongDouble*)
  # fun sort_vector_long_double_index = gsl_sort_vector_long_double_index(p : Permutation*, v : VectorLongDouble*) : LibC::Int
  # fun sort_vector_long_double_smallest = gsl_sort_vector_long_double_smallest(dest : LibC::LongDouble*, k : LibC::SizeT, v : VectorLongDouble*) : LibC::Int
  # fun sort_vector_long_double_largest = gsl_sort_vector_long_double_largest(dest : LibC::LongDouble*, k : LibC::SizeT, v : VectorLongDouble*) : LibC::Int
  # fun sort_vector_long_double_smallest_index = gsl_sort_vector_long_double_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorLongDouble*) : LibC::Int
  # fun sort_vector_long_double_largest_index = gsl_sort_vector_long_double_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorLongDouble*) : LibC::Int
  fun sort_vector_ulong = gsl_sort_vector_ulong(v : VectorUlong*)
  fun sort_vector2_ulong = gsl_sort_vector2_ulong(v1 : VectorUlong*, v2 : VectorUlong*)
  fun sort_vector_ulong_index = gsl_sort_vector_ulong_index(p : Permutation*, v : VectorUlong*) : LibC::Int
  fun sort_vector_ulong_smallest = gsl_sort_vector_ulong_smallest(dest : LibC::ULong*, k : LibC::SizeT, v : VectorUlong*) : LibC::Int
  fun sort_vector_ulong_largest = gsl_sort_vector_ulong_largest(dest : LibC::ULong*, k : LibC::SizeT, v : VectorUlong*) : LibC::Int
  fun sort_vector_ulong_smallest_index = gsl_sort_vector_ulong_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorUlong*) : LibC::Int
  fun sort_vector_ulong_largest_index = gsl_sort_vector_ulong_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorUlong*) : LibC::Int
  fun sort_vector_long = gsl_sort_vector_long(v : VectorLong*)
  fun sort_vector2_long = gsl_sort_vector2_long(v1 : VectorLong*, v2 : VectorLong*)
  fun sort_vector_long_index = gsl_sort_vector_long_index(p : Permutation*, v : VectorLong*) : LibC::Int
  fun sort_vector_long_smallest = gsl_sort_vector_long_smallest(dest : LibC::Long*, k : LibC::SizeT, v : VectorLong*) : LibC::Int
  fun sort_vector_long_largest = gsl_sort_vector_long_largest(dest : LibC::Long*, k : LibC::SizeT, v : VectorLong*) : LibC::Int
  fun sort_vector_long_smallest_index = gsl_sort_vector_long_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorLong*) : LibC::Int
  fun sort_vector_long_largest_index = gsl_sort_vector_long_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorLong*) : LibC::Int
  fun sort_vector_uint = gsl_sort_vector_uint(v : VectorUint*)
  fun sort_vector2_uint = gsl_sort_vector2_uint(v1 : VectorUint*, v2 : VectorUint*)
  fun sort_vector_uint_index = gsl_sort_vector_uint_index(p : Permutation*, v : VectorUint*) : LibC::Int
  fun sort_vector_uint_smallest = gsl_sort_vector_uint_smallest(dest : LibC::UInt*, k : LibC::SizeT, v : VectorUint*) : LibC::Int
  fun sort_vector_uint_largest = gsl_sort_vector_uint_largest(dest : LibC::UInt*, k : LibC::SizeT, v : VectorUint*) : LibC::Int
  fun sort_vector_uint_smallest_index = gsl_sort_vector_uint_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorUint*) : LibC::Int
  fun sort_vector_uint_largest_index = gsl_sort_vector_uint_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorUint*) : LibC::Int
  fun sort_vector_int = gsl_sort_vector_int(v : VectorInt*)
  fun sort_vector2_int = gsl_sort_vector2_int(v1 : VectorInt*, v2 : VectorInt*)
  fun sort_vector_int_index = gsl_sort_vector_int_index(p : Permutation*, v : VectorInt*) : LibC::Int
  fun sort_vector_int_smallest = gsl_sort_vector_int_smallest(dest : LibC::Int*, k : LibC::SizeT, v : VectorInt*) : LibC::Int
  fun sort_vector_int_largest = gsl_sort_vector_int_largest(dest : LibC::Int*, k : LibC::SizeT, v : VectorInt*) : LibC::Int
  fun sort_vector_int_smallest_index = gsl_sort_vector_int_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorInt*) : LibC::Int
  fun sort_vector_int_largest_index = gsl_sort_vector_int_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorInt*) : LibC::Int
  fun sort_vector_ushort = gsl_sort_vector_ushort(v : VectorUshort*)
  fun sort_vector2_ushort = gsl_sort_vector2_ushort(v1 : VectorUshort*, v2 : VectorUshort*)
  fun sort_vector_ushort_index = gsl_sort_vector_ushort_index(p : Permutation*, v : VectorUshort*) : LibC::Int
  fun sort_vector_ushort_smallest = gsl_sort_vector_ushort_smallest(dest : LibC::UShort*, k : LibC::SizeT, v : VectorUshort*) : LibC::Int
  fun sort_vector_ushort_largest = gsl_sort_vector_ushort_largest(dest : LibC::UShort*, k : LibC::SizeT, v : VectorUshort*) : LibC::Int
  fun sort_vector_ushort_smallest_index = gsl_sort_vector_ushort_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorUshort*) : LibC::Int
  fun sort_vector_ushort_largest_index = gsl_sort_vector_ushort_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorUshort*) : LibC::Int
  fun sort_vector_short = gsl_sort_vector_short(v : VectorShort*)
  fun sort_vector2_short = gsl_sort_vector2_short(v1 : VectorShort*, v2 : VectorShort*)
  fun sort_vector_short_index = gsl_sort_vector_short_index(p : Permutation*, v : VectorShort*) : LibC::Int
  fun sort_vector_short_smallest = gsl_sort_vector_short_smallest(dest : LibC::Short*, k : LibC::SizeT, v : VectorShort*) : LibC::Int
  fun sort_vector_short_largest = gsl_sort_vector_short_largest(dest : LibC::Short*, k : LibC::SizeT, v : VectorShort*) : LibC::Int
  fun sort_vector_short_smallest_index = gsl_sort_vector_short_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorShort*) : LibC::Int
  fun sort_vector_short_largest_index = gsl_sort_vector_short_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorShort*) : LibC::Int
  fun sort_vector_uchar = gsl_sort_vector_uchar(v : VectorUchar*)
  fun sort_vector2_uchar = gsl_sort_vector2_uchar(v1 : VectorUchar*, v2 : VectorUchar*)
  fun sort_vector_uchar_index = gsl_sort_vector_uchar_index(p : Permutation*, v : VectorUchar*) : LibC::Int
  fun sort_vector_uchar_smallest = gsl_sort_vector_uchar_smallest(dest : UInt8*, k : LibC::SizeT, v : VectorUchar*) : LibC::Int
  fun sort_vector_uchar_largest = gsl_sort_vector_uchar_largest(dest : UInt8*, k : LibC::SizeT, v : VectorUchar*) : LibC::Int
  fun sort_vector_uchar_smallest_index = gsl_sort_vector_uchar_smallest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorUchar*) : LibC::Int
  fun sort_vector_uchar_largest_index = gsl_sort_vector_uchar_largest_index(p : LibC::SizeT*, k : LibC::SizeT, v : VectorUchar*) : LibC::Int
  fun spmatrix_alloc = gsl_spmatrix_alloc(n1 : LibC::SizeT, n2 : LibC::SizeT) : Spmatrix*

  struct Spmatrix
    size1 : LibC::SizeT
    size2 : LibC::SizeT
    i : LibC::SizeT*
    data : LibC::Double*
    p : LibC::SizeT*
    nzmax : LibC::SizeT
    nz : LibC::SizeT
    tree_data : SpmatrixTree*
    work : Void*
    sptype : LibC::SizeT
  end

  struct SpmatrixTree
    tree : Void*
    node_array : Void*
    n : LibC::SizeT
  end

  fun spmatrix_alloc_nzmax = gsl_spmatrix_alloc_nzmax(n1 : LibC::SizeT, n2 : LibC::SizeT, nzmax : LibC::SizeT, flags : LibC::SizeT) : Spmatrix*
  fun spmatrix_free = gsl_spmatrix_free(m : Spmatrix*)
  fun spmatrix_realloc = gsl_spmatrix_realloc(nzmax : LibC::SizeT, m : Spmatrix*) : LibC::Int
  fun spmatrix_set_zero = gsl_spmatrix_set_zero(m : Spmatrix*) : LibC::Int
  fun spmatrix_nnz = gsl_spmatrix_nnz(m : Spmatrix*) : LibC::SizeT
  fun spmatrix_compare_idx = gsl_spmatrix_compare_idx(ia : LibC::SizeT, ja : LibC::SizeT, ib : LibC::SizeT, jb : LibC::SizeT) : LibC::Int
  fun spmatrix_tree_rebuild = gsl_spmatrix_tree_rebuild(m : Spmatrix*) : LibC::Int
  fun spmatrix_memcpy = gsl_spmatrix_memcpy(dest : Spmatrix*, src : Spmatrix*) : LibC::Int
  fun spmatrix_get = gsl_spmatrix_get(m : Spmatrix*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Double
  fun spmatrix_set = gsl_spmatrix_set(m : Spmatrix*, i : LibC::SizeT, j : LibC::SizeT, x : LibC::Double) : LibC::Int
  fun spmatrix_ptr = gsl_spmatrix_ptr(m : Spmatrix*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Double*
  fun spmatrix_compcol = gsl_spmatrix_compcol(t : Spmatrix*) : Spmatrix*
  fun spmatrix_ccs = gsl_spmatrix_ccs(t : Spmatrix*) : Spmatrix*
  fun spmatrix_crs = gsl_spmatrix_crs(t : Spmatrix*) : Spmatrix*
  fun spmatrix_cumsum = gsl_spmatrix_cumsum(n : LibC::SizeT, c : LibC::SizeT*)
  fun spmatrix_fprintf = gsl_spmatrix_fprintf(stream : File*, m : Spmatrix*, format : LibC::Char*) : LibC::Int
  fun spmatrix_fscanf = gsl_spmatrix_fscanf(stream : File*) : Spmatrix*
  fun spmatrix_fwrite = gsl_spmatrix_fwrite(stream : File*, m : Spmatrix*) : LibC::Int
  fun spmatrix_fread = gsl_spmatrix_fread(stream : File*, m : Spmatrix*) : LibC::Int
  fun spmatrix_scale = gsl_spmatrix_scale(m : Spmatrix*, x : LibC::Double) : LibC::Int
  fun spmatrix_minmax = gsl_spmatrix_minmax(m : Spmatrix*, min_out : LibC::Double*, max_out : LibC::Double*) : LibC::Int
  fun spmatrix_add = gsl_spmatrix_add(c : Spmatrix*, a : Spmatrix*, b : Spmatrix*) : LibC::Int
  fun spmatrix_d2sp = gsl_spmatrix_d2sp(s : Spmatrix*, a : Matrix*) : LibC::Int
  fun spmatrix_sp2d = gsl_spmatrix_sp2d(a : Matrix*, s : Spmatrix*) : LibC::Int
  fun spmatrix_equal = gsl_spmatrix_equal(a : Spmatrix*, b : Spmatrix*) : LibC::Int
  fun spmatrix_transpose = gsl_spmatrix_transpose(m : Spmatrix*) : LibC::Int
  fun spmatrix_transpose2 = gsl_spmatrix_transpose2(m : Spmatrix*) : LibC::Int
  fun spmatrix_transpose_memcpy = gsl_spmatrix_transpose_memcpy(dest : Spmatrix*, src : Spmatrix*) : LibC::Int
  fun spblas_dgemv = gsl_spblas_dgemv(trans_a : CblasTransposeT, alpha : LibC::Double, a : Spmatrix*, x : Vector*, beta : LibC::Double, y : Vector*) : LibC::Int
  fun spblas_dgemm = gsl_spblas_dgemm(alpha : LibC::Double, a : Spmatrix*, b : Spmatrix*, c : Spmatrix*) : LibC::Int
  fun spblas_scatter = gsl_spblas_scatter(a : Spmatrix*, j : LibC::SizeT, alpha : LibC::Double, w : LibC::SizeT*, x : LibC::Double*, mark : LibC::SizeT, c : Spmatrix*, nz : LibC::SizeT) : LibC::SizeT

  struct SplinalgItersolveType
    name : LibC::Char*
    alloc : (LibC::SizeT, LibC::SizeT -> Void*)
    iterate : (Spmatrix*, Vector*, LibC::Double, Vector*, Void* -> LibC::Int)
    normr : (Void* -> LibC::Double)
    free : (Void* -> Void)
  end

  fun splinalg_itersolve_alloc = gsl_splinalg_itersolve_alloc(t : SplinalgItersolveType*, n : LibC::SizeT, m : LibC::SizeT) : SplinalgItersolve*

  struct SplinalgItersolve
    type : SplinalgItersolveType*
    normr : LibC::Double
    state : Void*
  end

  fun splinalg_itersolve_free = gsl_splinalg_itersolve_free(w : SplinalgItersolve*)
  fun splinalg_itersolve_name = gsl_splinalg_itersolve_name(w : SplinalgItersolve*) : LibC::Char*
  fun splinalg_itersolve_iterate = gsl_splinalg_itersolve_iterate(a : Spmatrix*, b : Vector*, tol : LibC::Double, x : Vector*, w : SplinalgItersolve*) : LibC::Int
  fun splinalg_itersolve_normr = gsl_splinalg_itersolve_normr(w : SplinalgItersolve*) : LibC::Double
  fun spline2d_alloc = gsl_spline2d_alloc(t : Interp2dType*, xsize : LibC::SizeT, ysize : LibC::SizeT) : Spline2d*

  struct Spline2d
    interp_object : Interp2d
    xarr : LibC::Double*
    yarr : LibC::Double*
    zarr : LibC::Double*
  end

  fun spline2d_init = gsl_spline2d_init(interp : Spline2d*, xa : LibC::Double*, ya : LibC::Double*, za : LibC::Double*, xsize : LibC::SizeT, ysize : LibC::SizeT) : LibC::Int
  fun spline2d_free = gsl_spline2d_free(interp : Spline2d*)
  fun spline2d_eval = gsl_spline2d_eval(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun spline2d_eval_e = gsl_spline2d_eval_e(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun spline2d_eval_deriv_x = gsl_spline2d_eval_deriv_x(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun spline2d_eval_deriv_x_e = gsl_spline2d_eval_deriv_x_e(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun spline2d_eval_deriv_y = gsl_spline2d_eval_deriv_y(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun spline2d_eval_deriv_y_e = gsl_spline2d_eval_deriv_y_e(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun spline2d_eval_deriv_xx = gsl_spline2d_eval_deriv_xx(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun spline2d_eval_deriv_xx_e = gsl_spline2d_eval_deriv_xx_e(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun spline2d_eval_deriv_yy = gsl_spline2d_eval_deriv_yy(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun spline2d_eval_deriv_yy_e = gsl_spline2d_eval_deriv_yy_e(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun spline2d_eval_deriv_xy = gsl_spline2d_eval_deriv_xy(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*) : LibC::Double
  fun spline2d_eval_deriv_xy_e = gsl_spline2d_eval_deriv_xy_e(interp : Spline2d*, x : LibC::Double, y : LibC::Double, xa : InterpAccel*, ya : InterpAccel*, z : LibC::Double*) : LibC::Int
  fun spline2d_min_size = gsl_spline2d_min_size(interp : Spline2d*) : LibC::SizeT
  fun spline2d_name = gsl_spline2d_name(interp : Spline2d*) : LibC::Char*
  fun spline2d_set = gsl_spline2d_set(interp : Spline2d*, zarr : LibC::Double*, i : LibC::SizeT, j : LibC::SizeT, z : LibC::Double) : LibC::Int
  fun spline2d_get = gsl_spline2d_get(interp : Spline2d*, zarr : LibC::Double*, i : LibC::SizeT, j : LibC::SizeT) : LibC::Double
  fun spline_alloc = gsl_spline_alloc(t : InterpType*, size : LibC::SizeT) : Spline*

  struct Spline
    interp : Interp*
    x : LibC::Double*
    y : LibC::Double*
    size : LibC::SizeT
  end

  fun spline_init = gsl_spline_init(spline : Spline*, xa : LibC::Double*, ya : LibC::Double*, size : LibC::SizeT) : LibC::Int
  fun spline_name = gsl_spline_name(spline : Spline*) : LibC::Char*
  fun spline_min_size = gsl_spline_min_size(spline : Spline*) : LibC::UInt
  fun spline_eval_e = gsl_spline_eval_e(spline : Spline*, x : LibC::Double, a : InterpAccel*, y : LibC::Double*) : LibC::Int
  fun spline_eval = gsl_spline_eval(spline : Spline*, x : LibC::Double, a : InterpAccel*) : LibC::Double
  fun spline_eval_deriv_e = gsl_spline_eval_deriv_e(spline : Spline*, x : LibC::Double, a : InterpAccel*, y : LibC::Double*) : LibC::Int
  fun spline_eval_deriv = gsl_spline_eval_deriv(spline : Spline*, x : LibC::Double, a : InterpAccel*) : LibC::Double
  fun spline_eval_deriv2_e = gsl_spline_eval_deriv2_e(spline : Spline*, x : LibC::Double, a : InterpAccel*, y : LibC::Double*) : LibC::Int
  fun spline_eval_deriv2 = gsl_spline_eval_deriv2(spline : Spline*, x : LibC::Double, a : InterpAccel*) : LibC::Double
  fun spline_eval_integ_e = gsl_spline_eval_integ_e(spline : Spline*, a : LibC::Double, b : LibC::Double, acc : InterpAccel*, y : LibC::Double*) : LibC::Int
  fun spline_eval_integ = gsl_spline_eval_integ(spline : Spline*, a : LibC::Double, b : LibC::Double, acc : InterpAccel*) : LibC::Double
  fun spline_free = gsl_spline_free(spline : Spline*)
  fun stats_char_mean = gsl_stats_char_mean(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_variance = gsl_stats_char_variance(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_sd = gsl_stats_char_sd(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_variance_with_fixed_mean = gsl_stats_char_variance_with_fixed_mean(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_char_sd_with_fixed_mean = gsl_stats_char_sd_with_fixed_mean(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_char_tss = gsl_stats_char_tss(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_tss_m = gsl_stats_char_tss_m(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_char_absdev = gsl_stats_char_absdev(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_skew = gsl_stats_char_skew(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_kurtosis = gsl_stats_char_kurtosis(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_lag1_autocorrelation = gsl_stats_char_lag1_autocorrelation(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_covariance = gsl_stats_char_covariance(data1 : LibC::Char*, stride1 : LibC::SizeT, data2 : LibC::Char*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_correlation = gsl_stats_char_correlation(data1 : LibC::Char*, stride1 : LibC::SizeT, data2 : LibC::Char*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_spearman = gsl_stats_char_spearman(data1 : LibC::Char*, stride1 : LibC::SizeT, data2 : LibC::Char*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_char_variance_m = gsl_stats_char_variance_m(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_char_sd_m = gsl_stats_char_sd_m(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_char_absdev_m = gsl_stats_char_absdev_m(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_char_skew_m_sd = gsl_stats_char_skew_m_sd(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_char_kurtosis_m_sd = gsl_stats_char_kurtosis_m_sd(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_char_lag1_autocorrelation_m = gsl_stats_char_lag1_autocorrelation_m(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_char_covariance_m = gsl_stats_char_covariance_m(data1 : LibC::Char*, stride1 : LibC::SizeT, data2 : LibC::Char*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_char_pvariance = gsl_stats_char_pvariance(data1 : LibC::Char*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Char*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_char_ttest = gsl_stats_char_ttest(data1 : LibC::Char*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Char*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_char_max = gsl_stats_char_max(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Char
  fun stats_char_min = gsl_stats_char_min(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Char
  fun stats_char_minmax = gsl_stats_char_minmax(min : LibC::Char*, max : LibC::Char*, data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_char_max_index = gsl_stats_char_max_index(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_char_min_index = gsl_stats_char_min_index(data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_char_minmax_index = gsl_stats_char_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_char_median_from_sorted_data = gsl_stats_char_median_from_sorted_data(sorted_data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_char_quantile_from_sorted_data = gsl_stats_char_quantile_from_sorted_data(sorted_data : LibC::Char*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_mean = gsl_stats_mean(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_variance = gsl_stats_variance(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_sd = gsl_stats_sd(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_variance_with_fixed_mean = gsl_stats_variance_with_fixed_mean(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_sd_with_fixed_mean = gsl_stats_sd_with_fixed_mean(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_tss = gsl_stats_tss(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_tss_m = gsl_stats_tss_m(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_absdev = gsl_stats_absdev(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_skew = gsl_stats_skew(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_kurtosis = gsl_stats_kurtosis(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_lag1_autocorrelation = gsl_stats_lag1_autocorrelation(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_covariance = gsl_stats_covariance(data1 : LibC::Double*, stride1 : LibC::SizeT, data2 : LibC::Double*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_correlation = gsl_stats_correlation(data1 : LibC::Double*, stride1 : LibC::SizeT, data2 : LibC::Double*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_spearman = gsl_stats_spearman(data1 : LibC::Double*, stride1 : LibC::SizeT, data2 : LibC::Double*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_variance_m = gsl_stats_variance_m(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_sd_m = gsl_stats_sd_m(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_absdev_m = gsl_stats_absdev_m(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_skew_m_sd = gsl_stats_skew_m_sd(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_kurtosis_m_sd = gsl_stats_kurtosis_m_sd(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_lag1_autocorrelation_m = gsl_stats_lag1_autocorrelation_m(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_covariance_m = gsl_stats_covariance_m(data1 : LibC::Double*, stride1 : LibC::SizeT, data2 : LibC::Double*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_wmean = gsl_stats_wmean(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_wvariance = gsl_stats_wvariance(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_wsd = gsl_stats_wsd(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_wvariance_with_fixed_mean = gsl_stats_wvariance_with_fixed_mean(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_wsd_with_fixed_mean = gsl_stats_wsd_with_fixed_mean(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_wtss = gsl_stats_wtss(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_wtss_m = gsl_stats_wtss_m(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  fun stats_wabsdev = gsl_stats_wabsdev(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_wskew = gsl_stats_wskew(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_wkurtosis = gsl_stats_wkurtosis(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_wvariance_m = gsl_stats_wvariance_m(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  fun stats_wsd_m = gsl_stats_wsd_m(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  fun stats_wabsdev_m = gsl_stats_wabsdev_m(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  fun stats_wskew_m_sd = gsl_stats_wskew_m_sd(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double, wsd : LibC::Double) : LibC::Double
  fun stats_wkurtosis_m_sd = gsl_stats_wkurtosis_m_sd(w : LibC::Double*, wstride : LibC::SizeT, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double, wsd : LibC::Double) : LibC::Double
  fun stats_pvariance = gsl_stats_pvariance(data1 : LibC::Double*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Double*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_ttest = gsl_stats_ttest(data1 : LibC::Double*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Double*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_max = gsl_stats_max(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_min = gsl_stats_min(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_minmax = gsl_stats_minmax(min : LibC::Double*, max : LibC::Double*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_max_index = gsl_stats_max_index(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_min_index = gsl_stats_min_index(data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_minmax_index = gsl_stats_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_median_from_sorted_data = gsl_stats_median_from_sorted_data(sorted_data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_quantile_from_sorted_data = gsl_stats_quantile_from_sorted_data(sorted_data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_float_mean = gsl_stats_float_mean(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_variance = gsl_stats_float_variance(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_sd = gsl_stats_float_sd(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_variance_with_fixed_mean = gsl_stats_float_variance_with_fixed_mean(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_sd_with_fixed_mean = gsl_stats_float_sd_with_fixed_mean(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_tss = gsl_stats_float_tss(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_tss_m = gsl_stats_float_tss_m(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_absdev = gsl_stats_float_absdev(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_skew = gsl_stats_float_skew(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_kurtosis = gsl_stats_float_kurtosis(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_lag1_autocorrelation = gsl_stats_float_lag1_autocorrelation(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_covariance = gsl_stats_float_covariance(data1 : LibC::Float*, stride1 : LibC::SizeT, data2 : LibC::Float*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_correlation = gsl_stats_float_correlation(data1 : LibC::Float*, stride1 : LibC::SizeT, data2 : LibC::Float*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_spearman = gsl_stats_float_spearman(data1 : LibC::Float*, stride1 : LibC::SizeT, data2 : LibC::Float*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_float_variance_m = gsl_stats_float_variance_m(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_sd_m = gsl_stats_float_sd_m(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_absdev_m = gsl_stats_float_absdev_m(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_skew_m_sd = gsl_stats_float_skew_m_sd(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_float_kurtosis_m_sd = gsl_stats_float_kurtosis_m_sd(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_float_lag1_autocorrelation_m = gsl_stats_float_lag1_autocorrelation_m(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_covariance_m = gsl_stats_float_covariance_m(data1 : LibC::Float*, stride1 : LibC::SizeT, data2 : LibC::Float*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_float_wmean = gsl_stats_float_wmean(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_wvariance = gsl_stats_float_wvariance(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_wsd = gsl_stats_float_wsd(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_wvariance_with_fixed_mean = gsl_stats_float_wvariance_with_fixed_mean(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_wsd_with_fixed_mean = gsl_stats_float_wsd_with_fixed_mean(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_float_wtss = gsl_stats_float_wtss(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_wtss_m = gsl_stats_float_wtss_m(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  fun stats_float_wabsdev = gsl_stats_float_wabsdev(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_wskew = gsl_stats_float_wskew(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_wkurtosis = gsl_stats_float_wkurtosis(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_wvariance_m = gsl_stats_float_wvariance_m(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  fun stats_float_wsd_m = gsl_stats_float_wsd_m(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  fun stats_float_wabsdev_m = gsl_stats_float_wabsdev_m(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  fun stats_float_wskew_m_sd = gsl_stats_float_wskew_m_sd(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double, wsd : LibC::Double) : LibC::Double
  fun stats_float_wkurtosis_m_sd = gsl_stats_float_wkurtosis_m_sd(w : LibC::Float*, wstride : LibC::SizeT, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double, wsd : LibC::Double) : LibC::Double
  fun stats_float_pvariance = gsl_stats_float_pvariance(data1 : LibC::Float*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Float*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_float_ttest = gsl_stats_float_ttest(data1 : LibC::Float*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Float*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_float_max = gsl_stats_float_max(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Float
  fun stats_float_min = gsl_stats_float_min(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Float
  fun stats_float_minmax = gsl_stats_float_minmax(min : LibC::Float*, max : LibC::Float*, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_float_max_index = gsl_stats_float_max_index(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_float_min_index = gsl_stats_float_min_index(data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_float_minmax_index = gsl_stats_float_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_float_median_from_sorted_data = gsl_stats_float_median_from_sorted_data(sorted_data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_float_quantile_from_sorted_data = gsl_stats_float_quantile_from_sorted_data(sorted_data : LibC::Float*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  # fun stats_long_double_mean = gsl_stats_long_double_mean(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_variance = gsl_stats_long_double_variance(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_sd = gsl_stats_long_double_sd(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_variance_with_fixed_mean = gsl_stats_long_double_variance_with_fixed_mean(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_sd_with_fixed_mean = gsl_stats_long_double_sd_with_fixed_mean(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_tss = gsl_stats_long_double_tss(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_tss_m = gsl_stats_long_double_tss_m(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_absdev = gsl_stats_long_double_absdev(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_skew = gsl_stats_long_double_skew(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_kurtosis = gsl_stats_long_double_kurtosis(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_lag1_autocorrelation = gsl_stats_long_double_lag1_autocorrelation(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_covariance = gsl_stats_long_double_covariance(data1 : LibC::LongDouble*, stride1 : LibC::SizeT, data2 : LibC::LongDouble*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_correlation = gsl_stats_long_double_correlation(data1 : LibC::LongDouble*, stride1 : LibC::SizeT, data2 : LibC::LongDouble*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_spearman = gsl_stats_long_double_spearman(data1 : LibC::LongDouble*, stride1 : LibC::SizeT, data2 : LibC::LongDouble*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  # fun stats_long_double_variance_m = gsl_stats_long_double_variance_m(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_sd_m = gsl_stats_long_double_sd_m(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_absdev_m = gsl_stats_long_double_absdev_m(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_skew_m_sd = gsl_stats_long_double_skew_m_sd(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  # fun stats_long_double_kurtosis_m_sd = gsl_stats_long_double_kurtosis_m_sd(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  # fun stats_long_double_lag1_autocorrelation_m = gsl_stats_long_double_lag1_autocorrelation_m(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_covariance_m = gsl_stats_long_double_covariance_m(data1 : LibC::LongDouble*, stride1 : LibC::SizeT, data2 : LibC::LongDouble*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  # fun stats_long_double_wmean = gsl_stats_long_double_wmean(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_wvariance = gsl_stats_long_double_wvariance(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_wsd = gsl_stats_long_double_wsd(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_wvariance_with_fixed_mean = gsl_stats_long_double_wvariance_with_fixed_mean(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_wsd_with_fixed_mean = gsl_stats_long_double_wsd_with_fixed_mean(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  # fun stats_long_double_wtss = gsl_stats_long_double_wtss(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_wtss_m = gsl_stats_long_double_wtss_m(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  # fun stats_long_double_wabsdev = gsl_stats_long_double_wabsdev(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_wskew = gsl_stats_long_double_wskew(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_wkurtosis = gsl_stats_long_double_wkurtosis(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_wvariance_m = gsl_stats_long_double_wvariance_m(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  # fun stats_long_double_wsd_m = gsl_stats_long_double_wsd_m(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  # fun stats_long_double_wabsdev_m = gsl_stats_long_double_wabsdev_m(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double) : LibC::Double
  # fun stats_long_double_wskew_m_sd = gsl_stats_long_double_wskew_m_sd(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double, wsd : LibC::Double) : LibC::Double
  # fun stats_long_double_wkurtosis_m_sd = gsl_stats_long_double_wkurtosis_m_sd(w : LibC::LongDouble*, wstride : LibC::SizeT, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, wmean : LibC::Double, wsd : LibC::Double) : LibC::Double
  # fun stats_long_double_pvariance = gsl_stats_long_double_pvariance(data1 : LibC::LongDouble*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::LongDouble*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  # fun stats_long_double_ttest = gsl_stats_long_double_ttest(data1 : LibC::LongDouble*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::LongDouble*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  # fun stats_long_double_max = gsl_stats_long_double_max(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::LongDouble
  # fun stats_long_double_min = gsl_stats_long_double_min(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::LongDouble
  # fun stats_long_double_minmax = gsl_stats_long_double_minmax(min : LibC::LongDouble*, max : LibC::LongDouble*, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT)
  # fun stats_long_double_max_index = gsl_stats_long_double_max_index(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  # fun stats_long_double_min_index = gsl_stats_long_double_min_index(data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  # fun stats_long_double_minmax_index = gsl_stats_long_double_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT)
  # fun stats_long_double_median_from_sorted_data = gsl_stats_long_double_median_from_sorted_data(sorted_data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  # fun stats_long_double_quantile_from_sorted_data = gsl_stats_long_double_quantile_from_sorted_data(sorted_data : LibC::LongDouble*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_ulong_mean = gsl_stats_ulong_mean(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_variance = gsl_stats_ulong_variance(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_sd = gsl_stats_ulong_sd(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_variance_with_fixed_mean = gsl_stats_ulong_variance_with_fixed_mean(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ulong_sd_with_fixed_mean = gsl_stats_ulong_sd_with_fixed_mean(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ulong_tss = gsl_stats_ulong_tss(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_tss_m = gsl_stats_ulong_tss_m(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ulong_absdev = gsl_stats_ulong_absdev(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_skew = gsl_stats_ulong_skew(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_kurtosis = gsl_stats_ulong_kurtosis(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_lag1_autocorrelation = gsl_stats_ulong_lag1_autocorrelation(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_covariance = gsl_stats_ulong_covariance(data1 : LibC::ULong*, stride1 : LibC::SizeT, data2 : LibC::ULong*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_correlation = gsl_stats_ulong_correlation(data1 : LibC::ULong*, stride1 : LibC::SizeT, data2 : LibC::ULong*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_spearman = gsl_stats_ulong_spearman(data1 : LibC::ULong*, stride1 : LibC::SizeT, data2 : LibC::ULong*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_ulong_variance_m = gsl_stats_ulong_variance_m(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ulong_sd_m = gsl_stats_ulong_sd_m(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ulong_absdev_m = gsl_stats_ulong_absdev_m(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ulong_skew_m_sd = gsl_stats_ulong_skew_m_sd(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_ulong_kurtosis_m_sd = gsl_stats_ulong_kurtosis_m_sd(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_ulong_lag1_autocorrelation_m = gsl_stats_ulong_lag1_autocorrelation_m(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ulong_covariance_m = gsl_stats_ulong_covariance_m(data1 : LibC::ULong*, stride1 : LibC::SizeT, data2 : LibC::ULong*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_ulong_pvariance = gsl_stats_ulong_pvariance(data1 : LibC::ULong*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::ULong*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_ulong_ttest = gsl_stats_ulong_ttest(data1 : LibC::ULong*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::ULong*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_ulong_max = gsl_stats_ulong_max(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::ULong
  fun stats_ulong_min = gsl_stats_ulong_min(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::ULong
  fun stats_ulong_minmax = gsl_stats_ulong_minmax(min : LibC::ULong*, max : LibC::ULong*, data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_ulong_max_index = gsl_stats_ulong_max_index(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_ulong_min_index = gsl_stats_ulong_min_index(data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_ulong_minmax_index = gsl_stats_ulong_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_ulong_median_from_sorted_data = gsl_stats_ulong_median_from_sorted_data(sorted_data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ulong_quantile_from_sorted_data = gsl_stats_ulong_quantile_from_sorted_data(sorted_data : LibC::ULong*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_long_mean = gsl_stats_long_mean(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_variance = gsl_stats_long_variance(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_sd = gsl_stats_long_sd(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_variance_with_fixed_mean = gsl_stats_long_variance_with_fixed_mean(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_long_sd_with_fixed_mean = gsl_stats_long_sd_with_fixed_mean(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_long_tss = gsl_stats_long_tss(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_tss_m = gsl_stats_long_tss_m(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_long_absdev = gsl_stats_long_absdev(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_skew = gsl_stats_long_skew(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_kurtosis = gsl_stats_long_kurtosis(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_lag1_autocorrelation = gsl_stats_long_lag1_autocorrelation(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_covariance = gsl_stats_long_covariance(data1 : LibC::Long*, stride1 : LibC::SizeT, data2 : LibC::Long*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_correlation = gsl_stats_long_correlation(data1 : LibC::Long*, stride1 : LibC::SizeT, data2 : LibC::Long*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_spearman = gsl_stats_long_spearman(data1 : LibC::Long*, stride1 : LibC::SizeT, data2 : LibC::Long*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_long_variance_m = gsl_stats_long_variance_m(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_long_sd_m = gsl_stats_long_sd_m(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_long_absdev_m = gsl_stats_long_absdev_m(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_long_skew_m_sd = gsl_stats_long_skew_m_sd(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_long_kurtosis_m_sd = gsl_stats_long_kurtosis_m_sd(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_long_lag1_autocorrelation_m = gsl_stats_long_lag1_autocorrelation_m(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_long_covariance_m = gsl_stats_long_covariance_m(data1 : LibC::Long*, stride1 : LibC::SizeT, data2 : LibC::Long*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_long_pvariance = gsl_stats_long_pvariance(data1 : LibC::Long*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Long*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_long_ttest = gsl_stats_long_ttest(data1 : LibC::Long*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Long*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_long_max = gsl_stats_long_max(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Long
  fun stats_long_min = gsl_stats_long_min(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Long
  fun stats_long_minmax = gsl_stats_long_minmax(min : LibC::Long*, max : LibC::Long*, data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_long_max_index = gsl_stats_long_max_index(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_long_min_index = gsl_stats_long_min_index(data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_long_minmax_index = gsl_stats_long_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_long_median_from_sorted_data = gsl_stats_long_median_from_sorted_data(sorted_data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_long_quantile_from_sorted_data = gsl_stats_long_quantile_from_sorted_data(sorted_data : LibC::Long*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_uint_mean = gsl_stats_uint_mean(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_variance = gsl_stats_uint_variance(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_sd = gsl_stats_uint_sd(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_variance_with_fixed_mean = gsl_stats_uint_variance_with_fixed_mean(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uint_sd_with_fixed_mean = gsl_stats_uint_sd_with_fixed_mean(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uint_tss = gsl_stats_uint_tss(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_tss_m = gsl_stats_uint_tss_m(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uint_absdev = gsl_stats_uint_absdev(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_skew = gsl_stats_uint_skew(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_kurtosis = gsl_stats_uint_kurtosis(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_lag1_autocorrelation = gsl_stats_uint_lag1_autocorrelation(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_covariance = gsl_stats_uint_covariance(data1 : LibC::UInt*, stride1 : LibC::SizeT, data2 : LibC::UInt*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_correlation = gsl_stats_uint_correlation(data1 : LibC::UInt*, stride1 : LibC::SizeT, data2 : LibC::UInt*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_spearman = gsl_stats_uint_spearman(data1 : LibC::UInt*, stride1 : LibC::SizeT, data2 : LibC::UInt*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_uint_variance_m = gsl_stats_uint_variance_m(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uint_sd_m = gsl_stats_uint_sd_m(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uint_absdev_m = gsl_stats_uint_absdev_m(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uint_skew_m_sd = gsl_stats_uint_skew_m_sd(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_uint_kurtosis_m_sd = gsl_stats_uint_kurtosis_m_sd(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_uint_lag1_autocorrelation_m = gsl_stats_uint_lag1_autocorrelation_m(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uint_covariance_m = gsl_stats_uint_covariance_m(data1 : LibC::UInt*, stride1 : LibC::SizeT, data2 : LibC::UInt*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_uint_pvariance = gsl_stats_uint_pvariance(data1 : LibC::UInt*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::UInt*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_uint_ttest = gsl_stats_uint_ttest(data1 : LibC::UInt*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::UInt*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_uint_max = gsl_stats_uint_max(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::UInt
  fun stats_uint_min = gsl_stats_uint_min(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::UInt
  fun stats_uint_minmax = gsl_stats_uint_minmax(min : LibC::UInt*, max : LibC::UInt*, data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_uint_max_index = gsl_stats_uint_max_index(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_uint_min_index = gsl_stats_uint_min_index(data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_uint_minmax_index = gsl_stats_uint_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_uint_median_from_sorted_data = gsl_stats_uint_median_from_sorted_data(sorted_data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uint_quantile_from_sorted_data = gsl_stats_uint_quantile_from_sorted_data(sorted_data : LibC::UInt*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_int_mean = gsl_stats_int_mean(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_variance = gsl_stats_int_variance(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_sd = gsl_stats_int_sd(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_variance_with_fixed_mean = gsl_stats_int_variance_with_fixed_mean(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_int_sd_with_fixed_mean = gsl_stats_int_sd_with_fixed_mean(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_int_tss = gsl_stats_int_tss(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_tss_m = gsl_stats_int_tss_m(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_int_absdev = gsl_stats_int_absdev(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_skew = gsl_stats_int_skew(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_kurtosis = gsl_stats_int_kurtosis(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_lag1_autocorrelation = gsl_stats_int_lag1_autocorrelation(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_covariance = gsl_stats_int_covariance(data1 : LibC::Int*, stride1 : LibC::SizeT, data2 : LibC::Int*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_correlation = gsl_stats_int_correlation(data1 : LibC::Int*, stride1 : LibC::SizeT, data2 : LibC::Int*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_spearman = gsl_stats_int_spearman(data1 : LibC::Int*, stride1 : LibC::SizeT, data2 : LibC::Int*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_int_variance_m = gsl_stats_int_variance_m(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_int_sd_m = gsl_stats_int_sd_m(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_int_absdev_m = gsl_stats_int_absdev_m(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_int_skew_m_sd = gsl_stats_int_skew_m_sd(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_int_kurtosis_m_sd = gsl_stats_int_kurtosis_m_sd(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_int_lag1_autocorrelation_m = gsl_stats_int_lag1_autocorrelation_m(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_int_covariance_m = gsl_stats_int_covariance_m(data1 : LibC::Int*, stride1 : LibC::SizeT, data2 : LibC::Int*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_int_pvariance = gsl_stats_int_pvariance(data1 : LibC::Int*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Int*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_int_ttest = gsl_stats_int_ttest(data1 : LibC::Int*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Int*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_int_max = gsl_stats_int_max(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun stats_int_min = gsl_stats_int_min(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Int
  fun stats_int_minmax = gsl_stats_int_minmax(min : LibC::Int*, max : LibC::Int*, data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_int_max_index = gsl_stats_int_max_index(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_int_min_index = gsl_stats_int_min_index(data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_int_minmax_index = gsl_stats_int_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_int_median_from_sorted_data = gsl_stats_int_median_from_sorted_data(sorted_data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_int_quantile_from_sorted_data = gsl_stats_int_quantile_from_sorted_data(sorted_data : LibC::Int*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_ushort_mean = gsl_stats_ushort_mean(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_variance = gsl_stats_ushort_variance(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_sd = gsl_stats_ushort_sd(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_variance_with_fixed_mean = gsl_stats_ushort_variance_with_fixed_mean(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ushort_sd_with_fixed_mean = gsl_stats_ushort_sd_with_fixed_mean(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ushort_tss = gsl_stats_ushort_tss(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_tss_m = gsl_stats_ushort_tss_m(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ushort_absdev = gsl_stats_ushort_absdev(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_skew = gsl_stats_ushort_skew(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_kurtosis = gsl_stats_ushort_kurtosis(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_lag1_autocorrelation = gsl_stats_ushort_lag1_autocorrelation(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_covariance = gsl_stats_ushort_covariance(data1 : LibC::UShort*, stride1 : LibC::SizeT, data2 : LibC::UShort*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_correlation = gsl_stats_ushort_correlation(data1 : LibC::UShort*, stride1 : LibC::SizeT, data2 : LibC::UShort*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_spearman = gsl_stats_ushort_spearman(data1 : LibC::UShort*, stride1 : LibC::SizeT, data2 : LibC::UShort*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_ushort_variance_m = gsl_stats_ushort_variance_m(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ushort_sd_m = gsl_stats_ushort_sd_m(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ushort_absdev_m = gsl_stats_ushort_absdev_m(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ushort_skew_m_sd = gsl_stats_ushort_skew_m_sd(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_ushort_kurtosis_m_sd = gsl_stats_ushort_kurtosis_m_sd(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_ushort_lag1_autocorrelation_m = gsl_stats_ushort_lag1_autocorrelation_m(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_ushort_covariance_m = gsl_stats_ushort_covariance_m(data1 : LibC::UShort*, stride1 : LibC::SizeT, data2 : LibC::UShort*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_ushort_pvariance = gsl_stats_ushort_pvariance(data1 : LibC::UShort*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::UShort*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_ushort_ttest = gsl_stats_ushort_ttest(data1 : LibC::UShort*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::UShort*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_ushort_max = gsl_stats_ushort_max(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::UShort
  fun stats_ushort_min = gsl_stats_ushort_min(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::UShort
  fun stats_ushort_minmax = gsl_stats_ushort_minmax(min : LibC::UShort*, max : LibC::UShort*, data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_ushort_max_index = gsl_stats_ushort_max_index(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_ushort_min_index = gsl_stats_ushort_min_index(data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_ushort_minmax_index = gsl_stats_ushort_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_ushort_median_from_sorted_data = gsl_stats_ushort_median_from_sorted_data(sorted_data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_ushort_quantile_from_sorted_data = gsl_stats_ushort_quantile_from_sorted_data(sorted_data : LibC::UShort*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_short_mean = gsl_stats_short_mean(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_variance = gsl_stats_short_variance(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_sd = gsl_stats_short_sd(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_variance_with_fixed_mean = gsl_stats_short_variance_with_fixed_mean(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_short_sd_with_fixed_mean = gsl_stats_short_sd_with_fixed_mean(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_short_tss = gsl_stats_short_tss(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_tss_m = gsl_stats_short_tss_m(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_short_absdev = gsl_stats_short_absdev(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_skew = gsl_stats_short_skew(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_kurtosis = gsl_stats_short_kurtosis(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_lag1_autocorrelation = gsl_stats_short_lag1_autocorrelation(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_covariance = gsl_stats_short_covariance(data1 : LibC::Short*, stride1 : LibC::SizeT, data2 : LibC::Short*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_correlation = gsl_stats_short_correlation(data1 : LibC::Short*, stride1 : LibC::SizeT, data2 : LibC::Short*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_spearman = gsl_stats_short_spearman(data1 : LibC::Short*, stride1 : LibC::SizeT, data2 : LibC::Short*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_short_variance_m = gsl_stats_short_variance_m(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_short_sd_m = gsl_stats_short_sd_m(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_short_absdev_m = gsl_stats_short_absdev_m(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_short_skew_m_sd = gsl_stats_short_skew_m_sd(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_short_kurtosis_m_sd = gsl_stats_short_kurtosis_m_sd(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_short_lag1_autocorrelation_m = gsl_stats_short_lag1_autocorrelation_m(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_short_covariance_m = gsl_stats_short_covariance_m(data1 : LibC::Short*, stride1 : LibC::SizeT, data2 : LibC::Short*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_short_pvariance = gsl_stats_short_pvariance(data1 : LibC::Short*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Short*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_short_ttest = gsl_stats_short_ttest(data1 : LibC::Short*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : LibC::Short*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_short_max = gsl_stats_short_max(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Short
  fun stats_short_min = gsl_stats_short_min(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Short
  fun stats_short_minmax = gsl_stats_short_minmax(min : LibC::Short*, max : LibC::Short*, data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_short_max_index = gsl_stats_short_max_index(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_short_min_index = gsl_stats_short_min_index(data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_short_minmax_index = gsl_stats_short_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_short_median_from_sorted_data = gsl_stats_short_median_from_sorted_data(sorted_data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_short_quantile_from_sorted_data = gsl_stats_short_quantile_from_sorted_data(sorted_data : LibC::Short*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun stats_uchar_mean = gsl_stats_uchar_mean(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_variance = gsl_stats_uchar_variance(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_sd = gsl_stats_uchar_sd(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_variance_with_fixed_mean = gsl_stats_uchar_variance_with_fixed_mean(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uchar_sd_with_fixed_mean = gsl_stats_uchar_sd_with_fixed_mean(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uchar_tss = gsl_stats_uchar_tss(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_tss_m = gsl_stats_uchar_tss_m(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uchar_absdev = gsl_stats_uchar_absdev(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_skew = gsl_stats_uchar_skew(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_kurtosis = gsl_stats_uchar_kurtosis(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_lag1_autocorrelation = gsl_stats_uchar_lag1_autocorrelation(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_covariance = gsl_stats_uchar_covariance(data1 : UInt8*, stride1 : LibC::SizeT, data2 : UInt8*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_correlation = gsl_stats_uchar_correlation(data1 : UInt8*, stride1 : LibC::SizeT, data2 : UInt8*, stride2 : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_spearman = gsl_stats_uchar_spearman(data1 : UInt8*, stride1 : LibC::SizeT, data2 : UInt8*, stride2 : LibC::SizeT, n : LibC::SizeT, work : LibC::Double*) : LibC::Double
  fun stats_uchar_variance_m = gsl_stats_uchar_variance_m(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uchar_sd_m = gsl_stats_uchar_sd_m(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uchar_absdev_m = gsl_stats_uchar_absdev_m(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uchar_skew_m_sd = gsl_stats_uchar_skew_m_sd(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_uchar_kurtosis_m_sd = gsl_stats_uchar_kurtosis_m_sd(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double, sd : LibC::Double) : LibC::Double
  fun stats_uchar_lag1_autocorrelation_m = gsl_stats_uchar_lag1_autocorrelation_m(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, mean : LibC::Double) : LibC::Double
  fun stats_uchar_covariance_m = gsl_stats_uchar_covariance_m(data1 : UInt8*, stride1 : LibC::SizeT, data2 : UInt8*, stride2 : LibC::SizeT, n : LibC::SizeT, mean1 : LibC::Double, mean2 : LibC::Double) : LibC::Double
  fun stats_uchar_pvariance = gsl_stats_uchar_pvariance(data1 : UInt8*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : UInt8*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_uchar_ttest = gsl_stats_uchar_ttest(data1 : UInt8*, stride1 : LibC::SizeT, n1 : LibC::SizeT, data2 : UInt8*, stride2 : LibC::SizeT, n2 : LibC::SizeT) : LibC::Double
  fun stats_uchar_max = gsl_stats_uchar_max(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : UInt8
  fun stats_uchar_min = gsl_stats_uchar_min(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : UInt8
  fun stats_uchar_minmax = gsl_stats_uchar_minmax(min : UInt8*, max : UInt8*, data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_uchar_max_index = gsl_stats_uchar_max_index(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_uchar_min_index = gsl_stats_uchar_min_index(data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::SizeT
  fun stats_uchar_minmax_index = gsl_stats_uchar_minmax_index(min_index : LibC::SizeT*, max_index : LibC::SizeT*, data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT)
  fun stats_uchar_median_from_sorted_data = gsl_stats_uchar_median_from_sorted_data(sorted_data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT) : LibC::Double
  fun stats_uchar_quantile_from_sorted_data = gsl_stats_uchar_quantile_from_sorted_data(sorted_data : UInt8*, stride : LibC::SizeT, n : LibC::SizeT, f : LibC::Double) : LibC::Double
  fun sum_levin_u_alloc = gsl_sum_levin_u_alloc(n : LibC::SizeT) : SumLevinUWorkspace*

  struct SumLevinUWorkspace
    size : LibC::SizeT
    i : LibC::SizeT
    terms_used : LibC::SizeT
    sum_plain : LibC::Double
    q_num : LibC::Double*
    q_den : LibC::Double*
    dq_num : LibC::Double*
    dq_den : LibC::Double*
    dsum : LibC::Double*
  end

  fun sum_levin_u_free = gsl_sum_levin_u_free(w : SumLevinUWorkspace*)
  fun sum_levin_u_accel = gsl_sum_levin_u_accel(array : LibC::Double*, n : LibC::SizeT, w : SumLevinUWorkspace*, sum_accel : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun sum_levin_u_minmax = gsl_sum_levin_u_minmax(array : LibC::Double*, n : LibC::SizeT, min_terms : LibC::SizeT, max_terms : LibC::SizeT, w : SumLevinUWorkspace*, sum_accel : LibC::Double*, abserr : LibC::Double*) : LibC::Int
  fun sum_levin_u_step = gsl_sum_levin_u_step(term : LibC::Double, n : LibC::SizeT, nmax : LibC::SizeT, w : SumLevinUWorkspace*, sum_accel : LibC::Double*) : LibC::Int
  fun sum_levin_utrunc_alloc = gsl_sum_levin_utrunc_alloc(n : LibC::SizeT) : SumLevinUtruncWorkspace*

  struct SumLevinUtruncWorkspace
    size : LibC::SizeT
    i : LibC::SizeT
    terms_used : LibC::SizeT
    sum_plain : LibC::Double
    q_num : LibC::Double*
    q_den : LibC::Double*
    dsum : LibC::Double*
  end

  fun sum_levin_utrunc_free = gsl_sum_levin_utrunc_free(w : SumLevinUtruncWorkspace*)
  fun sum_levin_utrunc_accel = gsl_sum_levin_utrunc_accel(array : LibC::Double*, n : LibC::SizeT, w : SumLevinUtruncWorkspace*, sum_accel : LibC::Double*, abserr_trunc : LibC::Double*) : LibC::Int
  fun sum_levin_utrunc_minmax = gsl_sum_levin_utrunc_minmax(array : LibC::Double*, n : LibC::SizeT, min_terms : LibC::SizeT, max_terms : LibC::SizeT, w : SumLevinUtruncWorkspace*, sum_accel : LibC::Double*, abserr_trunc : LibC::Double*) : LibC::Int
  fun sum_levin_utrunc_step = gsl_sum_levin_utrunc_step(term : LibC::Double, n : LibC::SizeT, w : SumLevinUtruncWorkspace*, sum_accel : LibC::Double*) : LibC::Int
  fun test = gsl_test(status : LibC::Int, test_description : LibC::Char*, ...)
  fun test_rel = gsl_test_rel(result : LibC::Double, expected : LibC::Double, relative_error : LibC::Double, test_description : LibC::Char*, ...)
  fun test_abs = gsl_test_abs(result : LibC::Double, expected : LibC::Double, absolute_error : LibC::Double, test_description : LibC::Char*, ...)
  fun test_factor = gsl_test_factor(result : LibC::Double, expected : LibC::Double, factor : LibC::Double, test_description : LibC::Char*, ...)
  fun test_int = gsl_test_int(result : LibC::Int, expected : LibC::Int, test_description : LibC::Char*, ...)
  fun test_str = gsl_test_str(result : LibC::Char*, expected : LibC::Char*, test_description : LibC::Char*, ...)
  fun test_verbose = gsl_test_verbose(verbose : LibC::Int)
  fun test_summary = gsl_test_summary : LibC::Int
  WaveletForward  =  1
  WaveletBackward = -1

  struct WaveletType
    name : LibC::Char*
    init : (LibC::Double**, LibC::Double**, LibC::Double**, LibC::Double**, LibC::SizeT*, LibC::SizeT*, LibC::SizeT -> LibC::Int)
  end

  fun wavelet_alloc = gsl_wavelet_alloc(t : WaveletType*, k : LibC::SizeT) : Wavelet*

  struct Wavelet
    type : WaveletType*
    h1 : LibC::Double*
    g1 : LibC::Double*
    h2 : LibC::Double*
    g2 : LibC::Double*
    nc : LibC::SizeT
    offset : LibC::SizeT
  end

  fun wavelet_free = gsl_wavelet_free(w : Wavelet*)
  fun wavelet_name = gsl_wavelet_name(w : Wavelet*) : LibC::Char*
  fun wavelet_workspace_alloc = gsl_wavelet_workspace_alloc(n : LibC::SizeT) : WaveletWorkspace*

  struct WaveletWorkspace
    scratch : LibC::Double*
    n : LibC::SizeT
  end

  fun wavelet_workspace_free = gsl_wavelet_workspace_free(work : WaveletWorkspace*)
  fun wavelet_transform = gsl_wavelet_transform(w : Wavelet*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, dir : WaveletDirection, work : WaveletWorkspace*) : LibC::Int
  enum WaveletDirection
    WaveletForward  =  1
    WaveletBackward = -1
  end
  fun wavelet_transform_forward = gsl_wavelet_transform_forward(w : Wavelet*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, work : WaveletWorkspace*) : LibC::Int
  fun wavelet_transform_inverse = gsl_wavelet_transform_inverse(w : Wavelet*, data : LibC::Double*, stride : LibC::SizeT, n : LibC::SizeT, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_transform = gsl_wavelet2d_transform(w : Wavelet*, data : LibC::Double*, tda : LibC::SizeT, size1 : LibC::SizeT, size2 : LibC::SizeT, dir : WaveletDirection, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_transform_forward = gsl_wavelet2d_transform_forward(w : Wavelet*, data : LibC::Double*, tda : LibC::SizeT, size1 : LibC::SizeT, size2 : LibC::SizeT, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_transform_inverse = gsl_wavelet2d_transform_inverse(w : Wavelet*, data : LibC::Double*, tda : LibC::SizeT, size1 : LibC::SizeT, size2 : LibC::SizeT, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_nstransform = gsl_wavelet2d_nstransform(w : Wavelet*, data : LibC::Double*, tda : LibC::SizeT, size1 : LibC::SizeT, size2 : LibC::SizeT, dir : WaveletDirection, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_nstransform_forward = gsl_wavelet2d_nstransform_forward(w : Wavelet*, data : LibC::Double*, tda : LibC::SizeT, size1 : LibC::SizeT, size2 : LibC::SizeT, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_nstransform_inverse = gsl_wavelet2d_nstransform_inverse(w : Wavelet*, data : LibC::Double*, tda : LibC::SizeT, size1 : LibC::SizeT, size2 : LibC::SizeT, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_transform_matrix = gsl_wavelet2d_transform_matrix(w : Wavelet*, a : Matrix*, dir : WaveletDirection, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_transform_matrix_forward = gsl_wavelet2d_transform_matrix_forward(w : Wavelet*, a : Matrix*, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_transform_matrix_inverse = gsl_wavelet2d_transform_matrix_inverse(w : Wavelet*, a : Matrix*, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_nstransform_matrix = gsl_wavelet2d_nstransform_matrix(w : Wavelet*, a : Matrix*, dir : WaveletDirection, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_nstransform_matrix_forward = gsl_wavelet2d_nstransform_matrix_forward(w : Wavelet*, a : Matrix*, work : WaveletWorkspace*) : LibC::Int
  fun wavelet2d_nstransform_matrix_inverse = gsl_wavelet2d_nstransform_matrix_inverse(w : Wavelet*, a : Matrix*, work : WaveletWorkspace*) : LibC::Int
  $check_range : LibC::Int
  $prec_eps : LibC::Double*
  $prec_sqrt_eps : LibC::Double*
  $prec_root3_eps : LibC::Double*
  $prec_root4_eps : LibC::Double*
  $prec_root5_eps : LibC::Double*
  $prec_root6_eps : LibC::Double*
  $integration_fixed_legendre : IntegrationFixedType*
  $integration_fixed_chebyshev : IntegrationFixedType*
  $integration_fixed_gegenbauer : IntegrationFixedType*
  $integration_fixed_jacobi : IntegrationFixedType*
  $integration_fixed_laguerre : IntegrationFixedType*
  $integration_fixed_hermite : IntegrationFixedType*
  $integration_fixed_exponential : IntegrationFixedType*
  $integration_fixed_rational : IntegrationFixedType*
  $integration_fixed_chebyshev2 : IntegrationFixedType*
  $interp_linear : InterpType*
  $interp_polynomial : InterpType*
  $interp_cspline : InterpType*
  $interp_cspline_periodic : InterpType*
  $interp_akima : InterpType*
  $interp_akima_periodic : InterpType*
  $interp_steffen : InterpType*
  $interp2d_bilinear : Interp2dType*
  $interp2d_bicubic : Interp2dType*
  $message_mask : LibC::UInt
  $min_fminimizer_goldensection : MinFminimizerType*
  $min_fminimizer_brent : MinFminimizerType*
  $min_fminimizer_quad_golden : MinFminimizerType*
  $rng_borosh13 : RngType*
  $rng_coveyou : RngType*
  $rng_cmrg : RngType*
  $rng_fishman18 : RngType*
  $rng_fishman20 : RngType*
  $rng_fishman2x : RngType*
  $rng_gfsr4 : RngType*
  $rng_knuthran : RngType*
  $rng_knuthran2 : RngType*
  $rng_knuthran2002 : RngType*
  $rng_lecuyer21 : RngType*
  $rng_minstd : RngType*
  $rng_mrg : RngType*
  $rng_mt19937 : RngType*
  $rng_mt19937_1999 : RngType*
  $rng_mt19937_1998 : RngType*
  $rng_r250 : RngType*
  $rng_ran0 : RngType*
  $rng_ran1 : RngType*
  $rng_ran2 : RngType*
  $rng_ran3 : RngType*
  $rng_rand : RngType*
  $rng_rand48 : RngType*
  $rng_random128_bsd : RngType*
  $rng_random128_glibc2 : RngType*
  $rng_random128_libc5 : RngType*
  $rng_random256_bsd : RngType*
  $rng_random256_glibc2 : RngType*
  $rng_random256_libc5 : RngType*
  $rng_random32_bsd : RngType*
  $rng_random32_glibc2 : RngType*
  $rng_random32_libc5 : RngType*
  $rng_random64_bsd : RngType*
  $rng_random64_glibc2 : RngType*
  $rng_random64_libc5 : RngType*
  $rng_random8_bsd : RngType*
  $rng_random8_glibc2 : RngType*
  $rng_random8_libc5 : RngType*
  $rng_random_bsd : RngType*
  $rng_random_glibc2 : RngType*
  $rng_random_libc5 : RngType*
  $rng_randu : RngType*
  $rng_ranf : RngType*
  $rng_ranlux : RngType*
  $rng_ranlux389 : RngType*
  $rng_ranlxd1 : RngType*
  $rng_ranlxd2 : RngType*
  $rng_ranlxs0 : RngType*
  $rng_ranlxs1 : RngType*
  $rng_ranlxs2 : RngType*
  $rng_ranmar : RngType*
  $rng_slatec : RngType*
  $rng_taus : RngType*
  $rng_taus2 : RngType*
  $rng_taus113 : RngType*
  $rng_transputer : RngType*
  $rng_tt800 : RngType*
  $rng_uni : RngType*
  $rng_uni32 : RngType*
  $rng_vax : RngType*
  $rng_waterman14 : RngType*
  $rng_zuf : RngType*
  $rng_default : RngType*
  $rng_default_seed : LibC::ULong
  $multifit_robust_default : MultifitRobustType*
  $multifit_robust_bisquare : MultifitRobustType*
  $multifit_robust_cauchy : MultifitRobustType*
  $multifit_robust_fair : MultifitRobustType*
  $multifit_robust_huber : MultifitRobustType*
  $multifit_robust_ols : MultifitRobustType*
  $multifit_robust_welsch : MultifitRobustType*
  $multifit_nlinear_trust : MultifitNlinearType*
  $multifit_nlinear_trs_lm : MultifitNlinearTrs*
  $multifit_nlinear_trs_lmaccel : MultifitNlinearTrs*
  $multifit_nlinear_trs_dogleg : MultifitNlinearTrs*
  $multifit_nlinear_trs_ddogleg : MultifitNlinearTrs*
  $multifit_nlinear_trs_subspace2D : MultifitNlinearTrs*
  $multifit_nlinear_scale_levenberg : MultifitNlinearScale*
  $multifit_nlinear_scale_marquardt : MultifitNlinearScale*
  $multifit_nlinear_scale_more : MultifitNlinearScale*
  $multifit_nlinear_solver_cholesky : MultifitNlinearSolver*
  $multifit_nlinear_solver_qr : MultifitNlinearSolver*
  $multifit_nlinear_solver_svd : MultifitNlinearSolver*
  $multifit_fdfsolver_lmsder : MultifitFdfsolverType*
  $multifit_fdfsolver_lmder : MultifitFdfsolverType*
  $multifit_fdfsolver_lmniel : MultifitFdfsolverType*
  $multilarge_linear_normal : MultilargeLinearType*
  $multilarge_linear_tsqr : MultilargeLinearType*
  $multilarge_nlinear_trust : MultilargeNlinearType*
  $multilarge_nlinear_trs_lm : MultilargeNlinearTrs*
  $multilarge_nlinear_trs_lmaccel : MultilargeNlinearTrs*
  $multilarge_nlinear_trs_dogleg : MultilargeNlinearTrs*
  $multilarge_nlinear_trs_ddogleg : MultilargeNlinearTrs*
  $multilarge_nlinear_trs_subspace2D : MultilargeNlinearTrs*
  $multilarge_nlinear_trs_cgst : MultilargeNlinearTrs*
  $multilarge_nlinear_scale_levenberg : MultilargeNlinearScale*
  $multilarge_nlinear_scale_marquardt : MultilargeNlinearScale*
  $multilarge_nlinear_scale_more : MultilargeNlinearScale*
  $multilarge_nlinear_solver_cholesky : MultilargeNlinearSolver*
  $multilarge_nlinear_solver_none : MultilargeNlinearSolver*
  $multimin_fdfminimizer_steepest_descent : MultiminFdfminimizerType*
  $multimin_fdfminimizer_conjugate_pr : MultiminFdfminimizerType*
  $multimin_fdfminimizer_conjugate_fr : MultiminFdfminimizerType*
  $multimin_fdfminimizer_vector_bfgs : MultiminFdfminimizerType*
  $multimin_fdfminimizer_vector_bfgs2 : MultiminFdfminimizerType*
  $multimin_fminimizer_nmsimplex : MultiminFminimizerType*
  $multimin_fminimizer_nmsimplex2 : MultiminFminimizerType*
  $multimin_fminimizer_nmsimplex2rand : MultiminFminimizerType*
  $multiroot_fsolver_dnewton : MultirootFsolverType*
  $multiroot_fsolver_broyden : MultirootFsolverType*
  $multiroot_fsolver_hybrid : MultirootFsolverType*
  $multiroot_fsolver_hybrids : MultirootFsolverType*
  $multiroot_fdfsolver_newton : MultirootFdfsolverType*
  $multiroot_fdfsolver_gnewton : MultirootFdfsolverType*
  $multiroot_fdfsolver_hybridj : MultirootFdfsolverType*
  $multiroot_fdfsolver_hybridsj : MultirootFdfsolverType*
  $odeiv2_step_rk2 : Odeiv2StepType*
  $odeiv2_step_rk4 : Odeiv2StepType*
  $odeiv2_step_rkf45 : Odeiv2StepType*
  $odeiv2_step_rkck : Odeiv2StepType*
  $odeiv2_step_rk8pd : Odeiv2StepType*
  $odeiv2_step_rk2imp : Odeiv2StepType*
  $odeiv2_step_rk4imp : Odeiv2StepType*
  $odeiv2_step_bsimp : Odeiv2StepType*
  $odeiv2_step_rk1imp : Odeiv2StepType*
  $odeiv2_step_msadams : Odeiv2StepType*
  $odeiv2_step_msbdf : Odeiv2StepType*
  $odeiv_step_rk2 : OdeivStepType*
  $odeiv_step_rk4 : OdeivStepType*
  $odeiv_step_rkf45 : OdeivStepType*
  $odeiv_step_rkck : OdeivStepType*
  $odeiv_step_rk8pd : OdeivStepType*
  $odeiv_step_rk2imp : OdeivStepType*
  $odeiv_step_rk2simp : OdeivStepType*
  $odeiv_step_rk4imp : OdeivStepType*
  $odeiv_step_bsimp : OdeivStepType*
  $odeiv_step_gear1 : OdeivStepType*
  $odeiv_step_gear2 : OdeivStepType*
  $qrng_niederreiter_2 : QrngType*
  $qrng_sobol : QrngType*
  $qrng_halton : QrngType*
  $qrng_reversehalton : QrngType*
  $root_fsolver_bisection : RootFsolverType*
  $root_fsolver_brent : RootFsolverType*
  $root_fsolver_falsepos : RootFsolverType*
  $root_fdfsolver_newton : RootFdfsolverType*
  $root_fdfsolver_secant : RootFdfsolverType*
  $root_fdfsolver_steffenson : RootFdfsolverType*
  $splinalg_itersolve_gmres : SplinalgItersolveType*
  $version : LibC::Char*
  $wavelet_daubechies : WaveletType*
  $wavelet_daubechies_centered : WaveletType*
  $wavelet_haar : WaveletType*
  $wavelet_haar_centered : WaveletType*
  $wavelet_bspline : WaveletType*
  $wavelet_bspline_centered : WaveletType*
end

module GSL
  RNG = LibGSL.rng_alloc(LibGSL.rng_env_setup)
end
