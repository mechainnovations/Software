function [ ctrlHandle, returnValue ] = calcPID( ctrlHandle )
% Calculates the new PID value and returns the new struct containing the
% new information about the controller.

% Gains for Each gain
kp = ctrlHandle.Gains.Kp(1);
kd = ctrlHandle.Gains.Kd(1);
ki = ctrlHandle.Gains.Ki(1);

% PID Control 
dt               = cputime - ctrlHandle.T(1); % Delta Time Step
ctrlHandle.T(1)  = cputime;

% Error
ctrlHandle.CE(1) = ctrlHandle.SP(1) - ctrlHandle.CV(1);

ctrlHandle.IntE(1)   = ctrlHandle.IntE(1)  + ctrlHandle.CE(1) ;

if ctrlHandle.IntE(1)  > ctrlHandle.Windup(1) 
    ctrlHandle.IntE(1)  = ctrlHandle.Windup(1) ;
elseif ctrlHandle.IntE(1)  < -ctrlHandle.Windup(1) 
    ctrlHandle.IntE(1)  = -ctrlHandle.Windup(1) ;
end


% Derivative Error
dError  = (ctrlHandle.CE(1)   - ctrlHandle.PE(1));
ctrlHandle.PE(1) = ctrlHandle.CE(1);

% P Gains
ctrlHandle.Contrib.P(1) = kp * ctrlHandle.CE(1);

% I Gain
ctrlHandle.Contrib.I(1) = ki * ctrlHandle.IntE(1);

% D Gain
ctrlHandle.Contrib.D(1) = kd * dError ;

if dt < 0.001
    dt = 0.001;
end

% Add together the gains ensuring there are no NAN

if ~isnan(ctrlHandle.Contrib.P(1))
    ctrlHandle.PID(1) = ctrlHandle.PID(1) + ctrlHandle.Contrib.P(1);
end

if ~isnan(ctrlHandle.Contrib.I)
    ctrlHandle.PID(1) = ctrlHandle.PID(1) - ctrlHandle.Contrib.I(1);
end

if ~isnan(ctrlHandle.Contrib.D)
    ctrlHandle.PID(1) = ctrlHandle.PID(1) + ctrlHandle.Contrib.D(1);
end
% Need to limit the values to the maximum ram value;

% Limit the boom ram
if ctrlHandle.PID(1) > ctrlHandle.MAX(1)
    ctrlHandle.PID(1) = ctrlHandle.MAX(1);
elseif ctrlHandle.PID(1) < -ctrlHandle.MAX(1)
    ctrlHandle.PID(1) = -ctrlHandle.MAX(1);
end

% Value to be returned
returnValue = ctrlHandle.PID(1);

end

