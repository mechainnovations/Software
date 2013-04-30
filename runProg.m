
% General setup stuff for MATLAB such as the plot etc.
clc;
clf;
close;
figure('doublebuffer','on', ...
       'CurrentCharacter','a', ...
       'WindowStyle','modal')
axis equal;
title('A Digger!')
hold on
axis([0 20 -15 15]); % Constant axis

% Run the setup Script to do the intilisation
setup();

% Wait to ensure everything ok
pause(0.5);

% Main loop
while (double(get(gcf,'CurrentCharacter'))~=27)
  runCalcs;
  redraw;
  joystickControl;
end