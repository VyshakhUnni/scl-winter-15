function main
    y0 = 1;
    t_end = 5;
    func = @NumericalSolution;
    t = linspace(0, 5, 100); % analytical t
    p = Analytical(t); % analytical p
    dt = [1 0.5 0.25 0.125];
    
    function[Errors,ErRedFact,ApproxErrors] =  processMethod (methodName, method)
        results1 = method(func, y0, dt(1), t_end);
        results2 = method(func, y0, dt(2), t_end);
        results3 = method(func, y0, dt(3), t_end);
        results4 = method(func, y0, dt(4), t_end);
        Errors1 = Error(results1, dt(1), t_end);
        Errors2 = Error(results2, dt(2), t_end);
        Errors3 = Error(results3, dt(3), t_end);
        Errors4 = Error(results4, dt(4), t_end);
        Errors = [Errors1 Errors2 Errors3 Errors4];
        ErRedFact1 = 0;
        ErRedFact2 = (Errors1 - Errors2)/Errors1;
        ErRedFact3 = (Errors2 - Errors3)/Errors2;
        ErRedFact4 = (Errors3 - Errors4)/Errors3;
        ErRedFact = [ErRedFact1 ErRedFact2 ErRedFact3 ErRedFact4];

        ApproxErrors1 = ErrorApprox(results1, results4,dt(1), t_end);
        ApproxErrors2 = ErrorApprox(results2, results4,dt(2), t_end);
        ApproxErrors3 = ErrorApprox(results3, results4,dt(3), t_end);
        ApproxErrors4 = ErrorApprox(results4, results4,dt(4), t_end);
        ApproxErrors = [ApproxErrors1 ApproxErrors2 ApproxErrors3 ApproxErrors4];

        for i = 1:length(dt)
            fprintf('%s error for dt = %f:    %f \n', methodName,dt(i),  Errors(i)); %Error            
            fprintf('%s approximate error for dt = %f:    %f \n', methodName, dt(i), ApproxErrors(i));
        end
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
    [EulerError,EulerErRedFac,EulerApproxError ]= processMethod('Euler', @euler);    
    [HeunError, HeunErRedFac,HeunApproxError]= processMethod('Heun', @heun);
    [RK4Error, RK4ErRedFac,RK4ApproxError]= processMethod('Runge Kutta 4', @rk4);
    ErrorMatrix = [EulerError; HeunError; RK4Error];
    ApproxErrorMatrix = [EulerApproxError; HeunApproxError; RK4ApproxError];
    ErRedFacMatix = [EulerErRedFac; HeunErRedFac; RK4ErRedFac];
end
