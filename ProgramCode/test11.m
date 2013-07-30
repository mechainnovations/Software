prevStep = 0;

joy = vrjoystick(1);


while 1
    axes1 = read(joy);
    % Differentiate to get the velocity
    axes = ( axes1 - prevStep ) ;
    prevStep = axes1;
    
    % Limit the values between -1 and 1;
    for i = 1:length(axes)
        if (axes(i) < -1)
            axes(i) = -1;
        elseif axes(i) > 1
            axes(i) = 1;
        end
    end
    
    % Limit the values between -1 and 1;
    for i = 1:length(axes)
        if (abs(axes(i)) < 0.15)
            axes(i) = 0;
        end
    end
    
    clc;
    for i = 1:length(axes)
        disp(['Axes ' num2str(i) ': ' num2str(axes(i))]);
    end
    
    pause(0.1);
end