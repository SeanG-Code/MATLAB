% Clears the workspace and closes all figures
clear; close all;
% Sets freq to 2*10^9
f = 2e9;
% Sets speed of light to 3*10^8
c= 3e8;
% wave length = speed of light / freq
lambda=c/f;
% Sets angular frequency to 2*pi*f
omega=2*pi*f;
% Sets attenuation constant
alpha=0;
% Sets the phase constant
beta=2*pi/lambda;
% Sets the propogation constant
gamma=alpha+j*beta;
% reflection coefficient value
ref=.5; 
% Sets the length of the line
l = 2*lambda;

% Stepping from 0 - 200 for x in steps of 1
for x=0:200
    % equation for time 
    t=x/(2*pi);
    % sets impedance to generates points (0-(-2))/(1000-1) in vector format
    z=linspace(-2,0,1000);
    % Sets voltage to 1
    Vo=1;
    % equation for forward voltage imaginary
    VforPhasor = Vo*exp(-gamma*(z));
    % equation for reverse voltage imaginary
    VrevPhasor = Vo*ref*exp(gamma*(z));
    % equation for forward voltage real
    Vfor = real(VforPhasor*exp(j*omega*t));
    % equation for reverse voltage real
    Vrev = real(VrevPhasor*exp(j*omega*t));
    % adds vfor and vrev
    Vtot = Vfor + Vrev;
    % sums vphasor
    Vphasor = VforPhasor + VrevPhasor;
    % equation for Vsw
    Vsw = (Vphasor.*conj(Vphasor)).^.5;
    % creates figure 1
    figure(1);
    % creates the plots of the data
    Vp=plot(z,Vfor,z,Vrev,z,Vtot,z,Vsw);
    % adds labels for the plots
    legend('Vfor','Vrev','Vtot','Vsw');
    % sets the plot bounds
    axis([-2 0 -3 3]);
    % draws the plot
    drawnow;
    % pauses for 1 second
    pause(1);
end

