clc
clear
%%
stats = readmatrix('Data/cropped_centers_WT_nov19.csv');
stats_len = length(stats);
start_point = 1;
fin_point = 179;
len_days = length(start_point:fin_point);
areas = zeros(len_days, stats_len);
load 'Data/edges_nov19.mat'
%%
og_center = edges(:, :,fin_point - start_point + 1);
%%
%start_point = 100;
%fin_point = 179;
%test = 179;
for n_i = start_point:fin_point
    if n_i < 10
        mystring = strcat('cropped/WT_DSM_SPO1_00',num2str(n_i),'.jpg');
    elseif n_i < 100
        mystring = strcat('cropped/WT_DSM_SPO1_0',num2str(n_i),'.jpg');
    else
        mystring = strcat('cropped/WT_DSM_SPO1_',num2str(n_i),'.jpg');
    end
    A = imread(mystring);
    se = strel('disk',25);
    Aprime = imgaussfilt(A,1); % reduce noise
    Aprime = imopen(Aprime, se);
    A_adj = imadjust(A-Aprime);
    A_adj = imgaussfilt(A_adj,1); % reduce noise    

    drift_y = edges(1,:, n_i - start_point+1) - og_center(1, :);
    drift_x = edges(2,:, n_i - start_point+1) - og_center(2, :);
    drift_x = floor(mean(drift_x));
    drift_y = floor(mean(drift_y));
    for i=1:stats_len
        l = stats(i, 2);
        L = stats(i, 1); % x dim
        c_x = stats(i, 3) + drift_x;  %xdim
        c_y = stats(i, 4) + drift_y; %ydim
        rect = [(c_x-L/2), (c_y-l/2), L, l];
        temp_crop = imcrop(A_adj, rect);
        pl_area = analyze_single_pl(temp_crop);
        areas(n_i-start_point+1, i) = sum(sum(pl_area));
        %figure()
        %imshow(temp_crop)
    end
end
%%
t_ind = start_point:10:fin_point;
err = std(areas(t_ind-start_point+1, :), 0, 2);
save('Data/WT_areas.mat', 'areas')
%%
figure('Position', [100 300 1200 500])
subplot(1,2,1)
plot(start_point:fin_point, mean(areas, 2), 'LineWidth', 2)
hold on
errorbar(t_ind, mean(areas(t_ind-start_point+1,:), 2), err, 'LineWidth', 1.2)
set(gca, 'FontSize', 16)
ylabel('Mean plaque size')

subplot(1,2,2)
plot(start_point:fin_point, areas(:,:), 'LineWidth', 1)
set(gca, 'FontSize', 16)
ylabel('Mean plaque size')
xlabel('Time')