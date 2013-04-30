%xbox_controller_test.m
%Xbox controller test script
%Tony Booth
clear
clc
joy = vrjoystick(1);
%buttons = button(joy, [1,2,3,4,5,6,7,8,9,10]);

c = caps(joy);
buttonassign = char('A', 'B', 'X', 'Y', 'LB', 'RB', 'BACK', 'START', 'LJOYSTICK', 'RJOYSTICK');
joystickaxis = char('LJoystick x-axis', 'LJoystick y-axis','Z trigger','RJoystick x-axis','RJoystick y-axis');
buttonpress = zeros(1,10);
dpadpress = 0;
axispress = zeros(1,5);

%Loop with a number of iterations to collect data
while(1)
    [axes, buttons, povs] = read(joy); % read controller input
    
    % count button presses
    for j = (1:10)
        if (buttons(j))
            buttonpress(j) = 1;
        end
        if (buttonpress(j) && ~buttons(j))
            buttonpress(j) = 0;
            clc;
            fprintf(' %s is pressed \n',buttonassign(j,:));
        end
    end
    
    % print pov direction
    if (povs ~=-1)
        dpadpress = 1;
        direction = povs;
    end
    if (dpadpress && povs == -1)
        dpadpress = 0;
        clc;
        fprintf('d-pad was pressed at %f degrees\n',direction);
    end
    
    %Joystick and trigger movements
    for k = (1:5)
        if (abs(axes(k)) >0.005)
%             axispress(k) = 1;
            axisvalue = axes(k);
%         end
%         if (axispress(k) && abs(axes(k)) < 0.005)
%             axispress(k) = 0;
            
            if (k == 3)
               if (axisvalue>0)
                   axisdirection = 'left trigger';
               else
                   axisdirection = 'right trigger';
               end
            elseif(k == 1 || k == 4)
                if (axisvalue>0)
                    axisdirection = 'right';
                else
                    axisdirection = 'left';
                end
            else
                if (axisvalue>0)
                    axisdirection = 'down';
                else
                    axisdirection = 'up';
                end
            end
            t = timer('Period',2.0);
            clc;
            fprintf('%s was moved %f (%s) \n',joystickaxis(k,:), axisvalue,axisdirection);
            wait(t);
        end
    end

end
close(joy);