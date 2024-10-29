clc, clear all;

z_0 = 50; % Ohms 25 ft line
z_1 = 100; % Ohms Quarter Wave
z_L = 200; % Ohms Load
length = 7.62; % meters Length of TL
v = 2.08*10^8; % Velocity of TL
i = 1;
for f = 0.1*10^6:0.1*10^4:40*10^6
    beta = (2*pi*f)/v;
    z_a = 100*((200+1i*100*tan(beta*length))/(100+1i*200*tan(beta*length)));
    gamma(i) = (z_a-z_0)/(z_a+z_0);
    gamma_db(i) = 20 * log10(gamma(i));
    i = 1 + i;
end

f = 0.1*10^6:0.1*10^4:40*10^6;

%%
plot(f / 1e6, gamma_db);
xlabel('Frequency (MHz)');
ylabel('Reflection Coefficient (dB)');
title('Reflection Coeffiecient vs. Frequency');
grid on;