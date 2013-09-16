function [ joyID ] = initJOY( original )
% Initialise the joystick

joyID(1) = vrjoystick(1);
testing = 0;
if original
    joyID(2) = vrjoystick(2);
end

end

