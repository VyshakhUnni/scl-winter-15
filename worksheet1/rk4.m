function y = rk4(func, y0, dt, t_end)
n = t_end / dt; % number of steps
y = zeros(1, n);
y(1) = y0;
for i = 1:n-1,
    y1 = func(y(i));
    y2 = func(y(i) + dt * .5 * y1);
    y3 = func(y(i) + dt * .5 * y2);
    y4 = func(y(i) + dt * y3);
    y(i + 1) = y(i) + dt * .167 * (y1 + 2 * y2 + 2 * y3 + y4);
end
end