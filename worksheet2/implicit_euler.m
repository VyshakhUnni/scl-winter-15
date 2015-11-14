function f = implicit_euler(func, func_deriv, f0, dt, t_end, tolerance)
n = t_end / dt;
f = zeros(1, n);
f(1) = f0;
for i = 1:n,
    nextStepEquation = @(y)(y - f(i) - dt * func(y));
    nextStepDerivative = @(y)(1 - dt * func_deriv(y));
    f(i + 1) = f(i) + dt * func(newton(f(i), nextStepEquation, nextStepDerivative, tolerance));
end
end