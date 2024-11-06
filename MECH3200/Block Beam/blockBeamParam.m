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
Param.box_size  = 0.1;  % m
Param.arm_width = 0.01; % m

Param.hlim = [-0.25,0.75];    % m
Param.vlim = [-0.5,0.5];    % m

Param.line_width = 1.5;

%% System Parameters
Param.m_1 = 0.35; % kg
Param.m_2 = 2.00; % kg
Param.ell = 0.50; % m
Param.g   = 9.81; % m/s^2

% Unpack for shorter equations when defining transfer function and state
% space matrices
m_1 = Param.m_1;
m_2 = Param.m_2;
ell = Param.ell;
g   = Param.g;

%% Saturation Limits
Param.F_max =  15; % Nm
Param.F_min = -15; % Nm

%% Equilibrium

% HW5 SECTION START ------------------------------------------
% Enter the equilibrium for each state variable. This does not need to be
% submitted, but must be completed correctly for future assignments.
Param.z_e         = 0.25;
Param.theta_e     = 0;
Param.z_dot_e     = 0;
Param.theta_dot_e = 0;
Param.F_e         = (m_1*g*Param.z_e)/ell + (m_2*g)/2;
% HW5 SECTION END --------------------------------------------

%% Transfer Function

% HW6 SECTION START ------------------------------------------
% Enter the transfer function from F to theta and from theta to z. Use
% matlab's tf function. This section does not need to be submitted, but
% must be completed correctly for future assignemnts. Assume that the
% affect of torque on the beam caused by gravity on the box (specifically
% its deviation from equilibrium) is small compared to the force required
% to hold up the beam. This means you can assume m_1*g*z_tilde = 0 in the
% linearized differential equation for theta.
Param.tf_F2theta = NaN;
Param.tf_theta2z = NaN;
% HW6 SECTION END --------------------------------------------


%% State Space Matricies

% HW6 SECTION START ------------------------------------------
% Enter the state space matricies. Subscript r refers to the output
% associated with the reference signal. Subscript m refers to the output
% associated with the measurments which is to be feed back to the observer.
% This section does not need to be submitted, but must be completed
% correctly for future assignments.
Param.A   = NaN;
Param.B   = NaN;
Param.C_r = NaN;
Param.C_m = NaN;
Param.D_r = NaN;
Param.D_m = NaN;
% HW6 SECTION END --------------------------------------------
