start_point = 1;
fin_point = 179;
strings = [];
for n_i = start_point:fin_point
    if n_i < 10
        mystring = strcat("nov19/P101000",num2str(n_i),".jpg");
    elseif n_i < 100
        mystring = strcat("nov19/P10100",num2str(n_i),".jpg");
    else
        mystring = strcat("nov19/P1010",num2str(n_i),".jpg");
    end
    strings = [strings, mystring];    
end

edges = find_edges(strings);

save('Data/edges_nov19.mat','edges')
