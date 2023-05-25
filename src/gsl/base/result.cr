module GSL
  # Represents result of optimization algorithm
  enum Result
    # Solution found
    Success
    # Iterations limit exceeded
    IterationLimit
    # Algorithm do not converge
    NoConvergence
  end
end
