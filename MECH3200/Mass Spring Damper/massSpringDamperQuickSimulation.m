clear
close all
clc

% System Paramters
Param.m   = 5;    % kg
Param.k   = 3;    % m
Param.b   = 0.5;  % Ns/m

% Intial State
Param.z_0     = 0; % m
Param.z_dot_0 = 0; % m/s

% Time settings
Param.Ts = 0.01;
Param.t_end = 30;

% Initilize Dynamics
dynamics = massSpringDamperQuickDynamics(Param);

% Initilize History Variables
time_history = (0:Param.Ts:Param.t_end);
state_history = NaN(2, size(time_history,2));

% Simulation
for i = 1:length(time_history)
    % Input
    F = 1;

    % Step Dynamics forward in time
    state_history(:,i) = dynamics.update(F);
end

% Plot Response
figure(1)

subplot(2,1,1)
plot(time_history, state_history(1,:));
ylabel("z (m)")

subplot(2,1,2)
plot(time_history, state_history(2,:));
ylabel("z dot (m/s)")

xlabel("t - time (s)")

