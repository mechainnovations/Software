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
h2 = plot(t,val1,'c'); hold on;
h3 = plot(t,val2,'g');
h4 = plot(t,val3,'b');
h5 = plot(t,val4,'k'); hold off;
JJ = 0;
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
    
    
    [a b c] = getPIDRam([Dram1, Dram2, 0], [Cram1, Cram2, 0],[20,5,0],...
        [0.9,1,1],[1,1,1]);
    
    Cram1 = Cram1 + a/75;
    Cram2 = Cram2 + b/75;
    
    

    

    JJ = JJ+1;
%     if JJ > 30
%         JJ = 0;
%         Cram1 = Cram1 + 10;
%         Cram2 = Cram2 + 10;
%         pause(0.2)
%     end
    val1(i) = Cram1;
    val2(i) = Cram2;
    val3(i) = Dram1;
    val4(i) = Dram2;
    i = i + 1;
    if i > 1000
        i = 1;
    end
    tic
    set(h2,'XData',t,'YData',val1);
    set(h3,'XData',t,'YData',val2);
    set(h4,'XData',t,'YData',val3);
    set(h5,'XData',t,'YData',val4);
    axis([0 1000, -125 125]);
    drawnow;
    r2 = toc;
    clc;
    
    disp(['Hz: ' num2str(r2)]);
    disp(['Dram2: ' num2str(Dram2)]);
    disp(['Cram1: ' num2str(Cram1)]);
    disp(['Dram1: ' num2str(Dram1)]);
    disp(['Cram2: ' num2str(Cram2)]);

end