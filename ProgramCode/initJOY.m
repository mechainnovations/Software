function [ joyID ] = initJOY( original )
% Initialise the joystick

joyID(1) = vrjoystick(1);
testing = 0;
if original == 1
    joyID(2) = vrjoystick(2);
end

end

