function main()
f = @equation;
exact = @analytical;

m = 31;
N_x = m;
N_y = m;

N = N_x * N_y;

h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

xx = zeros(N, 1);
yy = zeros(N, 1);

%TODO check this
for i = 2 : N_y - 1
    xx(1 + (i - 2) * N_x : (i - 1) * N_x) = h_x : h_x : 1 - h_x;
end

%TODO and this
for i = 2 : N_x - 1
    yy(1 + (i - 2) * N_y : (i - 1) * N_y) = ones(1, N_y) * (i - 1) * h_y; 
end

A = makeMatrix(N_x, N_y);
b = f(xx, yy);

result = vec2mat(linsolve(A, b), N_x);

resultSparse = vec2mat(A \ b, N_x);

surf(h_x:h_x:1-h_x, h_y:h_y:1-h_y, result);
%surf(h_x:h_x:1-h_x, h_y:h_y:1-h_y, resultSparse);

shg

%ezsurfc(exact,[0,1,0,1],35)
end