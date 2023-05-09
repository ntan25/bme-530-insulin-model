
%   Note we set and update all parameter values
%   in the function, as such we have different functions
%   they all contain the same code but for different parameter
%   perturbations we define different functions
%   Running the driver files in alphabetical order will yield 
%   the figures in generally the same order they appear in the paper
%   For time sake we use ODE15s, ODE45 will work but takes 
%   significantly longer

time = 0:0.01:1740
x1 = 6.95e-11 + 0.4*6.95e-11*abs(sin(2*pi*0.5*0.0021*time));

figure(9)
plot(time,x1,'k','LineWidth',2)
xlim([320 1740])
xlabel('Time (mins)')
ylabel('Insulin Oscillations (M)')
xticks([400 600 800 1000 1200 1400 1600]);
xticklabels({'100', '300', '500', '700', '900', '1100', '1400'})
title('Natural Insulin Oscillations')

