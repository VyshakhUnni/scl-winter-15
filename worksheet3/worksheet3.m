function main()
f = @equation;
nodesNumbers = [7 15 31 127];
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