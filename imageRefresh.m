function [] = imageRefresh(handle, xI, yI )
% Draws A digger

set(handle,'XData',xI)
set(handle,'YData',yI)
drawnow


end

