function result = residual(b, x, c_self, c_x, c_y)
N = length(b);
temp = zeros(N, 1);

for j = 1 : N
    temp(j) = b(j) - c_self * x(j);
    
    % Check that point does not belong to vertical bounds
    % - lower bound
    if (j > N_x)
        temp(j) = temp(j) - c_y * x(j - N_x);
    end
    
    % - upper bound
    if (j + N_x <= N)
        temp(j) = temp(j) - c_y * x(j + N_x);
    end
    
    % Check that point does not belong to horizontal bounds
    % - left bound
    if (mod(j, N_x) ~= 1 && j > 1)
        temp(j) = temp(j) - c_x * x(j - 1);
    end
    
    % - right bound
    if (mod(j, N_x) ~= 0 && j + 1 <= N)
        temp(j) = temp(j) - c_x * x(j + 1);
    end
end

result = sqrt(1 / N * sum(temp .^ 2));
end