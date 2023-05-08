% Neel Tangella, tangella@usc.edu
clear; clc; close all; 

numdiffeqn = 21; 

initvalue = zeros(numdiffeqn, 1); 

initvalue(1, 1) = 9e-13; 
initvalue(5, 1) = 1e-13; 
initvalue(8, 1) = 1e-12; 
initvalue(11, 1) = 1e-13; 
initvalue(13, 1) = 0.31; 
initvalue(14, 1) = 99.4; 
initvalue(15, 1) = 0.29; 
initvalue(16, 1) = 100; 
initvalue(18, 1) = 100; 
initvalue(20, 1) = 96; 
initvalue(21, 1) = 4; 

tstep = 0.001; 
stopTime = 500; 
tspan = 0:tstep:stopTime; 
options = odeset('RelTol',1e-13);

% % figure('Renderer', 'painters', 'Position', [10 10 900 600])
% subplot(2,1, 1)
% init_conc = [1, 2, 6, 7, 10];
% hold on
% for i = 1:5
%     initvalue(1, 1) = 0.1 * init_conc(i) * 9e-13; 
%     [tsim, results] = ode15s(@Feedback_Model_UPDATED, tspan, initvalue, options);
%     plot(tsim, results(:, 9), 'LineWidth', 2); 
% end
% % ylim([0 25]); 
% % xlim([250 450]);
% xlim([0 2500])
% legend('10%', '20%', '60%', '70%', '100%', 'Location', 'southeast');
% ylabel('p-IRS1 [tyr phosphorylated] (M)')
% xlabel('time [min]')
% hold off
% 
% subplot(2, 1, 2)
% hold on
% for i = 1:5
%     initvalue(1, 1) = 0.1 * init_conc(i) * 9e-13; 
%     [tsim, results] = ode15s(@Feedback_Model_UPDATED, tspan, initvalue, options);
%     plot(tsim, results(:, 10), 'LineWidth', 2); 
% end
% % ylim([0 25]); 
% % xlim([250 450]);
% xlim([0 2500])
% legend('10%', '20%', '60%', '70%', '100%', 'Location', 'northeast');
% ylabel('p-IRS1 [ser phosphorylated] (M)')
% xlabel('time [min]')
% hold off

% varying_conc = 0.1:0.05:1; 
% knockdown_ratio = []; 
% ss_conc = []; 
% for i = 1:size(varying_conc, 2)
%     initvalue(1, 1) = varying_conc(i) * 9e-13; 
%     [tsim, results] = ode15s(@Feedback_Model_UPDATED, tspan, initvalue, options);
%     knockdown_ratio = [knockdown_ratio, varying_conc(i)];
%     ss_conc = [ss_conc, results(end, 9)];
% end
% 
% subplot(2, 1, 1)
% plot(knockdown_ratio, ss_conc, 'LineWidth', 2)
% % xlim([0 1]);
% xlabel('knockdown ratio')
% % ylabel('% p-AKT S.S')
% ylabel('S.S. p-IRS1 [tyr phosphorylated] (M)')
% 
% 
% knockdown_ratio = []; 
% ss_conc = []; 
% for i = 1:size(varying_conc, 2)
%     initvalue(1, 1) = varying_conc(i) * 9e-13; 
%     [tsim, results] = ode15s(@Feedback_Model_UPDATED, tspan, initvalue, options);
%     knockdown_ratio = [knockdown_ratio, varying_conc(i)];
%     ss_conc = [ss_conc, results(end, 10)];
% end
% 
% subplot(2, 1, 2)
% plot(knockdown_ratio, ss_conc, 'LineWidth', 2)
% % xlim([0 1]);
% xlabel('knockdown ratio')
% % ylabel('% p-AKT S.S')
% ylabel('S.S. p-IRS1 [ser phosphorylated] (M)')

[tsim, results] = ode45(@Feedback_Model, tspan, initvalue, options); 
plot(tsim, results, 'LineWidth', 2); 
% xticks([300 1740 3180]);
% xticklabels({'Day 1', 'Day 2', 'Day 3'})
% xlabel('Time [min]')
% ylabel('% PIP3')
xlim([0 stopTime])
ylim([0 max(max(results))])





