clc;
clear;
close all;


JJ = 0;
while JJ < 360
    
    [a] = bucketPoints(JJ, [0 0]);
    plot(a(:,1),a(:,2),'-oc');
    axis([-0.7 0.7 -0.7 0.7]);
    drawnow;
    JJ = JJ +0.5;
end