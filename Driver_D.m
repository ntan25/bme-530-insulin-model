%   Note we set and update all parameter values
%   in the function, as such we have different functions
%   they all contain the same code but for different parameter
%   perturbations we define different functions
%   Running the driver files in alphabetical order will yield 
%   the figures in generally the same order they appear in the paper
%   For time sake we use ODE15s, ODE45 will work but takes 
%   significantly longer


% Time vector (in minutes)
time = 0:1440;

baselineLevel = 0;             % Baseline insulin level
initialAmplitude = 10*6.95e-13;            % Initial amplitude of the square function
squareDuration = 300;             % Duration of the square function (in minutes)
squarePeriod = 300;              % Period of the square function (in minutes)
decreaseFactors = [8/10,6.5/8,5.5/6.5,5/5.5];  % Decrease factors for amplitude

% Calculate insulin levels at each time point
insulinLevels = baselineLevel * ones(size(time));
squareAmplitude = initialAmplitude;  % Initialize amplitude

for i = 1:numel(time)
    if mod(time(i), squarePeriod) < squareDuration
        insulinLevels(i) = baselineLevel + squareAmplitude;
    end
    
    % Decrease amplitude for consecutive pulses
    if mod(time(i), squarePeriod) == squarePeriod - 1
        decreaseIndex = mod(floor((time(i) + 1) / squarePeriod), numel(decreaseFactors)) + 1;
        squareAmplitude = squareAmplitude * decreaseFactors(decreaseIndex);
    end
end

% Plotting the graph
figure(7)
plot(time, insulinLevels, 'k-', 'LineWidth', 2);
xlabel('Time (minutes)');
ylabel('Insulin Stimulation (M)');
title('Treatment Plan 3');
xticks([0 500]);
xticklabels({'100', '300', '500', '700', '900', '1100', '1400'})