% Testing number 2
clear;
clc;
close all;
figure;
h1 = subplot(1,1,1);
joy = vrjoystick(1);
radius  = 3;
zHeight = 2;
while 1
    axes1 = read(joy);
    if abs(axes1(1)) > 0.1
        radius  = radius + axes1(1)/10;
    end
    
    if abs(axes1(2)) > 0.1
        zHeight = zHeight + axes1(2)/-10;
    end
    
    
    [theta1, theta2] = calcAnglesFromPosition([radius,zHeight]);
    
    
    [C,D,E,F,I] = calcPositionFromAngles(theta1,theta2);
    
    
    [ram1, ram2] = calcRamExtension([0 0],C,D,E);
    
    delete(h1);
    h1 = subplot(1,1,1);
    plot([0    D(1)], [0    D(2)], '-ob'); hold on;  %AD
    plot([C(1)    F(1)], [C(2)    F(2)], '-ob'); hold on;  %CF
    plot([C(1)    D(1)], [C(2)    D(2)], '-ob'); hold on;  %CD
    plot([D(1) F(1)], [D(2) F(2)], '-ob'); hold on;  %DF
    plot([F(1) E(1)], [F(2) E(2)], '-og'); hold on;  %FE
    plot([F(1) I(1)], [F(2) I(2)], '-og'); hold on;  %FE
    plot([D(1) E(1)], [D(2) E(2)], '-or'); hold on;  %DE
    plot([0.5 C(1)], [-0.3 C(2)], '-or'); hold on;  %BC
    plot([0 C(1)], [0 C(2)], '-ob'); hold on;  %DE
    plot([I(1)], [I(2)], 'sk '); hold on;                %I
    plot([E(1) I(1)], [E(2) I(2)], '-og'); hold on; %EI
    
    t = 0:0.1:2*pi;
    x1 = 4.6534*cos(t);
    y1 = 4.6534*sin(t);
    
    x2 = 2.4988*cos(t) + radius;
    y2 = 2.4988*sin(t) + zHeight;
    %plot(x1,y1,'c',x2,y2,'k');
    axis([-2 6 -6 6]);
    
    AD = 2.8421;
    AC = 2.0132;
    AF = 4.6534;
    CD = 0.8922;
    CF = 3.0591;
    FI = 2.4988;
    FE = 0.6844;
    EI = 3.1398;
    
    alph7a = acosd((EI^2 - FE^2 - FI^2)/(-2 * FE * FI));
    EI = norm(E-I);
    FE = norm(F-E);
    FI = norm(F-I);
    alph7b = acosd((EI^2 - FE^2 - FI^2)/(-2 * FE * FI));
    
    clc;
    drawnow;
    disp(['Ram 1: ' num2str(ram1)]);
    disp(['Ram 2: ' num2str(ram2)]);
    
    disp(['Theta 1: ' num2str(theta1)]);
    disp(['Theta 2: ' num2str(theta2)]);
    
    disp(['radius: ' num2str(radius)]);
    disp(['zHeight: ' num2str(zHeight)]);
    
    disp(['Alpha7const: ' num2str(alph7a)]);
    disp(['Alpha7vars : ' num2str(alph7b)]);
end