function xnn = newton(x0, func, func_deriv, tolerance)

temp = x0 - func(x0) / func_deriv(x0);

while (abs(temp - x0) > tolerance)
    x0 = temp;
    temp = x0 - func(x0) / func_deriv(x0);
end

xnn = temp;

end