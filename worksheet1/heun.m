function y = heun(func, y0, dt, t_end)
n = t_end / dt; % number of steps
y = zeros(1, n);
y(1) = y0;
for i = 1:n-1, 
    y(i + 1) = y(i) + dt * .5 * (func(y(i)) + func(y(i) + dt * func(y(i))));
end
end