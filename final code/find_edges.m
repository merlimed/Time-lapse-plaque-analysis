function y = find_edges(strings)
len_edge = 10;
y = -8 * ones(2, len_edge, length(strings));
count_s = 1;
for s = strings
    A = imread(s);
    A =rgb2gray(A);
    A_prime = A(end-200:end, 3300:end);
    A_prime(A_prime>5) = 255;
    A_prime(A_prime<=10) = 0;
    for i_row = 1:len_edge
        y(2, i_row, count_s) = find(A_prime(i_row,:) == 0,1);
        y(1, i_row, count_s) = i_row;
    end
    count_s = count_s + 1;
end
end