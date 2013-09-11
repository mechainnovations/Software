% Getting the angles from L_des.
clc;
close all;
clear all;

% IL Length from I -> L
IL = 1.15;

I_des = [3.5 1];
dI = [0.005 0];

ctheta1 = 65;
ctheta2 = -110;
ctheta3 = 44;
ctheta5 = ctheta2 - ctheta3;

[ Cd,Dd,Ed,Fd,Id,Hd,Gd,Jd,Kd,Ld ] = calcPositionFromAngles(ctheta1, ctheta2, ctheta3);

% Generate our move
IL = 1.15;
mov = [0.01 0; 0 0.01;-0.02 0;0 -.01]*1;
L_des = Ld;
dtheta3 = ctheta3;
for IIII = 1:length(mov)
    N = 100;
    for II = 1:N
        L_des = L_des + mov(IIII,:);
        I_des(1) = L_des(1) - IL*cosd(dtheta3 - 105);
        I_des(2) = L_des(2) - IL*sind(dtheta3 - 105);
        [dtheta1, dtheta2] = calcAnglesFromPosition(I_des,[0 0]);
        dtheta3 = dtheta2 - ctheta5;
        [ Cd,Dd,Ed,Fd,Id,Hd,Gd,J,dKd,Ld ] = calcPositionFromAngles(dtheta1, dtheta2, dtheta3);
        setPointBC = norm([.68,-.408] - Cd);
        setPointDE = norm(Dd - Ed);
        
        alph = 15;
        IL2 = 1.35;
        L_des2(1) = I_des(1) + IL2*cosd(dtheta3 - 105 + alph);
        L_des2(2) = I_des(2) + IL2*sind(dtheta3 - 105 + alph);

        ind = ( IIII - 1 ) * N + II;
        pos(ind,1,:) = L_des;
        pos(ind,2,:) = I_des;
        pos(ind,3,:) = L_des2;
        val(ind,1,:) = dtheta3;
        val(ind,2,:) = setPointBC;
        val(ind,3,:) = setPointDE;

    end
end



figure;
hold on;
col = ['g' 'r' 'b' 'k'];
for III = 1:3
    plot(pos(:,III,1),pos(:,III,2),col(III));
end 
hold off;
xlim([0 6]);
axis equal

figure;
hold on;
col = ['g' 'r' 'b' 'k'];
x = 1:length(val(:,1));
for III = 2:3
    plot(x,val(:,III),col(III));
end 
ylim([1.5 3]);
hold off;









