function [theta_1, theta_2, I_new, F_new, E_new, D_new, CB_new, DE_new] = Bucket_Position(x, y, z, I)
% Determine the required angle to repostion the bucket based on the
% controller input angle and velocity (currently assumed vel = const.)

% Measured points
a1 = [707.023   297.115 101.394];
c1 = [707.098   298.924 102.275];
d1 = [707.303	299.794	102.293];
e1 = [707.24	301.378	101.695];
f1 = [707.101	301.761	101.137];
g1 = [707.217	302.272	101.36];
h1 = [707.068	303.535	99.961];
i1 = [707.009	303.836	99.753];
j1 = [707.093	303.345	100.486];
k1 = [707.023	303.75	100.149];
l1 = [707.222	301.673	101.516];
m1 = [707.171	302.399	100.735];
n1 = [707.104	303.725	99.838];
b1 = [707.027	297.535	100.954];
a2 = [707.026	297.115	101.392];
c2 = [707.2	    296.909	103.387];
d2 = [707.445	297.201	104.205];
e2 = [707.448	299.179	106.289];
f2 = [707.327	298.967	105.65];
g2 = [707.427	299.464	105.374];
h2 = [707.327	299.138	103.535];
i2 = [707.262	299.151	103.156];
j2 = [707.301	299.367	103.055];
k2 = [707.261	298.921	102.832];
l2 = [707.432	299.22	105.949];
m2 = [707.404	299.035	104.777];
n2 = [707.355	299.179	103.304];
b2 = [707.031	297.539	100.952];

% Fixed Lengths
Len_ac1 = Calc_Len(a1,c1,1);
Len_ac2 = Calc_Len(a2,c2,2);
AC = (Len_ac1+Len_ac2)/2;
Len_cf1 = Calc_Len(c1,f1,1);
Len_cf2 = Calc_Len(c2,f2,2);
CF = (Len_cf1+Len_cf2)/2;
Len_af1 = Calc_Len(a1,f1,1);
Len_af2 = Calc_Len(a2,f2,2);
AF = (Len_af1+Len_af2)/2;
Len_fi1 = Calc_Len(f1,i1,1);
Len_fi2 = Calc_Len(f2,i2,2);
FI = (Len_fi1+Len_fi2)/2;
Len_ab1 = Calc_Len(a1,b1,1);
Len_ab2 = Calc_Len(a2,b2,2);
AB = (Len_ab1+Len_ab2)/2;
Len_ef1 = Calc_Len(e1,f1,1);
Len_ef2 = Calc_Len(e2,f2,2);
EF = (Len_ef1+Len_ef2)/2;
Len_ei1 = Calc_Len(e1,i1,1);
Len_ei2 = Calc_Len(e2,i2,2);
EI = (Len_ei1+Len_ei2)/2;
Len_df1 = Calc_Len(d1,f1,1);
Len_df2 = Calc_Len(d2,f2,2);
DF = (Len_df1+Len_df2)/2;
Len_ad1 = Calc_Len(a1,d1,1);
Len_ad2 = Calc_Len(a2,d2,2);
AD = (Len_ad1+Len_ad2)/2;
Len_cd1 = Calc_Len(c1,d1,1);
Len_cd2 = Calc_Len(c2,d2,2);
CD = (Len_cd1+Len_cd2)/2;

% New I postion and length
Move = [x,y,z];
I_new =  I + Move;
AI_new = sqrt(I_new(1)^2+I_new(2)^2+I_new(3)^2);

% Calculate theta 1
CAF = acosd((CF^2-AF^2-AC^2)/(-2*AF*AC));
IAF_new = acosd((FI^2-AF^2-AI_new^2)/(-2*AF*AI_new));
alpha = atand(I_new(2)/I_new(1));
theta_1 = 90 + alpha + IAF_new + CAF;

% Calculate theta 2
FIA_new = acosd((AF^2-FI^2-AI_new^2)/(-2*FI*AI_new));
new_angle = FIA_new - alpha;
FIE = acosd((EF^2-FI^2-EI^2)/(-2*FI*EI));
theta_2 = 90-((90-(90-new_angle))+FIE);

% New F Position
F_new = I_new;
EFI = acosd((EI^2-EF^2-FI^2)/(-2*EF*FI));
FEI = acosd((FI^2-EF^2-EI^2)/(-2*EF*EI));
F_new(1) = F_new(1)-FI*sind(180-EFI+theta_2-FEI);
F_new(2) = F_new(2)+FI*cosd(180-EFI+theta_2-FEI); 

% New Boom Ram Extension
V_AB = 45;
CAB_new = theta_1 - V_AB;
CB_new = sqrt(AC^2+AB^2-(2*AC*AB*cosd(CAB_new)));

% New E Position
FEI = acosd((FI^2-EF^2-EI^2)/(-2*EF*EI)); 
E_new = F_new;
E_new(1) = E_new(1)-EF*sind(theta_2-FEI);
E_new(2) = E_new(2)+EF*cosd(theta_2-FEI);

% New D Position
ACD = acosd((AD^2-CD^2-AC^2)/(-2*CD*AC));
CDF = acosd((CF^2-CD^2-DF^2)/(-2*CD*DF));
D_new = F_new;
D_new(1) = D_new(1)-DF*sind(CDF+ACD+theta_1-360);
D_new(2) = D_new(2)+DF*cosd(CDF+ACD+theta_1-360);

% New Stick Ram Extension
x_DE = E_new(1)-D_new(1);
y_DE = D_new(2)-E_new(2);
DE_new = sqrt(x_DE^2+y_DE^2);

end

