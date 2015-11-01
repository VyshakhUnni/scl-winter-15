function main
    y0 = 1;
    t_end = 5;
    func = @NumericalSolution;
    t = linspace(0, 5, 100); % analytical t
    p = Analytical(t); % analytical p    

    p5 = Analytical(linspace(0,5,5));
    p10 = Analytical(linspace(0,5,10));
    p20 = Analytical(linspace(0,5,20));
    p40 = Analytical(linspace(0,5,40));
    p80 = Analytical(linspace(0,5,80));

    dt = [1 0.5 0.25 0.125 0.0625];
    
    function processMethod (methodName, method)
        results1 = method(func, y0, dt(1), t_end);
        results2 = method(func, y0, dt(2), t_end);
        results3 = method(func, y0, dt(3), t_end);
        results4 = method(func, y0, dt(4), t_end);
        results5 = method(func, y0, dt(5), t_end);
        
        Error1 = Error(results1, p5, dt(1));
        Error2 = Error(results2, p10, dt(2));
        Error3 = Error(results3, p20, dt(3));
        Error4 = Error(results4, p40, dt(4));
        Error5 = Error(results5, p80, dt(5));
        
        ErRedFact1 = Error1 / Error2;
        ErRedFact2 = Error2 / Error3;
        ErRedFact3 = Error3 / Error4;
        ErRedFact4 = Error4 / Error5;

        ApproxError1 = ErrorApprox(results1, results4, dt(1), t_end);
        ApproxError2 = ErrorApprox(results2, results4, dt(2), t_end);
        ApproxError3 = ErrorApprox(results3, results4, dt(3), t_end);
        ApproxError4 = ErrorApprox(results4, results4, dt(4), t_end);

        % Result table
        column1 = [dt(1); Error1; ErRedFact1; ApproxError1];
        column2 = [dt(2); Error2; ErRedFact2; ApproxError2];
        column3 = [dt(3); Error3; ErRedFact3; ApproxError3];
        column4 = [dt(4); Error4; ErRedFact4; ApproxError4];

        table(column1, column2, column3, column4, 'RowNames', {'dt'; 'error'; 'error red.'; 'error app.'})

        figure('Name', methodName, 'NumberTitle', 'off');
        hold on; % don't overwrite previous plots
        plot(t, p);
        plot(linspace(0, 5, 5), results1);
        plot(linspace(0, 5, 10), results2);
        plot(linspace(0, 5, 20), results3);
        plot(linspace(0, 5, 40), results4);

        legend('analytical', 'dt = 1', 'dt = 1/2', 'dt = 1/4', 'dt = 1/8', 'Location', 'northwest');
        xlabel('time step t');
        ylabel('solution');
        title(methodName);

        hold off;
        shg;
    end

    processMethod('Euler', @euler);    
    processMethod('Heun', @heun);
    processMethod('Runge Kutta 4', @rk4);
    
end
