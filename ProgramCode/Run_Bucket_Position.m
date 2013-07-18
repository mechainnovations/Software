clc
clear


while 1  % Check    
    % Read CAN and calculate initial bucket position
    
    I = Calc_PositionI(CAN_theta1, CAN_theta2); 
    
    % Run controller program
    
    % Convert controller inputs to bucket displacements
    
    x_vel = 0.2;
    y_vel = 0.2;
    z_vel = 0.2;
    dt = 0.5;
    
    [x,y,z] = Controller_Input(x_vel, y_vel, z_vel, dt);
    
    % Calculate new angles and ram extensions 
    
    I = [6.8,-1.530,0];
    x = -3;
    y = 2;
    z = 0;
    
    [theta1, theta2, I, F, E, D, CB, DE] = Bucket_Position(0, 0, 0, I);
    
    [theta1_new, theta2_new, I_new, F_new, E_new, D_new, CB_new, DE_new] = Bucket_Position(x, y, z, I);
    
    Boom_Ram = CB_new - CB;
    Stick_Ram = DE_new - DE;
    
    Boom_Ram_vel = Boom_Ram/dt;
    Stick_Ram_vel = Stick_Ram/dt;
    
    % Input into state space
    
    
    
    
    
    
    
    pause(dt)
end
    
    
    
    
    
