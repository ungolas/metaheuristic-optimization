function [optimum] = simulated_annealing(func)
    
    % bounds for alpha0 and speed0
    alpha_bounds = [-pi, pi];
    speed_bounds = [0, 5];
    bounds = [alpha_bounds; speed_bounds];
    
    % params for simulated annealing
    init_temp = 50;
    cooling_rate = 0.99;
    max_iterations = 1000;
    min_temp = 1e-1; 
    
    % init randomly
    curr_solution = [
        rand() * (bounds(1,2) - bounds(1,1)) + bounds(1,1),
        rand() * (bounds(2,2) - bounds(2,1)) + bounds(2,1)
    ];
    
    % eval random lt. Angabe
    curr_err = func(curr_solution(1), curr_solution(2));
    
    % init best solution
    optimum = curr_solution;
    best_cost = curr_err;
    
    % init temperature
    temperature = init_temp;
    
    % simulated annealing loop
    iteration = 0;
    while temperature > min_temp && iteration < max_iterations

        % generate neighbour
        neighbor = [
            rand() * (bounds(1,2) - bounds(1,1)) + bounds(1,1);
            rand() * (bounds(2,2) - bounds(2,1)) + bounds(2,1)
        ];
        
        % error lt. Angabe
        err = func(neighbor(1), neighbor(2));
        err_diff = err - curr_err;
        
        % main logic to keep or not
        if err_diff < 0 || rand() < exp(-err_diff / temperature)
            curr_solution = neighbor;
            curr_err = err;
            
            % update best if better
            if curr_err < best_cost
                optimum = curr_solution;
                best_cost = curr_err;
            end
        end
        
        % cooling
        temperature = temperature * cooling_rate;
        iteration = iteration + 1;
    end

end