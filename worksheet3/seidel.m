function result = seidel(b, N_x, N_y)
tolerance = 1e-4;
N = N_x * N_y;
K_max = 10000;

h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

c = -2 * (1 / h_x^2 + 1 / h_y^2);

result = zeros(1, N);

k1 = 1 / h_y^2;
k4 = 1 / h_y^2;
k2 = 1 / h_x^2;
k3 = 1 / h_x^2;

% 0 ... k1 ... k2 point k3 ... k4 ... 0 
for i = 1 : K_max
    old = result;
    
    for j = 1 : N
        result(j) = b(j);
        
        if (j > N_x)
            result(j) = result(j) - k1 * result(j - N_x);
        end
        
        if (j + N_x <= N)
            result(j) = result(j) - k4 * result(j + N_x);
        end
        
        if (mod(j, N_x) ~= 1 && j > 1)
            result(j) = result(j) - k2 * result(j - 1);
        end
        
        if (mod(j, N_x) ~= 0 && j < N)
            result(j) = result(j) - k3 * result(j + 1);
        end
        
        result(j) = result(j) / c;
    end
    
    err = residual(b, result, N_x, N_y);
    
    if (err < tolerance)
        break;
    end
end

result = [
    zeros(1, N_x + 2);
    zeros(N_y, 1), vec2mat(result, N_x), zeros(N_y, 1);
    zeros(1, N_x + 2)
];

end