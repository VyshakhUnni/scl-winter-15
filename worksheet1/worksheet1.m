function main
    y0 = 1;
    t_end = 5;
    func = @equation;
    t = linspace(0, t_end, 1000); % analytical t
    p = Analytical(t); % analytical p    

    t1 = linspace(0,t_end,6);
    t2 = linspace(0,t_end,11);
    t3 = linspace(0,t_end,21);
    t4 = linspace(0,t_end,41);
    t5 = linspace(0,t_end,81);
    
    p1 = Analytical(t1);
    p2 = Analytical(t2);
    p3 = Analytical(t3);
    p4 = Analytical(t4);
    p5 = Analytical(t5);

    dt = [1 0.5 0.25 0.125 0.0625];
    
    function processMethod (methodName, method)
        results1 = method(func, y0, dt(1), t_end);
        results2 = method(func, y0, dt(2), t_end);
        results3 = method(func, y0, dt(3), t_end);
        results4 = method(func, y0, dt(4), t_end);
        results5 = method(func, y0, dt(5), t_end);
        
        % Error using exact (analytical) solution
        Error1 = Error(results1, p1, dt(1));
        Error2 = Error(results2, p2, dt(2));
        Error3 = Error(results3, p3, dt(3));
        Error4 = Error(results4, p4, dt(4));
        Error5 = Error(results5, p5, dt(5));
        
        ErRedFact1 = Error1 / Error2;
        ErRedFact2 = Error2 / Error3;
        ErRedFact3 = Error3 / Error4;
        ErRedFact4 = Error4 / Error5;

        % Error using the best approximation
        ApproxError1 = Error(results1, results4(1:8:41), dt(1));
        ApproxError2 = Error(results2, results4(1:4:41), dt(2));
        ApproxError3 = Error(results3, results4(1:2:41), dt(3));
        ApproxError4 = Error(results4, results4, dt(4));

        % Result table
        column1 = [dt(1); Error1; ErRedFact1; ApproxError1];
        column2 = [dt(2); Error2; ErRedFact2; ApproxError2];
        column3 = [dt(3); Error3; ErRedFact3; ApproxError3];
        column4 = [dt(4); Error4; ErRedFact4; ApproxError4];

        fprintf('%s method', methodName)
        table(column1, column2, column3, column4, 'RowNames', {'dt'; 'error'; 'error red.'; 'error app.'})

        figure('Name', methodName, 'NumberTitle', 'off');
        hold on; % don't overwrite previous plots
        plot(t, p);
        plot(t1, results1);
        plot(t2, results2);
        plot(t3, results3);
        plot(t4, results4);

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