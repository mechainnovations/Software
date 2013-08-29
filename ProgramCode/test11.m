<<<<<<< HEAD
prevStep = 0;

joy = vrjoystick(1);


while 1
    axes1 = read(joy);
    % Differentiate to get the velocity
    axes = ( axes1 - prevStep ) ;
    prevStep = axes1;
    
    % Limit the values between -1 and 1;
    for i = 1:length(axes)
        if (axes(i) < -1)
            axes(i) = -1;
        elseif axes(i) > 1
            axes(i) = 1;
        end
    end
    
    % Limit the values between -1 and 1;
    for i = 1:length(axes)
        if (abs(axes(i)) < 0.15)
            axes(i) = 0;
        end
    end
    
    clc;
    for i = 1:length(axes)
        disp(['Axes ' num2str(i) ': ' num2str(axes(i))]);
    end
    
    pause(0.1);
end
=======
% Testing the vector finding code (without limitations)
close all;
clear all;
clc;



% Generate the map
N = 100;
dx = linspace(0 , 10,N);
dy = linspace(-6, 6 ,N);

II = 1;
while II < N+1
    JJ = 1;
    while JJ < N+ 1
        [dtheta1, dtheta2]  = calcAnglesFromPosition([dx(II),dy(JJ)],[0,0]);
        [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2,0);
        BCSurf(II,JJ) = norm([.68,-.408] - Cd);
        DESurf(II,JJ) = norm(Dd - Ed);
        JJ = JJ + 1;
    end
    II = II + 1;
end


desiredX = 6;
desiredY = 6;

currentX = 2.5;
currentY = 1;
N        = 1000;
% Matrix Setup
matrix = [ linspace(currentX,desiredX,N)', linspace(currentY,desiredY,N)'];

%% Path using interp commands
theta1 = interp2(dx,dy,BCSurf,matrix(:,1),matrix(:,2))';


%% Path using Calculate every point
tic;
N = 100;
II = 1;
while II < N+1
    
    [dtheta1, dtheta2]  = calcAnglesFromPosition([matrix(II,1),matrix(II,2)],[0,0]);
    [Cd, Dd, Ed, Fd, Id]  = calcPositionFromAngles(dtheta1, dtheta2,0);
    BC2(II) = norm([.68,-.408] - Cd);
    DE2(II) = norm(Dd - Ed);
    II = II + 1;
    
end

% Truncate the vectors so there are no NaN
% (end point)
[a, b] = find(isnan(BC2),1);
if isempty(a) ~= 0
    temp1 = BC2(1:b);
    temp2 = DE2(1:b);
else
    temp1 = BC2(1:b);
    temp2 = DE2(1:b);
end

[a, b] = find(isnan(temp2),1);
if isempty(a) ~= 0
    finalBC = temp1(1:b);
    finalDE = temp2(1:b);
else
    finalBC = temp1(1:b);
    finalDE = temp2(1:b);
end
toc
figure;
x = 1:length(finalBC);
length(finalDE)
plot(x,[finalBC',finalDE']);
>>>>>>> origin/TL-Tetsing
