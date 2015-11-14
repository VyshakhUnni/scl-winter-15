function y = euler(func, y0, dt, t_end) %name clash
n = t_end / dt; % number of steps
y = zeros(1,n); % prealloc results array
y(1) = y0; % set first element
for i = 1:n, % t is confusing rename
    y(i+1) = y(i) + dt * func(y(i));
end
end
