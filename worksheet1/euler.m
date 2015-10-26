function result = euler(f, y0, dt, t_end)
result = y0;
y_n = y0;

% Number of steps
N = t_end / dt;

for n = 0 : N - 1
    y_n1 = f(y_n) * dt + y_n;
    result = [ result, y_n1 ];
    y_n = y_n1
end

end