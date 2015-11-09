function result = implicit_adams(f, df, y0, dt, t_end)

% number of steps
n = t_end / dt;
result = zeros(1, n);
result(1) = y0;

for i = 1:n
    nextStepEquation = @(y)(y - result(i) - dt * .5 * (f(result(i)) + f(y)));
    nextStepDerivative = @(y)(1 - df(y) * dt * .5);
    result(i + 1) = newton(nextStepEquation, nextStepDerivative, result(i), dt, 1.e-4, 0, 100);
end
end