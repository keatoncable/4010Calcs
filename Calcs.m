clear
clc
close all

m = 136; % kg, mass of cart fully loaded
vomph = 0; %initial velocity
vfmph = 5; % final velocity in mph
vo = vomph*0.44704; %initial velocity in m/s
vf = vfmph*0.44704; %final velocity in m/s
KE = 1/2*m*(vf^2-vo^2);
