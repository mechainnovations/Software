%Xbox_button_count_test.m
%Xbox controller button press count test script
%Tony Booth
clear
clc
joy = vrjoystick(1);
%buttons = button(joy, [1,2,3,4,5,6,7,8,9,10]);


buttonassign = char('A', 'B', 'X', 'Y', 'LB', 'RB', 'BACK', 'START', 'LJOYSTICK', 'RJOYSTICK');
joystickaxis = char('LJoystick x-axis', 'LJoystick y-axis','Z trigger','RJoystick x-axis','RJoystick y-axis');
buttonpress = zeros(1,10);
buttoncount = zeros(1,10);
dpadpress = 0;
axispress = zeros(1,5);

%Loop with a number of iterations to collect data
for i = (1:200000)
    [axes, buttons, povs] = read(joy); % read controller input
    
    % count button presses
    for j = (1:10)
        if (buttons(j))
            buttonpress(j) = 1;
        end
        if (buttonpress(j) && ~buttons(j))
            buttonpress(j) = 0;
            buttoncount(j) = buttoncount(j) + 1;
        end
    end

end

% print button presses for each button
for l = (1:10)
    if (buttoncount(l))
        fprintf(' %s is pressed %i times \n',buttonassign(l,:),buttoncount(l));
    end
end
close(joy);