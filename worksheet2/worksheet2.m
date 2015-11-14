function main()

% Initial values
y = @analitical;
func = @equation;
df = @derivative;
y0 = 20;
t_end = 5;
dt = [1 .5 .25 .125 .0625 .03125 .015625];

% number of nodes = number of intervals + 1
t1 = linspace(0, t_end, t_end / dt(1) + 1);
t2 = linspace(0, t_end, t_end / dt(2) + 1);
t3 = linspace(0, t_end, t_end / dt(3) + 1);
t4 = linspace(0, t_end, t_end / dt(4) + 1);
t5 = linspace(0, t_end, t_end / dt(5) + 1);
t6 = linspace(0, t_end, t_end / dt(6) + 1);
t7 = linspace(0, t_end, t_end / dt(7) + 1);

% Exact solution
t = linspace(0, t_end, 1000);
p = y(t);
p2 = y(t2);
p3 = y(t3);
p4 = y(t4);
p5 = y(t5);
p6 = y(t6);
p7 = y(t7);

    function processExplicitMethod (methodName, method)
        results1 = method(func, y0, dt(1), t_end);
        results2 = method(func, y0, dt(2), t_end);
        results3 = method(func, y0, dt(3), t_end);
        results4 = method(func, y0, dt(4), t_end);
        results5 = method(func, y0, dt(5), t_end);
        results6 = method(func, y0, dt(6), t_end);
        
        % plots the solutions in one graph with the exact solution
        figure('Name', methodName, 'NumberTitle', 'off');
        hold on; % don't overwrite previous plots
        
        % exact solution
        plot(t, p);
        
        plot(t1, results1);
        plot(t2, results2);
        plot(t3, results3);
        plot(t4, results4);
        plot(t5, results5);
        plot(t6, results6);
        
        ylim([0 20])
        legend('analytical', 'dt = 1', 'dt = 1/2', 'dt = 1/4', 'dt = 1/8', 'dt = 1/16', 'dt = 1/32', 'Location', 'northeast');
        xlabel('time step t');
        ylabel('solution');
        title(methodName);
        
        hold off;
        shg;
    end

    function processImplicitMethod(methodName, method)
        % Process implicit method
        
        % count the solutions for different time steps
        results2 = method(func, df, y0, dt(2), t_end);
        results3 = method(func, df, y0, dt(3), t_end);
        results4 = method(func, df, y0, dt(4), t_end);
        results5 = method(func, df, y0, dt(5), t_end);
        results6 = method(func, df, y0, dt(6), t_end);
        results7 = method(func, df, y0, dt(7), t_end);
 
        % plots the solutions in one graph with the exact solution
        figure('Name', methodName, 'NumberTitle', 'off');
        hold on; % don't overwrite previous plots
        
        % exact solution
        plot(t, p);
        
        plot(t2, results2);
        plot(t3, results3);
        plot(t4, results4);
        plot(t5, results5);
        plot(t6, results6);
        
        ylim([0 20])
        legend('analytical', 'dt = 1/2', 'dt = 1/4', 'dt = 1/8', 'dt = 1/16', 'dt = 1/32', 'Location', 'northeast');
        xlabel('time step t');
        ylabel('solution');
        title(methodName);
        
        hold off;
        shg;
        
        % Error using exact (analytical) solution
        Error2 = Error(results2, p2, dt(2));
        Error3 = Error(results3, p3, dt(3));
        Error4 = Error(results4, p4, dt(4));
        Error5 = Error(results5, p5, dt(5));
        Error6 = Error(results6, p6, dt(6));
        Error7 = Error(results7, p7, dt(7));
        
        ErRedFact2 = Error2 / Error3;
        ErRedFact3 = Error3 / Error4;
        ErRedFact4 = Error4 / Error5;
        ErRedFact5 = Error5 / Error6;
        ErRedFact6 = Error6 / Error7;
        
        % Result table
        column2 = [dt(2); Error2; ErRedFact2];
        column3 = [dt(3); Error3; ErRedFact3];
        column4 = [dt(4); Error4; ErRedFact4];
        column5 = [dt(5); Error5; ErRedFact5];
        column6 = [dt(6); Error6; ErRedFact6];

        fprintf('%s method', methodName)
        table(column2, column3, column4, column5, column6, 'RowNames', {'dt'; 'error'; 'error red. factor'})

    end

processExplicitMethod('Euler', @euler);

processImplicitMethod('Implicit Euler', @iEuler);
processImplicitMethod('Adams-Moulton', @iAdams);
processImplicitMethod('Adams-Voulton Lineriazation 1', @iAdams_lin1);
processImplicitMethod('Adams-Moulton Lineriazation 2', @iAdams_lin2);
end