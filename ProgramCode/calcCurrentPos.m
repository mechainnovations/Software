function [I] = calcCurrentPos(CAN_theta1, CAN_theta2)
% Calculates the current position of the bucket

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

% Calculate F Position
CAF = acosd((CF^2-AF^2-AC^2)/(-2*AF*AC));
alpha = CAN_theta1-CAF;
F = [AF*cosd(alpha), AF*sind(alpha), 0];
I = F;

% Calculate I Position
FIE = acosd((EF^2-FI^2-EI^2)/(-2*FI*EI));
alpha2 = CAN_theta2 + FIE;

I(1) = I(1)+FI*sind(alpha2);
I(2) = I(2)-FI*cosd(alpha2);

end

