blockBeamHw16Param

% Reference signals
period = 30;
z_ref_signal = blockBeamSignalGenerator(Param.ell/4, 1/period,  Param.z_e);

% Instantiate objects
dynamics    = blockBeamDynamics(Param);
measurments = dynamics.sensors();
observer    = blockBeamObserverLuenberger(Param, measurments);
controller  = blockBeamControllerMPC(Param);
animation   = blockBeamAnimation(Param);
plotter     = blockBeamDataPlotter(Param);

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
F = Param.F_e;
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
        % Reference Signal
        z_r = z_ref_signal.square(t);

        % Observer
        states_hat = observer.update(F, measurments);
    
        % Inputs
        F = controller.update(states_hat, z_r);
    
        % Dynamics
        measurments = dynamics.update(F);

        % Time step
        t = t + Param.Ts;
    end
    
    % Combine the states into a single vector
    states     = dynamics.states;
    estimate   = states_hat;
    references = [z_r; NaN(3,1)];
    model      = NaN(size(states));
    input      = F;

    % Update animation and plots
    animation.update(states);
    plotter.update(t, states, estimate, references, model, input)

    % Update time
    t_next_plot = t + Param.t_plot;
end
simulation_length = toc(timer);
fprintf("Simulation took: %f seconds.\n",simulation_length);

