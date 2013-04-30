%joystick controller test

clear
clc
joy = vrjoystick(1);

c = caps(joy)
buttonassign = char('trig', 't2', 't3', 't4', 't5', 'b6', 'b7', 'b8', 'b9', 'b10', 'b11');
joystickaxis = char('x_axis', 'y_axis', 'z_axis');

buttonpress = zeros(1,11);
axispress = zeros(1,3);
axisdirection = 0;

%Loop with a number of iterations to collect data
while(1)
    [axes, buttons] = read(joy); % read controller input
    % rcognise button presses
    for j = (1:11)
        if (buttons(j))
            buttonpress(j) = 1;
        end
        if (buttonpress(j) && ~buttons(j))
            buttonpress(j) = 0;
            clc;
            fprintf(' %s is pressed \n',buttonassign(j,:));
        end
    end
    
    axisvalue1 = 0;
    axisvalue2 = 0;
    axisvalue3 = 0;
    axisdirection1 = 0;
    axisdirection2 = 0;
    axisdirection3 = 0;
    
    %Joystick and scroll movements
    if (abs(axes(1)) >0.05)|(abs(axes(2)) >0.05)|(abs(axes(3)) >0.05)
        axisvalue1 = axes(1);
        axisvalue2 = -axes(2);
        axisvalue3 = -axes(3);
        
        if (axisvalue1>0)
            axisdirection1 = 'right';
        else
            axisdirection1 = 'left';
        end
        
        if (axisvalue2<0)
            axisdirection2 = 'down';
        else
            axisdirection2 = 'up';
        end
        
        if (axisvalue3>0)
            axisdirection3 = 'scroll up';
        else
            axisdirection3 = 'scoll down';
        end
        
        fprintf('%s was moved %f (%s) \n',joystickaxis(1,:), axisvalue1,axisdirection1);
        fprintf('%s was moved %f (%s) \n',joystickaxis(2,:), axisvalue2,axisdirection2);
        fprintf('%s was moved %f (%s) \n',joystickaxis(3,:), axisvalue3,axisdirection3);

        t = timer('Period',2.0);
        clc;
        wait(t);
    end
end
close(joy);