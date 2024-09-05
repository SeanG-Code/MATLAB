%% Simulation
clear
close all
clc

% Reset Random Number Generator for repeatablity
rng(1);

%% Time
Param.t_start = 0;
Param.Ts      = 0.01;
Param.t_plot  = 0.1;

%% Animation
Param.pole_width = 0.02; % m
Param.cart_size  = 0.15; % m

Param.hlim = [-1.2,1.2];    % m
Param.vlim = [-1.2,1.2];    % m

Param.line_width = 1.5;

%% System Parameters
Param.m_1 = 0.25; % kg
Param.m_2 = 1.0;  % kg
Param.ell = 1.0;  % m
Param.g   = 9.81; % m/s
Param.b   = 0.05; % Nms

% Unpack for shorter equations when defining transfer function and state
% space matrices
m_1 = Param.m_1; % kg
m_2 = Param.m_2; % kg
ell = Param.ell; % m
g   = Param.g  ; % m/s
b   = Param.b  ; % Nms

%% Saturation Limits
Param.F_max =  5; % Nm
Param.F_min = -5; % Nm

%% Equilibrium

% HW5 SECTION START ------------------------------------------
% Enter the equilibrium for each state variable. This does not need to be
% submitted, but must be completed correctly for future assignments.
Param.z_e         = NaN;
Param.theta_e     = NaN;
Param.z_dot_e     = NaN;
Param.theta_dot_e = NaN;
Param.F_e         = NaN;
% HW5 SECTION END --------------------------------------------

%% Transfer Function

% HW6 SECTION START ------------------------------------------
% Enter the transfer function from F to theta and from theta to z. Use
% matlab's tf function. This section does not need to be submitted, but
% must be complted correctly for future assignemnts.
Param.tf_F2theta = NaN;
Param.tf_theta2z = NaN;
% HW6 SECTION END --------------------------------------------


%% State Space Matricies

% HW6 SECTION START ------------------------------------------
% Enter the state space matricies. Subscript r refers to the output
% associated with the reference signal. Subscript m refers to the output
% associated with the measurments which is to be feed back to the observer.
% This section does not need to be submitted, but must be completed
% correctly for future assignemtns.
Param.A   = NaN;
Param.B   = NaN;
Param.C_r = NaN;
Param.C_m = NaN;
Param.D_r = NaN;
Param.D_m = NaN;
% HW6 SECTION END --------------------------------------------
