function main
% defaults
y0 = 1;
t_end = 5;
func = @pop_deriv;
t = linspace(0, 5, 100); % analytical t
p = pop(t); % analytical p

p5 = pop(linspace(0,5,5));
p10 = pop(linspace(0,5,10));
p20 = pop(linspace(0,5,20));
p40 = pop(linspace(0,5,40));

function processMethod (methodName, method)
results1 = method(func, y0, 1, t_end);
results2 = method(func, y0, .5, t_end);
results3 = method(func, y0, .25, t_end);
results4 = method(func, y0, .125, t_end);

fprintf('%s error for dt=1:    %f \n', methodName, Error(1, results1, p5));
fprintf('%s error for dt=.5:   %f \n', methodName, Error(.5, results2, p10));
fprintf('%s error for dt=.25:  %f \n', methodName, Error(.25, results3, p20));
fprintf('%s error for dt=.125: %f \n', methodName, Error(.125, results4, p40));

figure('Name', methodName, 'NumberTitle', 'off');
hold on; % don't overwrite previous plots

plot(t, p);
plot(linspace(0, 5, 5), results1);
plot(linspace(0, 5, 10), results2);
plot(linspace(0, 5, 20), results3);
plot(linspace(0, 5, 40), results4);

legend('analytical', 'dt = 1', 'dt = 1/2', 'dt = 1/4', 'dt = 1/8', 'Location', 'northwest');
xlabel('time step t');
ylabel('solution');
title(methodName);

hold off;
shg;

end

processMethod('Euler', @euler)
processMethod('Heun', @heun)
processMethod('Runge Kutta 4', @rk4)

end