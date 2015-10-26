function result = heun(f, y0, dt, t_end)
% Result
result = y0;

% Number of steps
N = t_end / dt;

% Initial values
y_n = y0;
dy_n = f(y0);

for n = 0 : N - 1
    % (n + 1) derivative 
    dy_n1 = f(y_n + dt * f(y_n))
    
    % (n + 1) point
    y_n1 = y_n + dt * 0.5 * (dy_n + dy_n1);
    
    result = [ result, y_n1 ];
    
    % Preparing for next step
    dy_n = dy_n1;
    y_n = y_n1;
end

end