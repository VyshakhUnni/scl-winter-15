function f = implicit_euler(func, func_deriv, f0, dt, t_end, tolerance)
n = t_end / dt;
f = zeros(1, n);
f(1) = f0;
for i = 1:n,
    f(i + 1) = f(i) + dt * func(newton(f(i), func, func_deriv, tolerance));
end
end