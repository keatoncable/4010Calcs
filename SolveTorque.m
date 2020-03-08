function [Fw,N,Torque] = SolveTorque(Cr,Lbs,a,ThetaR,D,vf,surfacearea)
mt=Lbs*0.453592; %mass in kg
Load=mt*9.807; %weight in newtons
r=(D/2)*0.0254; %meters

%Drag Force
CD=2.1; %drag coefficient for a box
rho=1.225; %density of air at STP [kg/m^3]
Fd=0.5*rho*vf^2*CD*surfacearea;


A=[1,-Cr;0,1]; 
B=[mt*a+Load*sin(ThetaR)+Fd;Load*cos(ThetaR)];
C=A\B; % normalforce and torque (Nm)
Fw=C(1);
N=C(2);
Torque=C(1)*r;
end

