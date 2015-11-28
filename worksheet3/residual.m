function result = residual(b, x, N_x, N_y, c_self, c_x, c_y)
N = N_x * N_y;
N_xAll = N_x + 2;
result = zeros(N, 1);

innerIndex = 1;

for j = 2 : N_y + 1
    for i = 2 : N_x + 1
        index = i + N_xAll * (j - 1);
        result(innerIndex) = b(innerIndex) - dot([c_y c_x c_self c_x c_y], x([index-N_x-2 index - 1 index index+1 index+N_x + 2]));
        innerIndex = innerIndex + 1;
    end
end

result = sqrt(1 / N) * norm(result, 2);
end