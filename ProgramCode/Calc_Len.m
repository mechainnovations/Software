function [Length] = Calc_Len(Point_1,Point_2,plane)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

Vector = Point_2-Point_1;

if plane == 1
    P1 = [707.222 301.673 101.516];
    P2 = [707.171 302.399 100.735];
    P3 = [707.104 303.725 99.838];
else
    P1 = [707.432	299.22	105.949];
    P2 = [707.404	299.035	104.777];
    P3 = [707.355	299.179	103.304];
end

V1 = P1-P2;
V2 = P2-P3;

Norm = cross(V1,V2);

C = (dot(Vector,Norm)/norm(Vector)^2)*Vector;

Proj = sqrt(Vector.^2-C.^2);

Length = sqrt(Proj(1)^2+Proj(2)^2+Proj(3)^2);

end

