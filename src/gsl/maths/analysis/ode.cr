# This module implements [Ordinary Differential Equations](https://www.gnu.org/software/gsl/doc/html/ode-initval.html) solving (initial value problems)
#
# Usage examples:
#
# For systems without Jacobian information:
# ```
# class TestODE < GSL::ODE::System
#   def initialize(@k : Float64)
#     super(2) # dimension of system
#   end
#
#   # Override `function` with your system (evaluate dy/dt = f(t, y))
#   def function(t, y, dydt)
#     dydt[0] = y[1]
#     dydt[1] = -@k * y[0]
#   end
# end
#
# # Evolve system using adaptive step, returns two arrays
# y0 = [1, 0]
# y, t = ode.evolve(y0, 0, Math::PI/2)
#
# # Evolve system using given time points, return array of y states at this points
# y0 = [0, 10]
# results = ode.evolve(y0, [0, Math::PI/2, Math::PI, 3*Math::PI/2, Math::PI*2])
#
# # Evolve system using fixed time step, result same as previuos
# y0 = [0, 10]
# results = ode.evolve(y0, 0, Math::PI*2, Math::PI/2)
#
# # Yielding versions of all above are available
# y0 = [1, 0]
# ode.evolve(y0, 0, Math::PI/2) do |y, t|
#   puts "time=#{t}: state #{y}"
# end
# ```
# When Jacobian information is available, use JacobianSystem:
# ```
# class TestODEJacobian < GSL::ODE::JacobianSystem
#   def initialize(@mu : Float64)
#     super(2) # dimension of system
#   end
#
#   # evaluate dy/dt = f(t, y) here
#   def function(t, y, dydt)
#     dydt[0] = y[1]
#     dydt[1] = -y[0] - @mu * y[1]*(y[0]*y[0] - 1)
#   end
#
#   # evaluate Jacobian ∂f/∂y and ∂f/∂t here
#   def jacobian(t, y, dfdy, dfdt)
#     dfdy[0] = 0
#     dfdy[1] = 1.0
#     dfdy[2] = -2.0*@mu*y[0]*y[1] - 1.0
#     dfdy[3] = -@mu*(y[0]*y[0] - 1.0)
#     dfdt[0] = 0.0
#     dfdt[1] = 0.0
#   end
# end
# ```
module GSL::ODE
  # Abstract base class for ODE systems. Defines interface for `function`.
  abstract class System
    # Shared C callback wrapper for GSL; calls `function` on the Crystal object.
    @@same_function : (LibC::Double, LibC::Double*, LibC::Double*, Void* -> LibC::Int) = ->(t : LibC::Double, y : LibC::Double*, dydt : LibC::Double*, data : Void*) do
      sys = data.as(System)
      sys.function(t, y.to_slice(sys.size), dydt.to_slice(sys.size))
      return 0
    end

    @raw : LibGSL::Gsl_odeiv2_system

    # Returns raw pointer to GSL system struct.
    def to_unsafe
      pointerof(@raw)
    end

    # Abstract method: compute derivatives dy/dt = f(t, y).
    abstract def function(t : LibC::Double, y : Slice(LibC::Double), dydt : Slice(LibC::Double))

    # Returns dimension of the system.
    def size
      @raw.dimension
    end

    # Initializes system with given state size.
    def initialize(size : Int32)
      @raw = uninitialized LibGSL::Gsl_odeiv2_system
      @raw.dimension = size
      @raw.params = self.as(Void*)
      @raw.function = @@same_function
    end
  end

  # Abstract class for ODE systems with Jacobian support.
  abstract class JacobianSystem < System
    # Shared C callback for Jacobian; calls `jacobian` on the Crystal object.
    @@same_jacobian : (LibC::Double, LibC::Double*, LibC::Double*, LibC::Double*, Void* -> LibC::Int) = ->(t : LibC::Double, y : LibC::Double*, dfdy : LibC::Double*, dfdt : LibC::Double*, data : Void*) do
      sys = data.as(JacobianSystem)
      sys.jacobian(t, y.to_slice(sys.size), dfdy.to_slice(sys.size*sys.size), dfdt.to_slice(sys.size))
      return 0
    end

    # Abstract method: compute Jacobian ∂f/∂y and ∂f/∂t.
    abstract def jacobian(t : LibC::Double, y : Slice(LibC::Double), dfdy : Slice(LibC::Double), dfdt : Slice(LibC::Double))

    # Initializes system and sets Jacobian callback.
    def initialize(size)
      super(size)
      @raw.jacobian = @@same_jacobian
    end
  end

  # ODE integration algorithms supported by GSL.
  enum Algorithm
    # Explicit 2nd-order Runge-Kutta
    RK2
    # Explicit 4th-order Runge-Kutta
    RK4
    # Runge-Kutta-Fehlberg (4/5)
    RKF45
    # Runge-Kutta-Cash-Karp (4/5)
    RKCK
    # Runge-Kutta Prince-Dormand (8/9)
    RK8PD
    # Implicit Euler (1st order)
    RK1IMP
    # Implicit midpoint (2nd order)
    RK2IMP
    # Gauss-Legendre (4th order)
    RK4IMP
    # Implicit Bulirsch-Stoer
    BSIMP
    # Adams-Moulton predictor-corrector
    MSADAMS
    # Backward Differentiation Formula
    MSBDF

    # Returns true if algorithm requires a Jacobian.
    def require_jacobian?
      rk1_imp? || rk2_imp? || rk4_imp? || bsimp? || msbdf?
    end

    # Converts enum value to GSL solve pointer.
    def to_unsafe
      case self
      in .rk2?
        LibGSL.gsl_odeiv2_step_rk2
      in .rk4?
        LibGSL.gsl_odeiv2_step_rk4
      in .rkf45?
        LibGSL.gsl_odeiv2_step_rkf45
      in .rkck?
        LibGSL.gsl_odeiv2_step_rkck
      in .rk8_pd?
        LibGSL.gsl_odeiv2_step_rk8pd
      in .rk1_imp?
        LibGSL.gsl_odeiv2_step_rk1imp
      in .rk2_imp?
        LibGSL.gsl_odeiv2_step_rk2imp
      in .rk4_imp?
        LibGSL.gsl_odeiv2_step_rk4imp
      in .bsimp?
        LibGSL.gsl_odeiv2_step_bsimp
      in .msadams?
        LibGSL.gsl_odeiv2_step_msadams
      in .msbdf?
        LibGSL.gsl_odeiv2_step_msbdf
      end
    end
  end

  # High-level ODE solver driver with adaptive step control.
  class Driver < GSL::Object
    @pointer : Pointer(LibGSL::Gsl_odeiv2_driver)
    getter system : System

    # Frees underlying GSL driver struct.
    def lib_free
      LibGSL.gsl_odeiv2_driver_free(@pointer)
    end

    delegate hmin, hmax, nmax, to: @pointer.value

    # Sets minimum step size.
    def hmin=(value)
      LibGSL.gsl_odeiv2_driver_set_hmin(@pointer, value)
    end

    # Sets maximum step size.
    def hmax=(value)
      LibGSL.gsl_odeiv2_driver_set_hmax(@pointer, value)
    end

    # Sets maximum number of steps.
    def nmax=(value)
      LibGSL.gsl_odeiv2_driver_set_nmax(@pointer, value)
    end

    # Resets driver with new initial step size.
    def reset(initial_step)
      LibGSL.gsl_odeiv2_driver_reset_hstart(@pointer, initial_step)
    end

    # Resets driver state (sets step to default initial_step).
    def reset
      LibGSL.gsl_odeiv2_driver_reset(@pointer)
    end

    # Initial step size used in integration.
    property initial_step : Float64

    # Initializes driver with `system`, `initial_step`, tolerances (`epsabs` and `epsrel`), algorithm, and scaling.
    def initialize(@system, @initial_step, epsabs : Float64 = 0.0, epsrel : Float64 = 0.0, algorithm : Algorithm? = nil, a_y : Float64 = 0.0, a_dydt : Float64 = 1.0, scale_abs : Array(Float64)? = nil)
      unless algorithm
        algorithm = @system.is_a?(JacobianSystem) ? Algorithm::MSBDF : Algorithm::MSADAMS
      end
      raise ArgumentError.new("Algorithm #{algorithm} requires JacobianSystem") if algorithm.require_jacobian? && !@system.is_a?(JacobianSystem)
      if scale_abs
        raise ArgumentError.new("Scales size should match dimension of system") if scale_abs.size != @system.size
        @pointer = LibGSL.gsl_odeiv2_driver_alloc_scaled_new(
          @system.to_unsafe,
          algorithm.to_unsafe,
          initial_step,
          epsabs, epsrel,
          a_y, a_dydt,
          scale_abs.to_unsafe)
      else
        @pointer = LibGSL.gsl_odeiv2_driver_alloc_standard_new(
          @system.to_unsafe,
          algorithm.to_unsafe,
          initial_step,
          epsabs, epsrel,
          a_y, a_dydt)
      end
      @state = Slice(Float64).new(@system.size)
    end

    # Integrates ODE from t0 to t1 using adaptive step.
    def apply(t0 : Float64, t1 : Float64, y : Array(Float64) | Slice(Float64))
      raise ArgumentError.new("State size should match dimension of system") unless y.size == @system.size
      y = y.to_unsafe.to_slice(y.size) unless y.is_a? Slice
      LibGSL.gsl_odeiv2_driver_apply(@pointer, pointerof(t0), t1, y)
    end

    # Evolves system over given time points; yields state and time at each point.
    def evolve(y_initial, time_points, &)
      raise ArgumentError.new("State size should match dimension of system") unless y_initial.size == @system.size
      @system.size.times do |i|
        @state[i] = y_initial[i]
      end
      t0 = time_points[0].to_f
      reset
      (1...time_points.size).each do |i|
        t1 = time_points[i].to_f
        apply(t0, t1, @state)
        yield(@state, t1)
        t0 = t1
      end
    end

    # Evolves system from t0 to t1 in fixed steps of dt; yields state and time.
    def evolve(y_initial, t0 : Float64, t1 : Float64, dt : Float64, &)
      raise ArgumentError.new("State size should match dimension of system") unless y_initial.size == @system.size
      raise ArgumentError.new("dt should be > 0") if dt <= 0
      @system.size.times do |i|
        @state[i] = y_initial[i]
      end
      t = t0
      reset
      while t < t1
        t_next = {t + dt, t1}.min
        apply(t, t_next, @state)
        yield(@state, t_next)
        t = t_next
      end
    end

    # Evolves system using natural (adaptive) steps; yields state and time.
    def evolve(y_initial, t0 : Float64, t1 : Float64, &)
      raise ArgumentError.new("State size should match dimension of system") unless y_initial.size == @system.size
      @system.size.times do |i|
        @state[i] = y_initial[i]
      end
      t = t0
      reset(@initial_step)
      h = @initial_step
      while t < t1
        LibGSL.gsl_odeiv2_evolve_apply(@pointer.value.e, @pointer.value.c, @pointer.value.s, @pointer.value.sys, pointerof(t), t1, pointerof(h), @state)
        raise "ODE doesn't converge" if h < hmin
        yield(@state, t)
      end
    end

    # Returns array of states at each time point.
    def evolve(y_initial, time_points)
      results = Array(Slice(Float64)).new(time_points.size)
      @system.size.times do |i|
        @state[i] = y_initial[i]
      end
      results << @state.clone
      evolve(y_initial, time_points) do |y, t|
        results << y.clone
      end
      results
    end

    #  Returns tuple of {states, times} evolved from t0 to t1 with adaptive steps.
    def evolve(y_initial, t0, t1)
      states = Array(Slice(Float64)).new
      times = Array(Float64).new
      @system.size.times do |i|
        @state[i] = y_initial[i]
      end
      states << @state.clone
      times << t0
      evolve(y_initial, t0, t1) do |y, t|
        states << y.clone
        times << t
      end
      {states, times}
    end

    # Returns tuple of {states, times} evolved with fixed step size.
    def evolve(y_initial, t0, t1, step)
      states = Array(Slice(Float64)).new((t1 - t0)/step)
      times = Array(Slice(Float64)).new((t1 - t0)/step)
      @system.size.times do |i|
        @state[i] = y_initial[i]
      end
      states << @state.clone
      times << t0
      evolve(y_initial, t0, t1, step) do |y, t|
        states << y.clone
        times << t
      end
      {states, times}
    end
  end
end
