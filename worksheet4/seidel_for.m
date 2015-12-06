function [result, time, storage]  = seidel_for(previous, N_x, N_y, dt)
tolerance = 1e-6;

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
c_self = -2 * (1 / h_x^2 + 1 / h_y^2) * dt - 1;
c_x = dt / h_x^2;
c_y = dt / h_y^2;

for k = 1 : K_max
    old = result;
    
    % First inner row
    % - left boundary 
    result(1) = (previous(1) ...
        + c_x * result(2) ...
        + c_y * result(1 + N_x)) / c_self;
    
    % - middle
    for i = 2 : N_x - 1
        result(i) = (previous(i) ...
            + c_x * (result(i - 1) + result(i + 1)) ...
            + c_y * result(i + N_x)) / c_self;
    end
    
    % - right boundary
    result(N_x) = (previous(N_x) ...
        + c_x * result(N_x - 1) ...
        + c_y * result(2 * N_x)) / c_self;
    
    % Middle inner rows
    for j = 2 : N_y - 1
        % - left boundary
        index = 1 + N_x * (j - 1); 
        result(index) = (previous(index) ...
            + c_x * result(index + 1)...
            + c_y * (result(index - N_x) + result(index + N_x))) / c_self;
        
        % - middle
        for i = 2 : N_x - 1
            index = i + N_x * (j - 1);
            result(index) = (previous(index) ...
                + c_x * (result(index - 1) + result(index + 1)) ...
                + c_y * (result(index - N_x) + result(index + N_x))) / c_self;
        end
        
        % - right boundary
        index = N_x * j; 
        result(index) = (previous(index) ...
            + c_x * result(index - 1) ...
            + c_y * (result(index - N_x) + result(index + N_x))) / c_self;
    end
    
    % Last inner row
    % - left boundary
    index = N - N_x + 1; 
    result(index) = (previous(index) ...
        + c_x * result(index + 1) ...
        + c_y * result(index - N_x)) / c_self;
    
    % - middle
    for i = 2 : N_x - 1
        index = N - N_x + i;
        result(index) = (previous(index) ...
            + c_x * (result(index - 1) + result(index + 1)) ...
            + c_y * result(index - N_x)) / c_self;
    end
    
    % - right boundary
    result(N) = (previous(N) ...
        + c_x * result(N - 1) ...
        + c_y * result(N - N_x)) / c_self;
    
    accuracy = norm(old - result, 2);%residual_for(previous, result, N_x, N_y, c_self, c_x, c_y);
    
    if (accuracy < tolerance) 
        break;
    end
end
end