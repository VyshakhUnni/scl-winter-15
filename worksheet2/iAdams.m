function result = implicit_adams(f, df, y0, dt, t_end)

% number of steps
n = t_end / dt;
result = NaN(1, n + 1);
result(1) = y0;
nextStepDerivative = @(y)(1 - df(y) * dt * .5);

for i = 1:n
    y_n = result(i);
    nextStepEquation = @(y)(y - y_n - dt * .5 * (f(y_n) + f(y)));
    result(i + 1) = newton(nextStepEquation, nextStepDerivative, result(i));
    
    if isnan(result(i + 1))
        fprintf('For dt = %f Newton method does not converge\n', dt)
        break;
    end
end
end