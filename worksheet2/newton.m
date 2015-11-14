function result = newton (equation, eqDerivative, x0)
K_max = 100;
eps = 1e-4;

for k = 1 : K_max
    derivative = eqDerivative(x0);
    
    if (abs(derivative) < 1e-10) 
        result = x0;
        break;
    else
        x_next = x0 - equation(x0) / derivative;
        
        if (abs(x_next - x0) < eps)
            result = x_next;
            break;
        end
        
        x0 = x_next;
    end
    
    result = x0;
end
end