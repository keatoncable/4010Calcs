function [Fw,N,Torque] = SolveTorque(Cr,Lbs,a,ThetaR,D)
mt=Lbs*0.453592; %mass in kg
Load=mt*9.807; %weight in newtons
r=(D/2)*0.0254; %meters






A=[1,-Cr;0,1];
B=[mt*a+Load*sin(ThetaR);Load*cos(ThetaR)];
C=A\B; %normalforce and torque (Nm)
Fw=C(1);
N=C(2);
Torque=C(1)*r;
end

