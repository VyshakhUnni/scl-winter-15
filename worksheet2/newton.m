function result = newton (equation, eqDerivative, x0, h, eps, k, K_max)
x_next = x0 - equation(x0) / eqDerivative(x0);

if (abs(x0 - x_next) <= eps)
    result = x_next;
else
    k = k + 1;
    if (k < K_max)
        result = newton(equation, eqDerivative, x_next, h, eps, k, K_max);
    else
        result = x0;
    end
end
end