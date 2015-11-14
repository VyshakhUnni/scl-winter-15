function result = newton (equation, eqDerivative, x0)

% The maximal number of iterations for Newton method
K_max = 100;
% Tolerence
eps = 1e-4;

% the value which will be returned in case of not converding Newton method
errorValue = x0;

for k = 1 : K_max
    derivative = eqDerivative(x0);
    
    % If derivative is close to zero then our method will not converge.
    if (abs(derivative) < 1e-10) 
        result = errorValue;
        break;
    else
        x_next = x0 - equation(x0) / derivative;
        
        if (abs(x_next - x0) < eps)
            result = x_next;
            break;
        end
        
        x0 = x_next;
    end
    
    result = errorValue;
end
end