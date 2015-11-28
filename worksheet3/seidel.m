function [result, time, storage]  = seidel(b, N_x, N_y)
tolerance = 1e-4;

% number of inner points
N = N_x * N_y;
N_xAll = N_x + 2;

% Maximal number of iterations
K_max = 10;

% Steps
h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

% Initializing result as a zero vector
result = zeros(1, (N_x + 2)*(N_y + 2));

% 0 ... c_y ... c_x c_self c_x ... c_y ... 0
% c_self - self coefficient
% c_x - coefficient of horizontal neighbours
% c_y - coefficient of vertical neighbours
c_self = -2 * (1 / h_x^2 + 1 / h_y^2);
c_x = 1 / h_x^2;
c_y = 1 / h_y^2;

tic
for k = 1 : K_max
    innerIndex = 1;
    
    for j = 2 : N_y +1 
        for i = 2 : N_x + 1
            index = i + N_xAll * (j - 1);
            result(index) = (b(innerIndex) - dot([c_y c_x c_x c_y], result([index-N_x-2 index - 1 index+1 index+N_x + 2]))) / c_self;
            innerIndex = innerIndex + 1;
        end
    end
    
    err = residual(b, result, N_x, N_y, c_self, c_x, c_y);
    
    if (err < tolerance)
        break;
    end
end

time = toc;
storage = 5 + length(b);

% Adding zero as the bounderies
%result = [
%    zeros(1, N_x + 2);
%    zeros(N_y, 1), vec2mat(result, N_x), zeros(N_y, 1);
%    zeros(1, N_x + 2)
%];

end