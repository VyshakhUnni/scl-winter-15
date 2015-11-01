function f = Error(approximations, analytical, dt)
sum = 0;
for i = 1:length(approximations) % optimise?
    sum = sum + (approximations(i) - analytical(i))^2;
end
f = sqrt(dt * 0.2 * sum);
end