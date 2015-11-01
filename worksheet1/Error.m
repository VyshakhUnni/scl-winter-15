function error = Error(approximations, analytical, dt)
error = sqrt(dt * 0.2 * sum((approximations - analytical).^2));
end