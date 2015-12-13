function result = iEuler(temperature_0, dt, t_end, N_x, N_y)

% number of steps
n = t_end / dt;
N = length(temperature_0);
result = NaN(N, n + 1);
result(:, 1) = temperature_0;

for i = 1 : n
    result(:, i + 1) = seidel_for(result(:, i), N_x, N_y, dt);
end
end