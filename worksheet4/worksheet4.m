function main()
dt_list = [ 1/64 1/128 1/256 1/512 1/1024 1/2048 1/4096 ];
t_list = [ 1/8 2/8 3/8 4/8 ];
nodes_numbers = [ 3 7 15 31 ];

t_end = 1;

% m = 7;
% dt = 1/512;
% 
% [N_x, N_y, N, h_x, h_y] = setVariables(m);
% temperature_0 = ones(1, N);
% 
% result = iEuler(temperature_0, dt,t_end,N_x, N_y);
% result1 = [
%     zeros(1, N_x + 2);
%     zeros(N_y, 1), vec2mat(result(:, 1/8 / dt), N_x), zeros(N_y, 1);
%     zeros(1, N_x + 2)
%     ];
% 
% surf(0 : h_x: 1, 0 : h_y : 1, result1);
% shg;

for t = t_list
    k = 1;
    figure('Name', strcat('Explicit Euler t=', num2str(t)));
    for m = nodes_numbers
        [N_x, N_y, N, h_x, h_y] = setVariables(m);
        temperature_0 = ones(1, N);
        for dt = dt_list
            result = euler(@euler_equation, temperature_0, dt, t_end, N_x, N_y);
            
            result1 = [
                zeros(1, N_x + 2);
                zeros(N_y, 1), vec2mat(result(:, t / dt), N_x), zeros(N_y, 1);
                zeros(1, N_x + 2)
                ];
            
            subplot(4, 7, k);
            surf(0 : h_x: 1, 0 : h_y : 1, result1);
            k = k + 1;
        end
    end
    shg;
end
figure('Name', strcat('Implicit Euler t=', num2str(t)));
k = 1;
for t = t_list
    for m = nodes_numbers
        [N_x, N_y, N, h_x, h_y] = setVariables(m);
        temperature_0 = ones(1, N);
        
        dt = 1/64;
        
        result = iEuler(temperature_0, dt, t_end, N_x, N_y);
        
        result1 = [
            zeros(1, N_x + 2);
            zeros(N_y, 1), vec2mat(result(:, t / dt), N_x), zeros(N_y, 1);
            zeros(1, N_x + 2)
            ];
        
        subplot(4, 4, k);
        surf(0 : h_x: 1, 0 : h_y : 1, result1);
        k = k + 1;
    end
end
shg;

end

function [N_x, N_y, N, h_x, h_y] = setVariables(m)
N_x = m;
N_y = m;

N = N_x * N_y;

h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);
end