% tryout script

% test function
function cost = fun(alpha, speed)
    cost = sin(3 * alpha) + cos(5 * speed) + (alpha - 1)^2 + (speed - 2)^2;
end

% Run the simulated annealing algorithm
optimum_sa = simulated_annealing(@fun);
optimum_pso = particle_swarm(@fun);
