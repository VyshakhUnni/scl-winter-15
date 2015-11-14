function result = implicit_euler(f, df, y0, dt, t_end)

% number of steps
n = t_end / dt;
result = zeros(1, n);
result(1) = y0;

% G'(y) = 1 - f'(y)
nextStepDerivative = @(y)(1 - dt * df(y));

for i = 1:n
    % G(y) = y - f(y)
    nextStepEquation = @(y)(y - result(i) - dt * f(y));
    
    result(i + 1) = newton(nextStepEquation, nextStepDerivative, result(i));
end
end