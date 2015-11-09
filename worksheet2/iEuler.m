function result = implicit_euler(f, df, y0, dt, t_end)

% number of steps
n = t_end / dt;
result = zeros(1, n);
result(1) = y0;

for i = 1:n
    nextStepEquation = @(y)(y - result(i) - dt * f(y));
    nextStepDerivative = @(y)(1 - dt * df(y));
    result(i + 1) = newton(nextStepEquation, nextStepDerivative, result(i), dt, 1.e-4, 0, 100);
end
end