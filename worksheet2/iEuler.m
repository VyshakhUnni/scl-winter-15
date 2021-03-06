function result = iEuler(f, df, y0, dt, t_end)

% number of steps
n = t_end / dt;
result = NaN(1, n + 1);
result(1) = y0;

% G'(y) = 1 - dt * f'(y)
nextStepDerivative = @(y)(1 - dt * df(y));

for i = 1:n
    % G(y) = y - y_n - dt * f(y)
    nextStepEquation = @(y)(y - result(i) - dt * f(y));
    result(i + 1) = newton(nextStepEquation, nextStepDerivative, result(i));
    
    if isnan(result(i + 1))
        fprintf('For dt = %f Newton method does not converge\n', dt)
        break;
    end
end
end