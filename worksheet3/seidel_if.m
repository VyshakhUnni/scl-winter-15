% =========================================================================
% Implementation with if-statements
% It is slower (3.1 seconds vs 2.35 seconds).
% We are providing this implementation since it is more readable 
% and intuitial and still works well.
% =========================================================================

function [result, time, storage]  = seidel_if(b, N_x, N_y)
tolerance = 1e-4;

% number of inner points
N = N_x * N_y;

% Maximal number of iterations
K_max = 100000;

% Steps
h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

% Initializing result as a zero vector
result = zeros(1, N);

% 0 ... c_y ... c_x c_self c_x ... c_y ... 0
% c_self - self coefficient
% c_x - coefficient of horizontal neighbours
% c_y - coefficient of vertical neighbours
c_self = -2 * (1 / h_x^2 + 1 / h_y^2);
c_x = 1 / h_x^2;
c_y = 1 / h_y^2;

tic
for k = 1 : K_max
    rowNumber = 1;
    columnNumber = 1;
    
    for j = 1 : N
        temp = b(j);
        
        % Check that point does not belong to vertical bounds
        % - lower bound
        if (j > N_x)
            temp = temp - c_y * result(j - N_x);
        end
        
        % - upper bound
        if (j + N_x <= N)
            temp = temp - c_y * result(j + N_x);
        end      
        
        % Check that point does not belong to horizontal bounds
        % - left bound
        if (columnNumber ~= 1)
            temp = temp - c_x * result(j - 1);
        end
        
        % - right bound
        if (columnNumber ~= N_x)
            temp = temp - c_x * result(j + 1);
        else
            rowNumber = rowNumber + 1;
            columnNumber = 0;
        end
        
        columnNumber = columnNumber + 1;
        
        result(j) = temp / c_self;
    end
    
    err = residual_if(b, result, N_x, N_y, c_self, c_x, c_y);
    
    if (err < tolerance)
        break;
    end
end

% Adding zero as the bounderies
result = [
    zeros(1, N_x + 2);
    zeros(N_y, 1), vec2mat(result, N_x), zeros(N_y, 1);
    zeros(1, N_x + 2)
];

time = toc;
storage = 5 + length(b);
end