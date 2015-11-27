function [time, storage] = direct(A, b)
tic;
A \ b;
time = toc;
storage = numel(A) + length(b);
end