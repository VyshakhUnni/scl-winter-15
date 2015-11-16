function error = Error(approximations, ideal, dt)
error = sqrt(dt * .2 * sum((approximations - ideal).^2));
end