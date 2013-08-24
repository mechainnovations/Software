N = 200;

II = 1;
while II < N
    transmitRams2CAN( canChan,'boom', 250, 'true' );
    II = II + 1;
    pause(0.01);
end
clcrams;
II = 1;
while II < N
    transmitRams2CAN( canChan,'stick', 250, 'true' );
    II = II + 1;
    pause(0.01);
end
clcrams;
II = 1;
while II < N
    transmitRams2CAN( canChan,'bucket', 250, 'true' );
    II = II + 1;
    pause(0.01);
end
clcrams;

II = 1;
while II < N
    transmitRams2CAN( canChan,'boom', 250, 'false' );
    II = II + 1;
    pause(0.01);
end
clcrams;
II = 1;
while II < N
    transmitRams2CAN( canChan,'stick', 250, 'false' );
    II = II + 1;
    pause(0.01);
end
clcrams;
II = 1;
while II < N
    transmitRams2CAN( canChan,'bucket', 250, 'false' );
    II = II + 1;
    pause(0.01);
end
clcrams;

II = 1;
while II < N
    transmitRams2CAN( canChan,'bucket', 250, 'true' );
    transmitRams2CAN( canChan,'boom', 250, 'true' );
    transmitRams2CAN( canChan,'boom', 250, 'true' );
    II = II + 1;
    pause(0.01);
end
clcrams;