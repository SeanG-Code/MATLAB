blockBeamHw23Param

% Instantiate objects
dynamics                 = blockBeamDynamics(Param);
innerLoopController      = blockBeamControllerInnerLoopNDI(Param, dynamics.states);
[outerLoopController, ~] = blockBeamControllerQRL(Param);
animation                = blockBeamAnimation(Param);
plotter                  = blockBeamDataPlotter(Param);

% Stop learning and random exploration
outerLoopController.deterministic();

% Activate the desired figure
list_of_figures =  findobj('type','figure');
number_of_figures = length(list_of_figures);
if Param.active_figure <= number_of_figures
    figure(Param.active_figure);
end

% Main simulation loop
t = Param.t_start;
timer = tic;
t_next_plot = 0;
u_tilde = 0;
counter = 0;
theta_r = Param.theta_0;
next_outer_loop_update = Param.t_start;
while t < Param.t_end

    drawn_recently = false;
    while toc(timer) < t/Param.speed
        % Do nothing while we wait for the time to plot
        if ~drawn_recently
            drawnow
            drawn_recently = true;
        end
    end

    while t <= t_next_plot
        z_r = 3/4*Param.ell;
    
        % Inputs
        if t >= next_outer_loop_update
            [theta_r, episode_reset] = outerLoopController.update(dynamics.states, z_r, t);
            next_outer_loop_update = next_outer_loop_update + Param.outer_loop_update_period;
        end
        % [theta_r, ~] = outerLoopController.update(dynamics.states, z_r, t);
        [F, states_m] = innerLoopController.update(dynamics.states, theta_r);
    
        % Dynamics
        dynamics.update(F);

        t = t + Param.Ts;
    end

    % Combine the states into a single vector
    states     = dynamics.states;
    estimate   = NaN(size(states));
    references = [z_r; theta_r; NaN(2,1)];
    model      = states_m;
    input      = F;

    % Update animation and plots
    animation.update(states);
    plotter.update(t, states, estimate, references, model, input)

    % Update time
    t_next_plot = t + Param.t_plot;
end
simulation_length = toc(timer);
fprintf("Simulation took: %f seconds.\n",simulation_length);

