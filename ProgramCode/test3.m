function [CB_new, CB, DE_new, DE] = getRamExt2( dTheta, dR, dZ, I)
% Function to get the current and desired ram extensions
I_des = [I(1), I(2)];

[dtheta1, dtheta2] = calcAnglesFromPosition(I_des,[dR, dZ]);

% Get the positions of desired/current
[C_cur,D_cur,E_cur,F_cur,I_cur] = calcPositionFromAngles(ctheta1,ctheta2);
[C_des,D_des,E_des,F_des,I_des] = calcPositionFromAngles(dtheta1,dtheta2);

% Get the RAM extensions
[CB_new, DERam_cur]    = calcRamExtension([0 0],C_cur,D_cur,E_cur);
[ACRam_des, DERam_des] = calcRamExtension([0 0],C_des,D_des,E_des);

while 1
    
    % Controller
    axes1 = read(joy);
    if abs(axes1(1)) > 0.1
        dR  = axes1(1)/5;
    else
        dR = 0;
    end

    if abs(axes1(2)) > 0.1
        dZ = axes1(2)/-5;
    else
        dZ = 0;
    end


[dtheta1, dtheta2] = calcAnglesFromPosition(I_des,[dR, dZ]);

% Get the positions of desired/current
[C_cur,D_cur,E_cur,F_cur,I_cur] = calcPositionFromAngles(ctheta1,ctheta2);
[C_des,D_des,E_des,F_des,I_des] = calcPositionFromAngles(dtheta1,dtheta2);

% Get the RAM extensions
[ACRam_cur, DERam_cur]    = calcRamExtension([0 0],C_cur,D_cur,E_cur);
[ACRam_des, DERam_des]    = calcRamExtension([0 0],C_des,D_des,E_des);

    % Calculate Ram Gain
    [a, b, c] = getPIDRam( [ACRam_cur, DERam_cur, 0],...
        [ACRam_des, DERam_des, 0],[1 1 1], [1 1 1], [1 1 1] );
    
    % Plot Wanted position
    delete(h1);
    h1 = subplot(1,2,1);
    plot([0        D_cur(1)], [0        D_cur(2)], '-ob'); hold on;  %AD
    plot([C_cur(1) F_cur(1)], [C_cur(2) F_cur(2)], '-ob'); hold on;  %CF
    plot([C_cur(1) D_cur(1)], [C_cur(2) D_cur(2)], '-ob'); hold on;  %CD
    plot([D_cur(1) F_cur(1)], [D_cur(2) F_cur(2)], '-ob'); hold on;  %DF
    plot([F_cur(1) E_cur(1)], [F_cur(2) E_cur(2)], '-og'); hold on;  %FE
    plot([F_cur(1) I_cur(1)], [F_cur(2) I_cur(2)], '-og'); hold on;  %FI
    plot([D_cur(1) E_cur(1)], [D_cur(2) E_cur(2)], '-or'); hold on;  %DE
    plot([0.5      C_cur(1)], [-0.3     C_cur(2)], '-or'); hold on;  %BC
    plot([0        C_cur(1)], [0        C_cur(2)], '-ob'); hold on;  %AC
    plot([E_cur(1) I_cur(1)], [E_cur(2) I_cur(2)], '-og'); hold on;  %EI
    plot([I_cur(1)], [I_cur(2)], 'sk '); hold on;                    %I
    axis([-1 8 -5 5]);
    title('Current Digger');

    % Plot Actual Position
    delete(h2);
    h2 = subplot(1,2,2);
    plot([0        D_des(1)], [0        D_des(2)], '-ob'); hold on;  %AD
    plot([C_des(1) F_des(1)], [C_des(2) F_des(2)], '-ob'); hold on;  %CF
    plot([C_des(1) D_des(1)], [C_des(2) D_des(2)], '-ob'); hold on;  %CD
    plot([D_des(1) F_des(1)], [D_des(2) F_des(2)], '-ob'); hold on;  %DF
    plot([F_des(1) E_des(1)], [F_des(2) E_des(2)], '-og'); hold on;  %FE
    plot([F_des(1) I_des(1)], [F_des(2) I_des(2)], '-og'); hold on;  %FI
    plot([D_des(1) E_des(1)], [D_des(2) E_des(2)], '-or'); hold on;  %DE
    plot([0.5      C_des(1)], [-0.3     C_des(2)], '-or'); hold on;  %BC
    plot([0        C_des(1)], [0        C_des(2)], '-ob'); hold on;  %AC
    plot([E_des(1) I_des(1)], [E_des(2) I_des(2)], '-og'); hold on;  %EI
    plot([I_des(1)], [I_des(2)], 'sk '); hold on;                    %I
    axis([-1 8 -5 5]);
    title('Desired Digger');

    clc;
    drawnow;
    disp(['Ram Current 1: ' num2str(ACRam_cur)]);
    disp(['Ram Current 2: ' num2str(DERam_cur)]);
    disp(['Ram Desired 1: ' num2str(ACRam_des)]);
    disp(['Ram Desired 2: ' num2str(DERam_des)]);
    disp('...');
    disp(['Ram 1 Value: ' num2str(a)]);
    disp(['Ram 2 Value: ' num2str(b)]);
    disp('...');
    disp(['Theta 1: ' num2str(dtheta1)]);
    disp(['Theta 2: ' num2str(dtheta2)]);
   	disp('...');
    disp(['Radius : ' num2str(radius_cur)]);
    disp(['zHeight: ' num2str(zHeight_cur)]);
    
    
    pause(0.01);
end