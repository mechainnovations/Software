function [ ctrlHandle, returnValue ] = calcPID( ctrlHandle, I_cur )
% Calculates the new PID value and returns the new struct containing the
% new information about the controller.

% ctrlHandle = controller handle containing setpoint information
% I_cur      = so the gains can be adaptive


% Check to see if we use Extend/Retract gains
dedt = ctrlHandle.SP(1) - ctrlHandle.PSP(1);

if dedt > 0
    kp = ctrlHandle.RGains.kp;
    kd = ctrlHandle.RGains.kd;
    ki = ctrlHandle.RGains.ki;
else
    kp = ctrlHandle.EGains.kp;
    kd = ctrlHandle.EGains.kd;
    ki = ctrlHandle.EGains.ki;
end
    

% PID Control 
dt               = cputime - ctrlHandle.T(1); % Delta Time Step
ctrlHandle.T(1)  = cputime;

% Error
ctrlHandle.CE(1)     = ctrlHandle.SP(1)    - ctrlHandle.CV(1);

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
ctrlHandle.Contrib.I(1) = ki * ctrlHandle.IntE(1) * dt;

% D Gain
ctrlHandle.Contrib.D(1) = kd * dError / dt;

% If gradient has changed reset errors
if dedt ~= ctrlHandle.prevdedt
    dError = 0;
    ctrlHandle.IntE = 0;
end

if dt < 0.001
    dt = 0.001;
end

% Add together the gains ensuring there are no NAN
ctrlHandle.PID(1) = 0;


if ~isnan(ctrlHandle.Contrib.P(1))
    ctrlHandle.PID(1) = ctrlHandle.PID(1) + ctrlHandle.Contrib.P(1);
end

if ~isnan(ctrlHandle.Contrib.I)
    ctrlHandle.PID(1) = ctrlHandle.PID(1) + ctrlHandle.Contrib.I(1);
end

if ~isnan(ctrlHandle.Contrib.D)
    ctrlHandle.PID(1) = ctrlHandle.PID(1) - ctrlHandle.Contrib.D(1);
end

% Need to check to ensure that we actually only offset if we have something
% to move.
if dedt > 0
    ctrlHandle.PID(1) = ctrlHandle.PID(1) + ctrlHandle.Offset(1);
    if abs(ctrlHandle.MIN(1)) > abs(ctrlHandle.PID(1))
        ctrlHandle.PID(1) = ctrlHandle.MIN(1);
    end
else
    ctrlHandle.PID(1) = ctrlHandle.PID(1) - ctrlHandle.Offset(1);
    if abs(ctrlHandle.MIN(1)) > abs(ctrlHandle.PID(1))
        ctrlHandle.PID(1) = -ctrlHandle.MIN(1);
    end
end

% % Add the offset
% ctrlHandle.PID(1) = ctrlHandle.PID(1) + ...
%     sign(ctrlHandle.PID(1))*ctrlHandle.Offset(1);
% Need to limit the values to the maximum ram value;

% Limit the boom ram
if ctrlHandle.PID(1) > ctrlHandle.MAX(1)
    ctrlHandle.PID(1) = ctrlHandle.MAX(1);
elseif ctrlHandle.PID(1) < -ctrlHandle.MAX(1)
    ctrlHandle.PID(1) = -ctrlHandle.MAX(1);
end

% Set the Previous set Points
ctrlHandle.PSP(1) = ctrlHandle.SP(1); 

% Value to be returned
returnValue = ctrlHandle.PID(1);

% Set previous gradient to current gradient
ctrlHandle.prevdedt = dedt;

end

