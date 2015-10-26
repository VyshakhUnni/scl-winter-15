exact_solution = @(t)(10. / (1. + 9. * exp(-t)));

% Parameters
f = @(y)(1 - y / 10) * y;
y0 = 1;
t_end = 5;
dt = 1/2;

points = 0:dt:t_end;
exact_result = exact_solution(points);

% Exact solution plot
%plot(points, exactSolutionPoints);

euler_result = euler(f, y0, dt, t_end);
heun_result = heun(f, y0, dt, t_end);
%plot(points, euler_result, 'r', points, exact_result, 'b');
plot(points, heun_result, 'r', points, exact_result, 'b');