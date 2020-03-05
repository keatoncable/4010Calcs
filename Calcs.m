clear
clc
close all

%% Constant Initialization
g = 9.81; %gravity in m/s^2
m = 113; % kg, mass of cart fully loaded
vo_mph = 0; %initial velocity
vf_mph = 3; % final velocity in mph
vo = vo_mph*0.44704; %initial velocity in m/s
vf = vf_mph*0.44704; %final velocity in m/s
theta = 7.5; %max slope angle
vfy = vf.*sind(theta); %vertical component of velocity
dist_mi = 5; %total distance cart is to travel in miles
dist = dist_mi.*1609.34; %total distance cart is to travel in meters
dh = dist.*sind(theta); %vertical component of total distance for given slope

%% Energy Calculations
KE = 1/2.*m.*(vf^.2-vo^.2); %kinetic energy of cart
PE = m*g.*dh; %potential energy of cart
Wnet = KE + PE; %net work
dx = 3; %meters
a = vf.^2./(2*dx); %acceleration needed to achieve max speed in dx meters
t = vf./a; %time to reach max speed
KEdot = KE/t; %power needed to achieve max speed
PEdot = m.*g.*vfy; %power needed to climb slope
dt = dh./vfy; % time it takes to climb slope at max speed in seconds
dt_hr = dt./3600; %time it takes to travel distance in hrs

%% Efficiency Calculations
losses = 0.75; %estimated losses in percent
%rolling resistance
%motor

%% Power Calculations
power_w = (KEdot+PEdot)./losses; %power needed in watts
power = power_w.*0.00134102; % power in horsepower

%% Force Analysis


%% Motor Calculations
%voltage
%current
%power
%torque
%rpm
%curvedata

%% Gearbox Design/ Calculations


%% Battery Capacity
add_cap = 20*5; %additional capacity for charging 5 phones
capacity = (power_w.*dt_hr)+add_cap; %battery capacity needed in kWh

%% Battery Configuration
v_motor = 24; %motor voltage
v_batt = 3.6; %battery voltage per cell testing
cap_batt = 5.0; %battery capacity in Ah
req_Ah = capacity./v_motor; %total battery Ah needed
parallel = ceil(req_Ah./cap_batt); %number of cells needed for desired Ah 
series = ceil(v_motor./v_batt); %number of cells needed for desired motor voltage
curr = 14.5; %max curent discharge per cell
max_current  = parallel*curr; % battery pack max discharge current
num_cells = parallel.*series; %number of battery cells needed
batt_weight = 70/1000; %battery weight in kg
tot_weight = num_cells.*batt_weight; %total battery weight
batt_cost = 4.15; %battery cell cost in dollars
tot_cost = num_cells.*batt_cost; %total battery cost

%% Speed vs Slope

%% Speed vs Power

%% Distance Weight Price
mwsto2 = [];
m = 1:1:150;
dist_it = 2:0.5:7.5;
len = length(dist_it);

for j = 1:len
    mwsto1 = [];
    g = 9.81; %gravity in m/s^2
     % kg, mass of cart fully loaded
    vo_mph = 0; %initial velocity
    vf_mph = 3; % final velocity in mph
    vo = vo_mph*0.44704; %initial velocity in m/s
    vf = vf_mph*0.44704; %final velocity in m/s
    theta = 7.5; %max slope angle
    vfy = vf.*sind(theta); %vertical component of velocity
    dist_mi = dist_it(j); %total distance cart is to travel in miles
    dist = dist_mi.*1609.34; %total distance cart is to travel in meters
    dh = dist.*sind(theta); %vertical component of total distance for given slope
    
    %% Energy Calculations
    KE = 1/2.*m.*(vf^.2-vo^.2); %kinetic energy of cart
    PE = m.*g.*dh; %potential energy of cart
    Wnet = KE + PE; %net work
    dx = 3; %meters
    a = vf.^2./(2*dx); %acceleration needed to achieve max speed in dx meters
    t = vf./a; %time to reach max speed
    KEdot = KE/t; %power needed to achieve max speed
    PEdot = m.*g.*vfy; %power needed to climb slope
    dt = dh./vfy; % time it takes to climb slope at max speed in seconds
    dt_hr = dt./3600; %time it takes to travel distance in hrs
    
    %% Efficiency Calculations
    losses = 0.75; %estimated losses in percent
    
    %% Power Calculations
    power_w = (KEdot+PEdot)./losses; %power needed in watts
    power = power_w.*0.00134102; % power in horsepower
    
    %% Battery Capacity
    add_cap = 20*5; %additional capacity for charging 5 phones
    capacity = (power_w.*dt_hr)+add_cap; %battery capacity needed in kWh
    
    %% Battery Configuration
    v_motor = 24; %motor voltage
    v_batt = 3.6; %battery voltage per cell testing
    cap_batt = 5.0; %battery capacity in Ah
    req_Ah = capacity./v_motor; %total battery Ah needed
    parallel = ceil(req_Ah./cap_batt); %number of cells needed for desired Ah
    series = ceil(v_motor./v_batt); %number of cells needed for desired motor voltage
    num_cells = parallel.*series; %number of battery cells needed
    batt_weight = 70/1000; %battery weight in kg
    tot_weight = num_cells.*batt_weight; %total battery weight
    batt_cost = 4.15; %battery cell cost in dollars
    tot_cost = num_cells.*batt_cost; %total battery cost
    mwsto2 = [mwsto2 ; tot_cost];
end

figure
hold on
for i = 1:66
    plot(dist_it,mwsto2(:,i))
end