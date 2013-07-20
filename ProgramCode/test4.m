% Testing the pid testing of the rams to see the tracking of these
clear all;
close all;
clc;
joy = vrjoystick(1);

Cram1 = 0;
Cram2 = 0;


val1 = zeros(1,1000); % CRam 1
val2 = zeros(1,1000); % CRam 2
val3 = zeros(1,1000); % DRam 1
val4 = zeros(1,1000); % DRam 2
t   = 1:1000;
i = 1;

figure;
h1 = subplot(1,1,1);
plot(t,val1,'c'); hold on;
plot(t,val2,'g');
plot(t,val3,'b');
plot(t,val4,'k'); hold off;

while 1
    axes1 = read(joy);
    if abs(axes1(1)) > 0.15
        Dram1 = 100*axes1(1); % Current Ram1
    else
        Dram1 = 0;
    end
    
    if abs(axes1(3)) > 0.15
        Dram2 = 100*axes1(3); % Current Ram1
    else
        Dram2 = 0;
    end
    
    
    [a b c] = getPIDRam([Dram1, Dram2, 0], [Cram1, Cram2, 0],[100,100000,1],...
        [10,500,1],[1,1,1]);
    
    Cram1 = Cram1 + a/100;
    Cram2 = Cram2 + b/100;
    
    

    clc;
    
    disp(['Cram1: ' num2str(Cram1)]);
    disp(['Dram1: ' num2str(Dram1)]);
    disp(['Cram2: ' num2str(Cram2)]);
    disp(['Dram2: ' num2str(Dram2)]);
    val1(i) = Cram1;
    val2(i) = Cram2;
    val3(i) = Dram1;
    val4(i) = Dram2;
    i = i + 1;
    if i > 1000
        i = 1;
    end
    
    delete(h1);
    h1 = subplot(1,1,1);
    plot(t,val1,'c'); hold on;
    plot(t,val2,'g');
    plot(t,val3,'b');
    plot(t,val4,'k'); hold off;
    legend('Cram1','Cram2','Dram1','Dram2');
    axis([0 1000, -125 125]);
        drawnow;
end