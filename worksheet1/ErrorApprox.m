function f = ErrorApprox(Result, BestResult, dt, t_end)
    sum = 0;
    n = t_end / dt;
    factor = length(BestResult)/n;
    for i = 1:n
        sum = sum + (Result(i) - BestResult(i*factor))^2;
    end
    f = sqrt(dt * 0.2 * sum);
end
