function [optimum] = particle_swarm(func)
    
    % bounds for alpha0 and speed0
    alpha_bounds = [-pi, pi];
    speed_bounds = [0, 5];
    bounds = [alpha_bounds; speed_bounds];
    
    % define particle struct
    particle = struct();
    particle.position = [0; 0];
    particle.speed = [0; 0]; 
    particle.best = particle.position;
    particle.best_err = inf;

    % define simulation params
    particle_amount = 10;
    max_iterations = 50;
    % METAHEURISTICS FROM DESIGN TO IMPLEMENTATION - El-Ghazali Talbi
    % suggested min=0.4, but 0.1 worked best for me.
    min_omega = 0.1;
    
    % PSO parameters
    omega = 0.9;
    phi = 1.5;
    psi = 1.5;
    
    % speed bounds
    particle_speed_bounds = [-1, 1; -1, 1];

    % hold all particles
    particle_cell = cell(particle_amount,1);
    for i = 1:particle_amount
        p_temp = particle;
        p_temp.position = [
                rand() * (bounds(1,2) - bounds(1,1)) + bounds(1,1);
                rand() * (bounds(2,2) - bounds(2,1)) + bounds(2,1)
            ];
        p_temp.speed = [
                rand() * (particle_speed_bounds(1,2) - particle_speed_bounds(1,1)) + particle_speed_bounds(1,1);
                rand() * (particle_speed_bounds(2,2) - particle_speed_bounds(2,1)) + particle_speed_bounds(2,1)
            ];
            
        % initial error
        dist = func(p_temp.position(1), p_temp.position(2));
        p_temp.best_err = dist + p_temp.position(2)/10;
        p_temp.best = p_temp.position;
        
        particle_cell{i} = p_temp;
    end

    % init global best
    g_best = particle_cell{1}.best;
    g_best_err = particle_cell{1}.best_err;
    
    % finde global best
    for i = 2:particle_amount
        if particle_cell{i}.best_err < g_best_err
            g_best = particle_cell{i}.best;
            g_best_err = particle_cell{i}.best_err;
        end
    end
    
    % main loop
    for iter = 1:max_iterations
        % update each particle
        for i = 1:particle_amount
            particle_cell{i} = update(particle_cell{i}, func, omega, phi, psi, g_best);
            
            % check for new global best
            if particle_cell{i}.best_err < g_best_err
                g_best = particle_cell{i}.best;
                g_best_err = particle_cell{i}.best_err;
            end
        end
        
        % reduce inertia weight over time till under min
        if omega > min_omega
            omega = omega * 0.99;
        else
            break;
        end
    end
    
    % best solution
    optimum = g_best;
    
end

function prtc = update(prtc, func, omega, c1, c2, g_best)
    % params for update velocity
    r1 = rand();
    r2 = rand();
    
    % velocity update lt. Skript
    prtc.speed = omega * prtc.speed + ...
                 c1 * r1 * (prtc.best - prtc.position) + ...
                 c2 * r2 * (g_best - prtc.position);
    
    % update position
    prtc.position = prtc.position + prtc.speed;
    
    % calc new distance
    dist = func(prtc.position(1), prtc.position(2));
    
    % err lt. Angabe
    new_err = dist + prtc.position(2)/10;
    
    % wenn err smaller dann neues bestes
    if new_err < prtc.best_err
        prtc.best = prtc.position; 
        prtc.best_err = new_err;
    end
end