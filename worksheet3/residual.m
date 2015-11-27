function result = residual(b, x, N_x, N_y)
N = N_x * N_y;
temp = zeros(N, 1);

h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

k = [ (1 / h_y^2) (1 / h_x^2) (-2 * (1 / h_x^2 + 1 / h_y^2)) (1 / h_x^2) (1 / h_y^2) ];

for j = 2 : N_y + 1
    for i = 2 : N_x + 1
        index = i + (N_x + 2) * (j - 1);
        innerIndex = index - N_x - 2 * j + 1;
        itemsIndexes = [
            index - N_x - 2 
            index - 1 
            index 
            index + 1 
            index + N_x + 2
            ];
      
        temp(innerIndex) = b(innerIndex) - dot(x(itemsIndexes), k);
    end
end
        
result = sqrt(sum(temp .^ 2) / N);
end