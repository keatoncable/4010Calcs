clear
clc
close all

%% Constant Initialization
g = 9.81; %gravity in m/s^2
m = 136; % kg, mass of cart fully loaded
vo_mph = 0; %initial velocity
vf_mph = 3; % final velocity in mph
vo = vo_mph*0.44704; %initial velocity in m/s
vf = vf_mph*0.44704; %final velocity in m/s
theta = 15; %max slope angle
vfy = vf*sind(theta); %vertical component of velocity
dist_mi = 5; %total distance cart is to travel in miles
dist = dist_mi*1609.34; %total distance cart is to travel in meters
dh = dist*sind(theta); %vertical component of total distance for given slope

%% Energy Calculations
KE = 1/2*m*(vf^2-vo^2); %kinetic energy of cart
PE = m*g*dh; %potential energy of cart
Wnet = KE + PE; %net work
dx = 3; %meters
a = vf^2/(2*dx); %acceleration needed to achieve max speed in dx meters
t = vf/a; %time to reach max speed
KEdot = KE/t; %power needed to achieve max speed
PEdot = m*g*vfy; %power needed to climb slope
dt = dh/vfy; % time it takes to climb slope at max speed in seconds
dt_hr = dt/3600; %time it takes to travel distance in hrs

%% Efficiency Calculations
losses = 0.75; %estimated losses in percent

%% Power Calculations
power_w = (KEdot+PEdot)/losses; %power needed in watts
power = power_w*0.00134102; % power in horsepower

%% Battery Capacity
add_cap = 20*5; %additional capacity for charging 5 phones
capacity = (power_w*dt_hr)+add_cap; %battery capacity needed in kWh

%% Battery Configuration


%% Speed vs Slope

%% Speed vs Power

