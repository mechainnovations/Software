function[] = test20 ()
% GUI testing stuff
close all
clc

data_structure = selection_gui();   


i = 1;

startTime = cputime;
h1 = plot(0,0);
exit = 0;
while 1
    tic
    data_structure.t(i) = cputime - startTime;
    data_structure.x(i) = i*i + 2;
    data_structure.y(i) = 1/i *3;
    data_structure.ram1(i) = 10 * rand;
    i = i + 1;
    set(h1,'XData',i,'YData',i*i)
    drawnow;
    clc
    disp(i)
    finish = onCleanup(@() exitProgram(data_structure));
    toc
end


end

function[] = exitProgram(data_structure)
    time = clock;
    year = num2str(time(1));
    month = num2str(time(2));
    day = num2str(time(3));
    hour = num2str(time(4));
    minute = num2str(time(5));
    str = [year '.' month '.' day '-' hour '.' minute '-' data_structure.usercode];
    save([str '.mat'],'-struct','data_structure')
end