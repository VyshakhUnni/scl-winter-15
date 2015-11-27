function result = residual(b, x, N_x, N_y)
N = N_x * N_y;
temp = zeros(N, 1);

h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

k = -2 * (1 / h_x^2 + 1 / h_y^2);
k1 = 1 / h_y^2;
k4 = 1 / h_y^2;
k2 = 1 / h_x^2;
k3 = 1 / h_x^2;

for j = 1 : N
        temp(j) = b(j) - k * x(j);
        
        if (j > N_x)
            temp(j) = temp(j) - k1 * x(j - N_x);
        end
        
        if (j + N_x <= N)
            temp(j) = temp(j) - k4 * x(j + N_x);
        end
        
        if (mod(j, N_x) ~= 1 && j > 1)
            temp(j) = temp(j) - k2 * x(j - 1);
        end
        
        if (mod(j, N_x) ~= 0 && j + 1 <= N)
            temp(j) = temp(j) - k3 * x(j + 1);
        end
end
        
result = sqrt(1 / N * sum(temp .^ 2));
end