function f = Error(result,  dt, t_end)
    sum = 0;
    n = t_end / dt;
    BestApprox  = Analytical(linspace(0,t_end,n ));
    for i = 1:n
        sum = sum + (result(i) - BestApprox(i))^2;
    end
    f = sqrt(dt * 0.2 * sum);
end
