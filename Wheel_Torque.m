clear all; clc; format shorteng; format compact; close all;
%ME 4010 Calculations
%% Force Variables
Cr=.0150; %Car tire on asphalt
% Cr=0.3; %Car tire on sand
ThetaD=15; ThetaR=deg2rad(ThetaD);
Lbs=300;%weight in lbs
% mt=Lbs*0.453592; %mass in kg
% Load=mt*9.807; %weight in newtons
width=12; %width of cart in inches
width= width*0.0254; %width from inches to meters
height=12; %height of the bucket in inches
height= height*0.0254; %hieght from inches to meters
surfacearea=width*height; %Surface area of the front of the cart
%% Wheel Variables
D=10; %Wheel diameter inches
r=(D/2)*0.0254; %meters
% mwheel=1; %mass of wheel in kg
% I=mwheel*r^2/2;
%% Speed variables
Vi=0; %mph
Vf=3; %mph
Vi=Vi*0.44704; %m/s
Vf=Vf*0.44704; %m/s
t=5; %time to reach final velocity (s)
a=(Vf-Vi)/t; %m/s^2
alpha=a/r; %radians/s^2
%% Solve general solution
[Fw,N,Torque]=SolveTorque(Cr,Lbs,a,ThetaR,D,Vf,surfacearea);
VaraiblesUsed={'Rolling Coefficient';'Cart load [lbs.]';'Cart acceleration [m/s^2]';'Angle [deg.]';'Wheel diameter [inches]';'Final velocity [mph]'};
VariableValues=[Cr;Lbs;a;ThetaD;D;Vf/0.44704];
Table=table(VaraiblesUsed,VariableValues)
fprintf("\nForce at wheel: %0.0f N\n", Fw)
fprintf("Normal Force: %0.2f N\n", N)
fprintf("Torque: %0.2f Nm\n", Torque)
fprintf("Force at wheel: %0.2f lbf\n\n\n", Fw*0.22480894387096)

%% Solve Load vs. Torque
% X1=linspace(1,Lbs,1000);
% Y1=X1;
% for i=1:length(X1)
%     Lbs=X1(i);
%     [Fw,N,Torque] = SolveTorque(Cr,Lbs,a,ThetaR,D,Vf,surfacearea);
%     Y1(i)=Torque;
% end
% subplot(2,2,1)
% plot(X1,Y1), xlabel('Load [lbs.]'), ylabel('Torque [Nm]')
%% Solve Incline vs Torque
X2=linspace(0,ThetaD,1000);
VMass=[50,100,150,200]; %variations of mass in kg
Y2=zeros([length(VMass) length(X2)]);
for j=1:length(VMass)
    Lbs=VMass(j)/0.453592;
    for i=1:length(X2)
        ThetaR=deg2rad(X2(i));
        [Fw,N,Torque] = SolveTorque(Cr,Lbs,a,ThetaR,D,Vf,surfacearea);
        Y2(j,i)=Torque;
    end
end
% subplot(2,2,2)
plot(X2,Y2), xlabel('Incline [degrees]'), ylabel('Torque [Nm]')
%% Solve Cr vs Torque
% Cr=0.3;
% X3=linspace(0,Cr,1000);
% Y3=X2;
% for i=1:length(X3)
%     Cr=(X3(i));
%     [Fw,N,Torque] = SolveTorque(Cr,Lbs,a,ThetaR,D,Vf,surfacearea);
%     Y3(i)=Torque;
% end
% subplot(2,2,3)
% plot(X3,Y3), xlabel('Coefficient of rolling resistance [-]'), ylabel('Torque [Nm]')