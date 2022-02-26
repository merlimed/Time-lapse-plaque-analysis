function y = find_corners(strings)
y = -8 * ones(2, length(strings));
count_s = 1;
for s = strings
    A = imread(s);
    A =rgb2gray(A);
    A_prime = A(end-200:end, 3300:end);
    A_prime(A_prime>5) = 255;
    A_prime(A_prime<=10) = 0;
    n_row = size(A_prime, 1);
    switch_pixels = -1 * ones(n_row,1);
    corner_found = false;
    i_row = 1;
    last_val = find(A_prime(1,:) == 0,1);
    while ~corner_found && i_row < n_row 
        switch_pixels(i_row) = find(A_prime(i_row,:) == 0,1);
        if switch_pixels(i_row) - last_val < -10
            corner_found = true;
            y(:, count_s) = [i_row - 1, last_val];
            count_s = count_s + 1;
        end
        last_val = switch_pixels(i_row);
        i_row = i_row + 1;
    end
end
end