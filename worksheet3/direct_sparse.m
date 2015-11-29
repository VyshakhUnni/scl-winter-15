function [time, storage] = direct_sparse(A, b)
tic;
sparse(A) \ b;
time = toc;
storage = nnz(A) + length(b);
end