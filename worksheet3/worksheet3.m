function main()
f = @(x, y)(-2 * pi^2 * sin(pi * x) .* sin(pi * y));
exact = @(x,y)(sin(pi * x) * sin(pi * y));

m = 63;
N_x = m;
N_y = m;
N = N_x * N_y;

N_inner = N - 2 * (N_x + N_y) + 4;

h_x = 1 / (N_x - 1);
h_y = 1 / (N_y - 1);

xx = zeros(N_inner, 1);
yy = zeros(N_inner, 1);

%TODO check this
for i = 2 : N_y - 1
    xx(1 + (i - 2) * (N_x - 2) : (i - 1) * (N_x - 2)) = h_x : h_x : 1 - h_x;
end

%TODO and this
for i = 2 : N_x - 1
    yy(1 + (i - 2) * (N_y - 2) : (i - 1) * (N_y - 2)) = ones(1, N_y - 2) * (i - 1) * h_y; 
end

A = makeMatrix(N_x, N_y);
b = [zeros(2 * (N_x + N_y) - 4, 1); f(xx, yy)];

result = vec2mat(linsolve(A, b), N_x);

%surf(0:h_x:1, 0:h_y:1, result);
%shg

O = zeros(N_y, N_x);

for i=1:N_x
    for j=1:N_y
        O(i, j) = exact(j * h_y, i*h_x) - result(i, j);
    end
end

surf(0:h_x:1, 0:h_y:1, O);
%ezsurfc(exact,[0,1,0,1],35)
end

function A = makeMatrix(N_x, N_y)
N = N_x * N_y;

h_x = 1 / (N_x - 1);
h_y = 1 / (N_y - 1);

A = zeros(N, N);

% TODO 
% The next lines are strange. I am sure that there is a quick way to do
% this.

% corners
A(1, 1) = 1;
A(2, N_y) = 1;
A(3, N - N_y + 1) = 1;
A(4, N) = 1;

j = 5;

% horizontal boundaries
for i = 2 : N_y - 1
    A(j, i) = 1;
    A(j + 1, N - N_y + i) = 1;
    j = j + 2;
end

% vertical boundaries
for i = 2 : N_x - 1
    A(j, (i - 1) * N_y + 1) = 1;
    A(j + 1, i * N_y) = 1;
    j = j + 2;
end

% Number of inner points
N_inner = (N_x - 2) * (N_y - 2);

% init equation matrix
C = zeros(0, N);

% coefficients on the main diagonal
rowCell = [zeros(N_x - 2, 1) eye(N_x - 2) * (-2 * (1 / h_x^2 + 1 / h_y^2)) zeros(N_x - 2, 1)];

% coefficients of horisontal neibors
xx_diag = ones(1, N_x - 1);
D = diag(xx_diag, 1) * (1 / h_x^2) + diag(xx_diag, -1) * (1 / h_x^2);
D = D([2 : N_x - 1], :);
rowCell = rowCell + D;

% coefficients of vertical neibors
E_y = eye(N_x - 2)  * (1 / h_y^2);

zeroColumn = zeros(N_x - 2, 1); % TODO check that we really need another empty column here. Looks not good

nextGroup = [zeroColumn E_y zeroColumn rowCell zeroColumn E_y zeroColumn];

% TODO: remove for loop (somehow?)
for i = 1 : N_y - 2
    temp = [ zeros(N_x - 2, (i - 1) * N_x) nextGroup ];
    C = [ C; temp zeros(N_x - 2, N - size(temp, 2)) ];
end

% Add inner equations to the matrix
A(N - N_inner + 1: N, :) = C;

end