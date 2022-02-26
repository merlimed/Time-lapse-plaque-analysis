
clc
clear

%%
start_point = 1;
fin_point = 179;
figure('Position', [100 300 1200 500])
subplot(1,2,1)
load 'Data/delta_areas.mat'
plot(start_point:fin_point, sqrt(mean(areas, 2)/pi), 'LineWidth', 2)
hold on 
load 'Data/WT_areas.mat'
plot(start_point:fin_point, sqrt(mean(areas, 2)/pi), 'LineWidth', 2)
set(gca, 'FontSize', 16)
ylabel('Mean plaque radius (pixels)')
xlim([1 179])
ylim([0 26])
xlabel('Time (hours)')
xticklabels({'1', '3', '5','7','9','11','13','15'})
xticks([7 31 55 79 103 127 151 175])
plot(polyshape([0 0 55 55],[55 0 0 55]),'FaceColor', [0.4940, 0.1840, 0.5560])
legend('Delta', 'WT','unfeasible')

subplot(1,2,2)
load 'Data/delta_areas.mat'
plot(start_point:fin_point, sqrt(areas/pi), ...
    'LineWidth', 1, 'Color', [0, 0.4470, 0.7410, .25])
hold on 
load 'Data/WT_areas.mat'
plot(start_point:fin_point, sqrt(areas/pi), ...
    'LineWidth', 1, 'Color', [0.85, 0.325, 0.098, .25])
set(gca, 'FontSize', 16)
%ylabel('Mean plaque radius (pixels)')
xlim([1 179])
ylim([0 26])
xticklabels({'1', '3', '5','7','9','11','13','15'})
xticks([7 31 55 79 103 127 151 175])
xlabel('Time (hours)')
plot(polyshape([0 0 55 55],[55 0 0 55]), 'FaceColor', [0.4940, 0.1840, 0.5560])
