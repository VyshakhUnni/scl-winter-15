function result = newton (equation, eqDerivative, x0)

% The maximal number of iterations for Newton method
K_max = 100;
% Tolerence
tolerance = 1e-4;

% the value which will be returned in case of not converding Newton method
errorValue = NaN;

for k = 1 : K_max
    derivative = eqDerivative(x0);
    
    % If derivative is close to zero then our method will not converge.
    if (abs(derivative) < eps) 
        result = errorValue;
        break;
    else
        x_next = x0 - equation(x0) / derivative;
        
        % Success!
        if (abs(x_next - x0) < tolerance)
            result = x_next;
            break;
        end
        
        x0 = x_next;
    end
    
    result = errorValue;
end
end