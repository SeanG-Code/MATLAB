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
Param.body_size      = 0.15; % m
Param.motor_diameter = 0.15; % m

Param.hlim = [-4,4];    % m
Param.vlim = [-1,7];    % m

Param.line_width = 1.5;

%% System Parameters
Param.m_c = 1;      % kg
Param.J_c = 0.0042; % kg m^2
Param.m_r = 0.25;   % kg
Param.m_l = 0.25;   % kg
Param.d   = 0.3;    % m
Param.mu  = 0.10;   % kg/s
Param.g   = 9.81;   % m/s^2

% Unpack for shorter equations when defining transfer function and state
% space matrices
m_c = Param.m_c;
J_c = Param.J_c;
m_r = Param.m_r;
m_l = Param.m_l;
d   = Param.d  ;
mu  = Param.mu ;
g   = Param.g  ;

%% Saturation Limits
Param.f_max = 10; % N
Param.f_min =  0; % N

%% Equilibrium

% HW5 SECTION START ------------------------------------------
% Enter the equilibrium for each state variable. This does not need to be
% submitted, but must be completed correctly for future assignments.
Param.h_e         = 0;
Param.z_e         = 0;
Param.theta_e     = 0;
Param.h_dot_e     = 0;
Param.z_dot_e     = 0;
Param.theta_dot_e = 0;
Param.F_e         = (m_c+2*m_r)*g;
Param.tau_e       = 0;
% HW5 SECTION END --------------------------------------------

%% Transfer Function

% HW6 SECTION START ------------------------------------------
% Enter the transfer function from tau to z and from z to theta. Use
% matlab's tf function. This section does not need to be submitted, but
% must be complted correctly for future assignemnts. Note that for the
% transfer function from tau to z you sould assume that 
% (J_s + J_p)/J_s is approximately 1.
Param.tf_F2h       = NaN;
Param.tf_tau2theta = NaN;
Param.tf_theta2z   = NaN;
% HW6 SECTION END --------------------------------------------


%% State Space Matricies

% HW6 SECTION START ------------------------------------------
% Enter the state space matricies. Subscript r refers to the output
% associated with the reference signal. Subscript m refers to the output
% associated with the measurments which is to be feed back to the observer.
% This section does not need to be submitted, but must be completed
% correctly for NaN;
Param.A       = NaN;
Param.B       = NaN;
Param.C_r     = NaN;
Param.C_m     = NaN;
Param.D_r     = NaN;
Param.D_m     = NaN;
Param.A_lat   = NaN;
Param.B_lat   = NaN;
Param.C_r_lat = NaN;
Param.C_m_lat = NaN;
Param.D_r_lat = NaN;
Param.D_m_lat = NaN;
Param.A_lon   = NaN;
Param.B_lon   = NaN;
Param.C_r_lon = NaN;
Param.C_m_lon = NaN;
Param.D_r_lon = NaN;
Param.D_m_lon = NaN;
% HW6 SECTION END --------------------------------------------
