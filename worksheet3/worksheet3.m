% In this project you can find the following files:

% analytical.m      | analytical solution;
% direct.m          | direct solver;
% direct_sparse.m   | direct solver with the sparse matrix;
% equation.m        | rightside function from equation;
% makeMatrix.m      | builds a matrix for b);

% The next files is different implementations of residual and seidel
% method.
% In *_for.m we are avoiding unnecessary checks of boundary and considering
% separetely first line, last line and middle lines. Also for each row we
% are considering separetely left and right boundary.
% In *_if.m files we have implemented more intuitive and readable solution.
% It appears that *_for.m realisation is faster than *_if.m: for 63 nodes
% it takes around 2.35 seconds for for-loop implementation and 3.12 for
% if-implementation.

% residual_for.m    |
% residual_if.m     |
% seidel_for.m      |
% seidel_if.m       |
function main()
f = @equation;
T = @analytical;

nodesNumbers = [7 15 31 63];
l = length(nodesNumbers);

time_direct = zeros(1, l);
storage_direct = zeros(1, l);

time_sparse = zeros(1, l);
storage_sparse = zeros(1, l);

time_seidel = zeros(1, l);
storage_seidel = zeros(1, l);
err = zeros(1, l + 1);

for i = 1 : l
    m = nodesNumbers(i);
    [N_x, N_y, N, h_x, h_y, xx, yy, b] = setVariables(m, f); 
    
    A = makeMatrix(N_x, N_y);
    
    [time_direct(i), storage_direct(i)] = direct(A, b);
    [time_sparse(i), storage_sparse(i)] = direct_sparse(A, b);
    [result, time_seidel(i), storage_seidel(i)] = seidel_for(b, N_x, N_y);
    
    figure('Name', strcat('Surface Seidel ', num2str(m)));
    surf(0 : h_x: 1, 0 : h_y : 1, result);
    shg;
    
    figure('Name', strcat('Contour Seidel ', num2str(m)));
    contour(0 : h_x: 1, 0 : h_y : 1, result);
    shg;
    
    err(i) = sqrt(1 / N) * norm(T(xx, yy) - reshape(result(2 : N_y + 1, 2 : N_x + 1), 1, N), 2);
end

fprintf('Direct solver')
printTimeStorageTable(nodesNumbers, time_direct, storage_direct);

fprintf('Direct solver with sparse matrix')
printTimeStorageTable(nodesNumbers, time_sparse, storage_sparse);

fprintf('Gauss Seidel solver')
printTimeStorageTable(nodesNumbers, time_seidel, storage_seidel);

% 127 nodes
[N_x, N_y, N, h_x, h_y, xx, yy, b] = setVariables(127, f);
result = seidel_for(b, N_x, N_y);
err(l + 1) = sqrt(1 / N) * norm(T(xx, yy) - reshape(result(2 : N_y + 1, 2 : N_x + 1), 1, N), 2);

column1 = [nodesNumbers(1); err(1); 0];
column2 = [nodesNumbers(2); err(2); err(1) / err(2)];
column3 = [nodesNumbers(3); err(3); err(2) / err(3)];
column4 = [nodesNumbers(4); err(4); err(3) / err(4)];
column5 = [127; err(5); err(4) / err(5)];

fprintf('Errors of Gauss Seidel method')
table(column1, column2, column3, column4, column5, 'RowNames', {'N_x, N_y', 'error', 'error red.'})
end

function [N_x, N_y, N, h_x, h_y, xx, yy, b] = setVariables(m, f)
N_x = m;
N_y = m;

N = N_x * N_y;

h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

xx = repmat(h_x : h_x : 1 - h_x, 1, N_y);
yy = reshape(repmat(h_y : h_y : 1 - h_y, N_x, 1), 1, N);
b = f(xx, yy).';
end

function printTimeStorageTable(numbers, time, storage)
column1 = [numbers(1); time(1); storage(1)];
column2 = [numbers(2); time(2); storage(2)];
column3 = [numbers(3); time(3); storage(3)];
column4 = [numbers(4); time(4); storage(4)];

table(column1, column2, column3, column4, 'RowNames', {'N_x, N_y', 'time (s)', 'storage'})
end