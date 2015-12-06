function result = residual_for(b, x, N_x, N_y, c_self, c_x, c_y)
N = N_x * N_y;
result = zeros(N, 1);

% First inner row
% - left boundary
result(1) = b(1) - c_self * x(1) ...
    - c_x * x(2) ...
    - c_y * x(1 + N_x);

% - middle
for i = 2 : N_x - 1
    result(i) = b(i) - c_self * x(i) ...
        - c_x * (x(i - 1) + x(i + 1)) ...
        - c_y * x(i + N_x);
end

% - right boundary
result(N_x) = b(N_x) - c_self * x(N_x) ...
    - c_x * x(N_x - 1) ...
    - c_y * x(2 * N_x);

% Middle inner rows
for j = 2 : N_y - 1
    % - left boundary
    index = 1 + N_x * (j - 1);

    result(index) = b(index) - (c_self * x(index) ...
        + c_x * x(index + 1) + ...
        + c_y * x(index - N_x) + c_y * x(index + N_x));
    
    % - middle
    for i = 2 : N_x - 1
        index = i + N_x * (j - 1);
        result(index) = b(index) - c_self * x(index) ...
            - c_x * (x(index - 1) + x(index + 1)) ...
            - c_y * x(index - N_x) -c_y * x(index + N_x);
    end
    
    % - right boundary
    index = N_x * j;
    result(index) = b(index) - c_self * x(index) ...
        - c_x * x(index - 1) ...
        - c_y * (x(index - N_x) + x(index + N_x));
end

% Last inner row
% - left boundary
index = N - N_x + 1;
result(index) = b(index) - c_self * x(index) ...
    - c_x * x(index + 1) ...
    - c_y * x(index - N_x);

% - middle
for i = 2 : N_x - 1
    index = N - N_x + i;
    result(index) = b(index) - c_self * x(index) ...
        - c_x * x(index - 1) - c_x * x(index + 1) ...
        - c_y * x(index - N_x);
end

% - right boundary
result(N) = b(N) - c_self * x(N) ...
    - c_x * x(N - 1) ...
    - c_y * x(N - N_x);
       
result = sqrt(1 / N) * norm(result, 2);
end