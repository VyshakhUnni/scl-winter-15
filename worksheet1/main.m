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

% calculate approximations euler
euler_results1 = euler1(func, y0, 1, t_end);
euler_results2 = euler1(func, y0, .5, t_end);
euler_results3 = euler1(func, y0, .25, t_end);
euler_results4 = euler1(func, y0, .125, t_end);
fprintf('Euler error for dt=1: %f \n', Error(1, euler_results1, p5));
fprintf('Euler error for dt=.5: %f \n', Error(.5, euler_results2, p10));
fprintf('Euler error for dt=.25: %f \n', Error(.25, euler_results3, p20));
fprintf('Euler error for dt=.125: %f \n', Error(.125, euler_results4, p40));

figure(1);
hold on; % don't overwrite previous plots
plot(t, p);
plot(linspace(0, 5, 5), euler_results1);
plot(linspace(0, 5, 10), euler_results2);
plot(linspace(0, 5, 20), euler_results3);
plot(linspace(0, 5, 40), euler_results4);
legend('analytical', 'dt = 1', 'dt = 1/2', 'dt = 1/4', 'dt = 1/8', 'Location', 'northwest');
xlabel('time step t');
ylabel('p(t) = 10 / (1 + 9e^{-t})');
title('A plot to show how varying the time step changes the accuracy of the euler method to approximate functions.');
hold off;
shg;

% calculate approximations Heun
heun_results1 = heun(func, y0, 1, t_end);
heun_results2 = heun(func, y0, .5, t_end);
heun_results3 = heun(func, y0, .25, t_end);
heun_results4 = heun(func, y0, .125, t_end);
fprintf('Heun error for dt=1: %f \n', Error(1, heun_results1, p5));
fprintf('Heun error for dt=.5: %f \n', Error(.5, heun_results2, p10));
fprintf('Heun error for dt=.25: %f \n', Error(.25, heun_results3, p20));
fprintf('Heun error for dt=.125: %f \n', Error(.125, heun_results4, p40));

figure(2)
hold on; % don't overwrite previous plots
plot(t, pop(t));
plot(linspace(0, 5, 5), heun_results1);
plot(linspace(0, 5, 10), heun_results2);
plot(linspace(0, 5, 20), heun_results3);
plot(linspace(0, 5, 40), heun_results4);
legend('analytical', 'dt = 1', 'dt = 1/2', 'dt = 1/4', 'dt = 1/8', 'Location', 'northwest');
xlabel('time step t');
ylabel('p(t) = 10 / (1 + 9e^{-t})');
title('A plot to show how varying the time step changes the accuracy of the heun method to approximate functions.');
hold off;
shg;

% calculate approximations Heun
rk4_results1 = rk4(func, y0, 1, t_end);
rk4_results2 = rk4(func, y0, .5, t_end);
rk4_results3 = rk4(func, y0, .25, t_end);
rk4_results4 = rk4(func, y0, .125, t_end);
fprintf('Rk4 error for dt=1: %f \n', Error(1, rk4_results1, p5));
fprintf('Rk4 error for dt=.5: %f \n', Error(.5, rk4_results2, p10));
fprintf('Rk4 error for dt=.25: %f \n', Error(.25, rk4_results3, p20));
fprintf('Rk4 error for dt=.125: %f \n', Error(.125, rk4_results4, p40));

figure(3)
hold on; % don't overwrite previous plots
plot(t, pop(t));
plot(linspace(0, 5, 5), rk4_results1);
plot(linspace(0, 5, 10), rk4_results2);
plot(linspace(0, 5, 20), rk4_results3);
plot(linspace(0, 5, 40), rk4_results4);
legend('analytical', 'dt = 1', 'dt = 1/2', 'dt = 1/4', 'dt = 1/8', 'Location', 'northwest');
xlabel('time step t');
ylabel('p(t) = 10 / (1 + 9e^{-t})');
title('A plot to show how varying the time step changes the accuracy of the rk4 method to approximate functions.');
hold off;
shg;