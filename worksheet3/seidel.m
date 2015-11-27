function result = seidel(b, N_x, N_y)
tolerance = 1e-4;

N_xAll = N_x + 2;
N_yAll = N_y + 2;

N = N_xAll * N_yAll;

% Max number of iterations of Seidel method
K_max = 10000;

% Steps
h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

% Init result as a vector
result = zeros(1, N);

% coefficient from main diagonal
c = -2 * (1 / h_x^2 + 1 / h_y^2);

% Vector of non-main coefficients
k = [ (1 / h_y^2) (1 / h_x^2) (1 / h_x^2) (1 / h_y^2) ];

for n = 1 : K_max   
    
    % Index among inner points
    innerIndex = 1;
    
    % The next loops are only for inner points
    for j = 2 : N_y + 1
        for i = 2 : N_x + 1
            % Index among all points
            index = i + N_xAll * (j - 1);
            
            % Indexes of elements with non-zero coefficients
            itemIndexes = [
                index - N_x - 2
                index - 1
                index + 1
                index + N_x + 2
                ];
            
            result(index) = (b(innerIndex) - dot(result(itemIndexes), k)) / c;
            
            innerIndex = innerIndex + 1;
        end
    end
            
    % Compute the accuracy
    accuracy = residual(b, result, N_x, N_y);
    
    % If residual is smaller than tolerance then finish the iterations
    if (accuracy < tolerance)
        break;
    end
end

% result vector to matrix form
result = vec2mat(result, N_x + 2);

end