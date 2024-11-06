clear
close all
clc

% System Paramters
Param.m_1 = 0.35; % kg
Param.m_2 = 2.00; % kg
Param.ell = 0.50; % m
Param.g   = 9.81; % m/s^2

% Intial State
Param.z_0         = Param.ell/2; % m
Param.theta_0     = deg2rad(0);  % rad
Param.z_dot_0     = 0;           % m/s
Param.theta_dot_0 = 0;           % rad/s

% Time settings
Param.Ts = 0.01;
Param.t_end = 30;

% Initilize Dynamics
dynamics = blockBeamQuickDynamics(Param);

% Initilize History Variables
time_history = (0:Param.Ts:Param.t_end);
state_history = NaN(4, size(time_history,2));

% Simulation
for i = 1:length(time_history)
    % Input
    F = 11.51675;

    % Step Dynamics forward in time
    state_history(:,i) = dynamics.update(F);
end

% Plot Response
figure(1)

subplot(4,1,1)
plot(time_history, state_history(1,:));
ylabel("z (m)")

subplot(4,1,2)
plot(time_history, rad2deg(state_history(2,:)));
ylabel("theta (deg)")

subplot(4,1,3)
plot(time_history, state_history(3,:));
ylabel("z dot (m/s)")

subplot(4,1,4)
plot(time_history, rad2deg(state_history(4,:)));
ylabel("theta dot (deg/s)")

xlabel("t - time (s)")

