close all;
clear all;
clc;

initCAN();
initVARS();

JJ = 1;

for III = 210:5:235


    % Read angles from CAN
    getAngles(  );
    %ctheta1 = 180+boomAngle + 7.9124 + 29.2404;
    ctheta1 = boomAngle-218.22+360+29.24+7.9124;
    ctheta2 = stickAngle;
    ctheta3 = 180+bucketAngle;
    ctheta4 = slewAngle;


    % Calculate the current
    [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
        calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
    prevPointBC = norm([0.68 -.408] - C_cur);
    prevPointDE = norm(D_cur - E_cur);
    
    tic;
    while toc < 1 
        transmitRams2CAN(canChan,'boom',III,'false');
    end
    transmitRams2CAN(canChan,'boom',0,'false');
    pause(2);
    getAngles();
        ctheta1 = boomAngle-218.22+360+29.24+7.9124;
    ctheta2 = stickAngle;
    ctheta3 = 180+bucketAngle;
    ctheta4 = slewAngle;
        % Calculate the current
    [C_cur,D_cur,E_cur,F_cur,I_cur,H_cur,G_cur,J_cur,K_cur,L_cur] = ...
        calcPositionFromAngles(ctheta1,ctheta2,ctheta3);
    curPointBC = norm([0.68 -.408] - C_cur);
    curPointDE = norm(D_cur - E_cur);
    dispBC(JJ,:) = [III,norm(curPointBC-prevPointBC)];
    dispDE(JJ,:) = [III,norm(curPointDE-prevPointDE)];
    
    JJ = JJ + 1;
end

figure;
subplot(1,2,1)
plot(dispBC(:,1),dispBC(:,2),'r');
title('Boom');
axis([-Inf Inf 0 0.025]);
subplot(1,2,2)
plot(dispDE(:,1),dispDE(:,2),'g');
title('Stick');
axis([-Inf Inf 0 0.05]);


