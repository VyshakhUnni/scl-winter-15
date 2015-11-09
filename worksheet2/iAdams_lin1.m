function result = implicit_adams_lin1(f, df, y0, dt, t_end)

% number of steps
n = t_end / dt;
result = zeros(1, n);
result(1) = y0;

for i = 1:n
    yn = result(i);
    nextStepEquation = @(y)(y - yn - dt * .5 * (7 * (1 - yn / 10) * yn + 7 * (1 - y / 10) * yn));
    nextStepDerivative = @(y)(1 + dt * .5 * 7 * yn / 10);
    result(i + 1) = newton(nextStepEquation, nextStepDerivative, result(i), dt, 1.e-4, 0, 100);
end
end