# This module implements [Simulated Annealing](https://www.gnu.org/software/gsl/doc/html/siman.html)
#
# Note: this module doesn't use GSL function (`gsl_siman_solve`), instead entire algorithm was rewritten in Crystal (it is quite simple)
module GSL::Siman
  # Abstract struct, represents state in a search space for simulated Annealing
  #
  # User should inherit from this struct to use simulated annealing
  #
  # User should define `clone` if copying it is not trivial
  abstract struct Configuration
    # This function should return the energy of a configuration:
    abstract def energy : Float64
    # This function should modify the configuration using a random step taken from the generator `rng`, up to a maximum distance of `step_size`:
    abstract def step(rng : Random, step_size : Float64) : self
    # This function should return the distance between configurations `self` and `other`:
    abstract def distance(other : self) : Float64

    # def clone : Self
    # def to_s(io)
  end

  # Parameters of simulated annealing algorithm
  struct Params
    # how many points do we try before stepping
    getter n_tries : Int32
    # how many iterations for each T?
    getter iters_fixed_t : Int32
    # max step size in random walk
    getter step_size : Float64
    # Boltzmann constant
    getter k : Float64
    # initial temperature
    getter t_initial : Float64
    # damping factor for temperature
    getter mu_t : Float64
    # stopping criteria - minimal temperature
    getter t_min : Float64

    def initialize(@n_tries, @iters_fixed_t, @step_size, @k, @t_initial, @mu_t, @t_min)
    end
  end

  private GSL_LOG_DBL_MIN = -7.0839641853226408e+02

  private def self.boltzmann(e, new_e, t, params)
    x = -(new_e - e) / (params.k * t)
    #  avoid underflow errors for large uphill steps
    return (x < GSL_LOG_DBL_MIN) ? 0.0 : Math.exp(x)
  end

  # Perform simulated annealing algorithm and returns found configuration with minimal energy
  #
  # Parameters have following meaning:
  #
  # - `initial` defines starting position for search
  # - `params` defines algorithm parameters (see `GSL::Siman::Params`)
  # - if `print_status` is true, current state will be printed to `STDOUT` during search
  # - `random` sets random generator
  def self.solve(initial : Configuration, params : Params, print_status = false, random : Random = Random::DEFAULT) : Configuration
    n_evals = 1
    n_iter = 0
    e = initial.energy
    x = initial
    new_x = initial
    best_x = initial
    best_e = e
    t = params.t_initial
    t_factor = 1.0 / params.mu_t
    while true
      params.iters_fixed_t.times do |i|
        new_x = x.step(random, params.step_size)
        new_e = new_x.energy
        if new_e < best_e
          best_x = new_x
          best_e = new_e
        end
        n_evals += 1
        #  now take the crucial step: see if the new point is accepted
        #  or not, as determined by the boltzmann probability
        if (new_e < e) || random.rand < boltzmann(e, new_e, t, params)
          x = new_x
          e = new_e
        end
        Fiber.yield
        if print_status
          puts x, e
        end
      end
      t *= t_factor
      n_iter += 1
      break if t < params.t_min
    end
    best_x
  end
end
