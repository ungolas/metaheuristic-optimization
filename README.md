# Metaheuristic Optimization

This project contains MATLAB implementations of two metaheuristic optimization algorithms:

- **Simulated Annealing**  
  Implemented in [`simulated_annealing`](metaheuristic-optimization/simulated_annealing.m). This algorithm randomly searches for an optimum solution while gradually reducing the "temperature" parameter.

- **Particle Swarm Optimization (PSO)**  
  Implemented in [`particle_swarm`](metaheuristic-optimization/particle_swarm.m). This algorithm simulates a swarm of particles moving within the search space to find the optimal solution.

## Files

- **simulated_annealing.m**  
  Contains the implementation of the simulated annealing algorithm.

- **particle_swarm.m**  
  Contains the implementation of the particle swarm optimization algorithm along with an `update` helper function.

- **try_out.m**  
  A test script that defines a sample objective function `fun` and runs both optimization algorithms.

- **README.md**  
  This file.

## How to Run

1. Open MATLAB and navigate to the `metaheuristic-optimization` directory.
2. Run the test script by typing:
   ```matlab
   try_out