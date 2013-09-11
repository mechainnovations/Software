% Digger Hydraluc ram stuff


% Setup the channel to be used. (GLOBAL VARIABLE)
canChan = canChannel('Kvaser', 'Memorator Professional 1', 1);

% Configure the bus speed to 250kBps
configBusSpeed(canChan,250e3);

% Clear the channel and begin communications
stop(canChan);
start(canChan)
pause(1);  % Wait 1 second

II = 0;
% Turn all RAMS off
while II < 400
    transmitRams2CAN(canChan,'bucket', 200, 'true');
    II = II + 1;
end

msg = receive(canChan,Inf);
msg = receive(canChan,Inf);
size(msg)