function main()
f = @equation;
nodesNumbers = [7 15 31 63];
l = length(nodesNumbers);

time_direct = zeros(1, l);
storage_direct = zeros(1, l);

time_sparse = zeros(1, l);
storage_sparse = zeros(1, l);

time_seidel = zeros(1, l);
storage_seidel = zeros(1, l);

for i = 1 : l
    m = nodesNumbers(i);
    
    N_x = m;
    N_y = m;
    
    N = N_x * N_y;
    
    h_x = 1 / (N_x + 1);
    h_y = 1 / (N_y + 1);
    
    xx = repmat(h_x : h_x : 1 - h_x, 1, N_y);
    yy = reshape(repmat(h_y : h_y : 1 - h_y, N_x, 1), 1, N);
    b = f(xx, yy).';
    
    A = makeMatrix(N_x, N_y);
    
    [time_direct(i), storage_direct(i)] = direct(A, b);
    [time_sparse(i), storage_sparse(i)] = direct_sparse(A, b);
    [result, time_seidel(i), storage_seidel(i)] = seidel(b, N_x, N_y);
    
    %figure('Name', strcat('Surface Seidel ', num2str(m)));
    %surf(0 : h_x: 1, 0 : h_y : 1, result);
    %shg;
    
    %figure('Name', strcat('Contour Seidel ', num2str(m)));
    %contour(0 : h_x: 1, 0 : h_y : 1, result);
    %shg;
    %error = sqrt(1 / N) * norm(f(xx, yy) - reshape(result(2:N_y+1,2:N_x+1), 1, N), 2)
end

printTable(nodesNumbers, time_direct, storage_direct);
printTable(nodesNumbers, time_sparse, storage_sparse);
printTable(nodesNumbers, time_seidel, storage_seidel);
end

function printTable(numbers, time, storage)
column1 = [numbers(1); time(1); storage(1)];
column2 = [numbers(2); time(2); storage(2)];
column3 = [numbers(3); time(3); storage(3)];
column4 = [numbers(4); time(4); storage(4)];

table(column1, column2, column3, column4, 'RowNames', {'N_x, N_y', 'time (s)', 'storage'})
end