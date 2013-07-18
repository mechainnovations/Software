% Display some information that might be useful

% Name variables
Vradius = I(1);
Vz      = I(2);

%% Draw pictures of the body rotating and the location of the bucket;
% Make a rectangle Points
x        = [-1 1 1 -1 -1];
y        = [2 2 -2 -2 2];
% Rotate Points
xRot     = x*cos(rotAngle) - y*sin(rotAngle);
yRot     = x*sin(rotAngle) + y*cos(rotAngle);

delete(bodyH);
% Plot the Rotating Digger Frame
bodyH = subplot(1,2,2); plot(xRot, yRot, '-og'); axis equal
text(-4.5,-4.5, ['Theta = ' num2str(rotAngle)]);
axis([-5 5 -5 5]);


%% Draw Pictures of the Boom

% Vector of locations for all points on boom
% xCord  = [A B C D E F I] 
boomP  = [0,0;4.65*cosd(boomAngle),4.65*sind(boomAngle)];
stickP = [boomP(2,1),boomP(2,2);Vradius, Vz];
  
% yCord  = [A B C D E F I] 
  yPos   = [0 2 3 2 0 0 0]';
  
delete(armH);
% Plot the Arm of the Digger
armH = subplot(1,2,1); plot(boomP(:,1),boomP(:,2),'-og',stickP(:,1),...
    stickP(:,2),'-or'); axis equal
text(I(1),I(2)-1, ['[' num2str(I(1)) ' ' num2str(I(2)) ']']);
axis([0 10 -5 5]);

% Draw Information to the debugger window
clc;

disp(['Boom Angle   = ' num2str(boomAngle)]); 
disp(['Stick Angle  = ' num2str(stickAngle)]); 
disp(['Bucket Angle = ' num2str(bucketAngle)]);
disp('...'); 
disp(['Boom Ram   = ' num2str(boomRam)]); 
disp(['Stick Ram  = ' num2str(stickRam)]); 
disp(['Bucket Ram = ' num2str(bucketRam)]);
disp('...'); 
disp(['dTheta   = ' num2str(dTheta)]); 
disp(['dRadius  = ' num2str(dRadius)]); 
disp(['dZ       = ' num2str(dZ)]);
disp('...'); 
disp(['BoomCur   = ' num2str(CurBoR)]); 
disp(['StickCur  = ' num2str(CurStR)]); 
disp(['BoomDes   = ' num2str(DesBoR)]); 
disp(['StickDes  = ' num2str(DesStR)]);
disp('...'); 
disp(['r  = ' num2str(I(1))]); 
disp(['Z  = ' num2str(I(2))]); 

