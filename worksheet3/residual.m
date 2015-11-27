function result = residual(b, x, N_x, N_y, c_self, c_x, c_y)
N = N_x * N_y;
result = zeros(N, 1);

rowNumber = 1;
columnNumber = 1;

for j = 1 : N
    temp = b(j) - c_self * x(j);
    
    % Check that point does not belong to vertical bounds
    % - lower bound
    if (j > N_x)
        temp = temp - c_y * x(j - N_x);
    end
    
    % - upper bound
    if (j + N_x <= N)
        temp = temp - c_y * x(j + N_x);
    end
    
    % Check that point does not belong to horizontal bounds
    % - left bound
    if (mod(j, N_x) ~= 1 && j > 1)
        temp = temp - c_x * x(j - 1);
    end
    
    % - right bound
    if (mod(j, N_x) ~= 0 && j + 1 <= N)
        temp = temp - c_x * x(j + 1);
    else
        rowNumber = rowNumber + 1;
        columnNumber = 0;
    end
    
    columnNumber = columnNumber + 1;
    
    result(j) = temp;
end

result = sqrt(1 / N) * norm(result, 2);
end