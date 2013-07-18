% Script to Initialise all of the CAN Information

% Setup the channel to be used. (GLOBAL VARIABLE)
canChan = canChannel('Kvaser', 'Memorator Professional 1', 1);

% Configure the bus speed to 250kBps
configBusSpeed(canChan,250e3);

% Clear the channel and begin communications
stop(canChan);
start(canChan)
pause(1);  % Wait 1 second

% Turn all RAMS off
transmitRams2CAN(canChan,'boom', 0, 'true');
transmitRams2CAN(canChan,'stick', 0, 'true');
transmitRams2CAN(canChan,'bucket', 0, 'true');