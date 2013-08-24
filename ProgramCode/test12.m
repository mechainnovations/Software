% Cn=1;
% u=zeros(3840,9)
% for theta1=0:.21:(pi/2)
%     for theta2=0:.21:pi
%         for theta3=0:.1:pi
%             u(Cn,1:3)=[theta1 theta2 theta3];
%             u(Cn,4:5)=[4.65*cos(theta1) 4.65*sin(theta1)];
%             s_ang=pi+theta2+theta1;
%             u(Cn,6:7)=u(Cn,4:5)+4.32*[cos(s_ang) sin(s_ang)];
%             b_ang=s_ang-theta3;
%             u(Cn,8:9)=u(Cn,6:7)+1*[cos(b_ang) sin(b_ang)];
% %             plot([0 u(Cn,[4 6 8])],[0 u(Cn,[5 7 9])]);axis([0 15 -5 10]);drawnow;
%             Cn=Cn+1;
%         end
%     end
% end
% figure
% 
% % XX=interp2(u(:,6),u(:,7),u(:,1),-5:10,0:15)
% 
% surf(u(:,6),u(:,7),u(:,1),'+');hold all
% % plot3(u(:,6),u(:,7),u(:,2),'+');
%  
zz=0;
xx=0;
tt=0;
 
TT=NaN*ones(29,41,63,9);
ttt=0
for Z=-10:.5:10                 % for all feasible z
    zz=zz+1;
    xx=0;
    for X=1:.5:15               % for all feasible x
        xx=xx+1;
        tt=0;
        for theta3=0:0.1:2*pi   % for all feasible bucket angle
            tt=tt+1;
            u=[X,Z]+[cos(theta3),sin(theta3)];          % find the eye
            if norm(u)<8        % if the boom + stick is not being snapped

                th1=acos(norm(u)/2/4)+atan(u(2)/u(1));  % the angle of the boom to achieve the eye
                th2=2*asin(norm(u)/2/4);                % angle between the stick and boom to a achieve the eye
                u(4:5)=4*[cos(th1) sin(th1)];           % position of first joint
                s_ang=pi+th1+th2;                       % angle of the stick
                u(6:7)=u(4:5)+4*[cos(s_ang) sin(s_ang)];% position of the eye
                b_ang=pi+theta3;                        % angle of the bucket
                u(8:9)=u(6:7)+1*[cos(b_ang) sin(b_ang)];% position of the bucket blade
                th3=b_ang-s_ang+pi;                     % angle between the bucket and the stick
                th3=th3-2*pi*floor((th3)/2/pi);         % phase wrapping
                if th3<pi %if th3 is feasible

                    TT(xx,zz,tt,:)=[th1,th2,th3,u(4:9)];% store everthing
                    % plot([0 u([4 6 8])],[0 u([5 7 9])]);axis([-5 15 -10 10]);pause(0.01);drawnow;hold off
                end

            else
                TT(xx,zz,tt,:)=NaN;
            end
        end
    end
end
 
 
%load matlab.mat
 
%define start-finish positions
% z, x, bucketangle - this angle is not th3 but is measured from the ground
% in +ve x to the bucket
U1=[0 6 1.60]';
U2=[0 3 0]';
 
path=[linspace(U1(1),U2(1),100)' linspace(U1(2),U2(2),100)' linspace(U1(3),U2(3),100)'];% discretise it
 
th111=interp3(-10:.5:10,1:.5:15,0:.1:2*pi,squeeze(TT(:,:,:,1)),path(:,1),path(:,2),path(:,3))'; % do some interpolations of the earlier determined relationsships between position and angles
th222=interp3(-10:.5:10,1:.5:15,0:.1:2*pi,squeeze(TT(:,:,:,2)),path(:,1),path(:,2),path(:,3))';
th333=interp3(-10:.5:10,1:.5:15,0:.1:2*pi,squeeze(TT(:,:,:,3)),path(:,1),path(:,2),path(:,3))';
 disp(' jdfgj df')
for t=1:100
    while isnan(th111(t))
        path(t,3)=path(t,3)+0.1;
        th111=interp3(-10:.5:10,1:.5:15,0:.1:2*pi,squeeze(TT(:,:,:,1)),path(:,1),path(:,2),path(:,3))'; % do some interpolations of the earlier determined relationsships between position and angles
    end
    th222=interp3(-10:.5:10,1:.5:15,0:.1:2*pi,squeeze(TT(:,:,:,2)),path(:,1),path(:,2),path(:,3))';
    th333=interp3(-10:.5:10,1:.5:15,0:.1:2*pi,squeeze(TT(:,:,:,3)),path(:,1),path(:,2),path(:,3))';
end
 
 
% prove it works
figure(2)
set(gcf,'position',[100 10 600 900])
for t=1:100
    subplot(2,1,1);plot(1:100,[th111; th222;th333]);legend('th1','th2','th3');hold on;plot([t t t],[th111(t) th222(t) th333(t)],'ok');hold off;;
    u(4:5)=4*[cos(th111(t)) sin(th111(t))];
    s_ang=pi+th111(t)+th222(t);
    u(6:7)=u(4:5)+4*[cos(s_ang) sin(s_ang)];
    b_ang=pi+s_ang+th333(t);
    u(8:9)=u(6:7)+1*[cos(b_ang) sin(b_ang)];
    subplot(2,1,2);plot([0 u([4 6 8])],[0 u([5 7 9])]);axis([-2 9 -2 7]);drawnow;grid on;pause(0.001)
   
end
 
 
 
surf(1:.5:5,-10:.5:10,squeeze(TT(:,:,10,1)))