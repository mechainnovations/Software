% digger angle testing

% Script to Initialise all of the CAN Information


% Setup the channel to be used. (GLOBAL VARIABLE)
canChan = canChannel('Kvaser', 'Memorator Professional 1', 1);

% Configure the bus speed to 250kBps
configBusSpeed(canChan,250e3);

% Clear the channel and begin communications
stop(canChan);
start(canChan)
pause(1);  % Wait 1 second

% II = 1;
% while II < 100
%     transmitRams2CAN( canChan,'stick', 250, 'true' );
%     II = II + 1;
% end
% clcrams;
while 1
    getAngles ( );
    a = 180+((boomAngle));
    b = ((stickAngle));
    c = 180+((bucketAngle));
    %c = -bucketAngle-90;
    clc;
    disp(['Boom Vert: ' num2str(90-a)])
    disp(['Boom Horz: ' num2str(a)])
    disp(['Boom Uncalib: ' num2str(boomAngle)])
    disp('...')
    disp(['Stick Vert: ' num2str(90-b)])
    disp(['Stick Horz: ' num2str(b)])
    disp(['Stick Unclaib: ' num2str(stickAngle)])
    disp('...')
    disp(['Bucket Vert: ' num2str(90-c)])
    disp(['Bucket Horz: ' num2str(c)])
    disp(['Bucket Uncalib: ' num2str(bucketAngle)])
    
    disp('...')
    disp('...')
    disp(['Boom Horz  : ' num2str(a)])
    disp(['Stick Horz : ' num2str(b)])
    disp(['Bucket Horz: ' num2str(c)])
    pause(0.01);
    
end