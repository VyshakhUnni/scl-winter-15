function A = makeMatrix(N_x, N_y)
N = N_x * N_y;

h_x = 1 / (N_x + 1);
h_y = 1 / (N_y + 1);

% coefficients on the main diagonal
rowCell = eye(N_x) * (-2 * (1 / h_x^2 + 1 / h_y^2));

% coefficients of horisontal neighbours
xx_diag = ones(1, N_x - 1);
D = diag(xx_diag, 1) * (1 / h_x^2) + diag(xx_diag, -1) * (1 / h_x^2);
rowCell = rowCell + D;

% coefficients of vertical neighbours
E_y = eye(N_x)  * (1 / h_y^2);

A = [ rowCell E_y zeros(N_x, N - 2 * N_x) ];
nextGroup = [ E_y rowCell E_y ];

% TODO: remove for loop (somehow?)
for i = 3 : N_y 
    A = [ 
        A; 
        zeros(N_x, (i - 3) * N_x) nextGroup zeros(N_x, N - i * N_x)
        ];
end

A = [ 
    A;
    zeros(N_x, N - 2 * N_x)  E_y rowCell 
    ];
end