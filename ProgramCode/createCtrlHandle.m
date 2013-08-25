function [ ctrlHandle ] = createCtrlHandle( k_p, k_d, k_i, maxE, maxWindUp, offset )
% Create a PID controller Handle

ctrlHandle = struct();

ctrlHandle.Gains.Kp = k_p;   % Proportional Gain
ctrlHandle.Gains.Kd = k_d;   % Derivative Gain
ctrlHandle.Gains.Ki = k_i;   % Integral Gain

ctrlHandle.Contrib.P = 0; % Proportional Contribution
ctrlHandle.Contrib.I = 0; % Proportional Contribution
ctrlHandle.Contrib.D = 0; % Proportional Contribution
 
ctrlHandle.SP = 0;   % Set Point
ctrlHandle.CV = 0;   % Current Value

ctrlHandle.PE = 0;   % Previous Error
ctrlHandle.CE = 0;   % Current Error

ctrlHandle.IntE = 0; % Integral summing error
ctrlHandle.PID  = 0; % PID value

ctrlHandle.T      = cputime;   % Previous time the PID was run
ctrlHandle.MAX    = maxE;      % Max return values
ctrlHandle.Windup = maxWindUp; % Integral windup maximum

ctrlHandle.Offset = offset;   % Offset for the PID controller

end

