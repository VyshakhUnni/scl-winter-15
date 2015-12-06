function result = euler(func, temperature_0, dt, t_end, N_x, N_y) %name clash
n = t_end / dt; % number of steps
N = length(temperature_0);
result = zeros(N, n); % prealloc results array
result(:, 1) = temperature_0; % set first element

for i = 1 : n
    result(:, i + 1) = result(:, i) + dt * func(result(:, i), N_x, N_y);
end
end