function result = iAdams_lin2(f, df, y0, dt, t_end)

% number of steps
n = t_end / dt;
result = NaN(1, n + 1);
result(1) = y0;

for i = 1:n
    y_n = result(i);
    nextStepEquation = @(y)(y - y_n - dt * .5 * (7 * (1 - y_n / 10) * y_n + 7 * (1 - y_n / 10) * y));
    nextStepDerivative = @(y)(1 - dt * .5 * 7 * (1 - y_n / 10));
    result(i + 1) = newton(nextStepEquation, nextStepDerivative, result(i));
end
end