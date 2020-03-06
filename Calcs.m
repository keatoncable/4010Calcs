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
capacity = (power_w*dt_hr)+add_cap; %battery capacity needed in kWh

%% Battery Configuration
v_motor = 24; %motor voltage
v_batt = 3.6; %battery voltage per cell
cap_batt = 4.2; %battery capacity in Ah
req_Ah = capacity/v_motor; %total battery Ah needed
parallel = ceil(req_Ah/cap_batt); %number of cells needed for desired Ah 
curr = 14.5; % max discharge current per cell
max_current = curr*parallel; %max battery pack discharge
series = ceil(v_motor/v_batt); %number of cells needed for desired motor voltage
num_cells = parallel*series; %number of battery cells needed
batt_weight = 70/1000; %battery weight in kg
tot_weight = num_cells*batt_weight; %total battery weight
batt_cost = 6.37; %battery cell cost in dollars
tot_cost = num_cells*batt_cost; %total battery cost

%% Speed vs Slope

%% Speed vs Power


%% Plots

%distance vs battery capacity
g = 9.81; %gravity in m/s^2
m = [50 100 150 200]; % kg, mass of cart fully loaded
capsto = []; %initialize vector
for i = 1:length(m)
    vo_mph = 0; %initial velocity
    vf_mph = 3; % final velocity in mph
    vo = vo_mph*0.44704; %initial velocity in m/s
    vf = vf_mph*0.44704; %final velocity in m/s
    theta = 7.5; %max slope angle
    vfy = vf*sind(theta); %vertical component of velocity
    dist_mi = 0.1:0.1:7.5; %total distance cart is to travel in miles
    dist = dist_mi.*1609.34; %total distance cart is to travel in meters
    dh = dist.*sind(theta); %vertical component of total distance for given slope
    KE = 1/2*m(i)*(vf^2-vo^2); %kinetic energy of cart
    PE = m(i)*g.*dh; %potential energy of cart
    Wnet = KE + PE; %net work
    dx = 3; %meters
    a = vf^2/(2*dx); %acceleration needed to achieve max speed in dx meters
    t = vf/a; %time to reach max speed
    KEdot = KE/t; %power needed to achieve max speed
    PEdot = m(i)*g*vfy; %power needed to climb slope
    dt = dh./vfy; % time it takes to climb slope at max speed in seconds
    dt_hr = dt./3600; %time it takes to travel distance in hrs
    losses = 0.75; %estimated losses in percent
    power_w = (KEdot+PEdot)./losses; %power needed in watts
    power = power_w.*0.00134102; % power in horsepower
    add_cap = 20*5; %additional capacity for charging 5 phones
    capacity = (power_w*dt_hr)+add_cap; %battery capacity needed in kWh
    capsto = [capsto ; capacity]; %storing capacity on each iteration
end

figure
hold on
plot(dist_mi,capsto(1,:))
plot(dist_mi,capsto(2,:))
plot(dist_mi,capsto(3,:))
plot(dist_mi,capsto(4,:))
plot([5 5],[0 1400],'k-.')
lgd = legend('Mass = 50 kg','Mass = 100 kg','Mass = 150 kg','Mass = 200 kg');
lgd.Location = 'northwest';
title('Cart Distance Rating vs. Battery Capacity Needed')
xlabel('Distance Rating [miles]')
ylabel('Battery Capacity Needed [kWh]')

%cart weight vs power required
g = 9.81; %gravity in m/s^2
theta = [2.5 5 7.5 10 12.5 15]; %max slope angle
psto = [];
for i = 1:length(theta)
    m = 50:1:200; % kg, mass of cart fully loaded
    vo_mph = 0; %initial velocity
    vf_mph = 3; % final velocity in mph
    vo = vo_mph*0.44704; %initial velocity in m/s
    vf = vf_mph*0.44704; %final velocity in m/s
    %theta = 7.5; %max slope angle
    vfy = vf*sind(theta(i)); %vertical component of velocity
    dist_mi = 5; %total distance cart is to travel in miles
    dist = dist_mi*1609.34; %total distance cart is to travel in meters
    dh = dist*sind(theta(i)); %vertical component of total distance for given slope
    KE = 1/2.*m.*(vf^2-vo^2); %kinetic energy of cart
    PE = m.*g.*dh; %potential energy of cart
    Wnet = KE + PE; %net work
    dx = 3; %meters
    a = vf^2/(2*dx); %acceleration needed to achieve max speed in dx meters
    t = vf/a; %time to reach max speed
    KEdot = KE/t; %power needed to achieve max speed
    PEdot = m.*g*vfy; %power needed to climb slope
    dt = dh/vfy; % time it takes to climb slope at max speed in seconds
    dt_hr = dt/3600; %time it takes to travel distance in hrs
    losses = 0.75; %estimated losses in percent
    power_w = (KEdot+PEdot)./losses; %power needed in watts
    power = power_w.*0.00134102; % power in horsepower
    psto = [psto ; power_w]; %storing power vectors on each iteration
end

figure
hold on
plot(m,psto(1,:))
plot(m,psto(2,:))
plot(m,psto(3,:))
plot(m,psto(4,:))
plot(m,psto(5,:))
plot(m,psto(6,:))
plot([113 113],[0 1000],'k-.')
lgd = legend('\theta = 2.5','\theta = 5','\theta = 7.5','\theta = 10','\theta = 12.5','\theta = 15');
lgd.Location = 'northwest';
title('Total Cart Mass vs. Power Required')
xlabel('Total Cart Mass [kg]')
ylabel('Power Needed [W]')


%cart weight vs battery capacity
% g = 9.81; %gravity in m/s^2
% m = 50:1:200; % kg, mass of cart fully loaded
% vo_mph = 0; %initial velocity
% vf_mph = 3; % final velocity in mph
% vo = vo_mph*0.44704; %initial velocity in m/s
% vf = vf_mph*0.44704; %final velocity in m/s
% theta = 7.5; %max slope angle
% vfy = vf*sind(theta); %vertical component of velocity
% dist_mi = 5; %total distance cart is to travel in miles
% dist = dist_mi*1609.34; %total distance cart is to travel in meters
% dh = dist*sind(theta); %vertical component of total distance for given slope
% KE = 1/2.*m.*(vf^2-vo^2); %kinetic energy of cart
% PE = m.*g.*dh; %potential energy of cart
% Wnet = KE + PE; %net work
% dx = 3; %meters
% a = vf^2/(2*dx); %acceleration needed to achieve max speed in dx meters
% t = vf/a; %time to reach max speed
% KEdot = KE/t; %power needed to achieve max speed
% PEdot = m.*g*vfy; %power needed to climb slope
% dt = dh./vfy; % time it takes to climb slope at max speed in seconds
% dt_hr = dt./3600; %time it takes to travel distance in hrs
% losses = 0.75; %estimated losses in percent
% power_w = (KEdot+PEdot)./losses; %power needed in watts
% power = power_w.*0.00134102; % power in horsepower
% add_cap = 20*5; %additional capacity for charging 5 phones
% capacity = (power_w.*dt_hr)+add_cap; %battery capacity needed in kWh
% figure
% plot(m,capacity)
% title('Total Cart Mass vs. Battery Capacity Needed')
% xlabel('Total Cart Mass [kg]')
% ylabel('Battery Capacity Needed [kWh]')

%slope vs battery capacity
g = 9.81; %gravity in m/s^2
m = [50 100 150 200]; % kg, mass of cart fully loaded
capsto = [];
for i = 1:length(m)
    vo_mph = 0; %initial velocity
    vf_mph = 3; % final velocity in mph
    vo = vo_mph*0.44704; %initial velocity in m/s
    vf = vf_mph*0.44704; %final velocity in m/s
    theta = 1:0.1:20; %max slope angle
    vfy = vf.*sind(theta); %vertical component of velocity
    dist_mi = 5; %total distance cart is to travel in miles
    dist = dist_mi*1609.34; %total distance cart is to travel in meters
    dh = dist.*sind(theta); %vertical component of total distance for given slope
    KE = 1/2*m(i)*(vf^2-vo^2); %kinetic energy of cart
    PE = m(i)*g.*dh; %potential energy of cart
    Wnet = KE + PE; %net work
    dx = 3; %meters
    a = vf^2/(2*dx); %acceleration needed to achieve max speed in dx meters
    t = vf/a; %time to reach max speed
    KEdot = KE/t; %power needed to achieve max speed
    PEdot = m(i).*g.*vfy; %power needed to climb slope
    dt = dh./vfy; % time it takes to climb slope at max speed in seconds
    dt_hr = dt./3600; %time it takes to travel distance in hrs
    losses = 0.75; %estimated losses in percent
    power_w = (KEdot+PEdot)./losses; %power needed in watts
    power = power_w.*0.00134102; % power in horsepower
    add_cap = 20*5; %additional capacity for charging 5 phones
    capacity = (power_w.*dt_hr)+add_cap; %battery capacity needed in kWh
    capsto = [capsto ; capacity]; % storing capacities on each iteration
end

figure
hold on
plot(theta,capsto(1,:))
plot(theta,capsto(2,:))
plot(theta,capsto(3,:))
plot(theta,capsto(4,:))
plot([7.5 7.5],[0 2500],'k-.')
lgd = legend('Mass = 50 kg','Mass = 100 kg','Mass = 150 kg','Mass = 200 kg');
lgd.Location = 'northwest';
title('Path Slope vs. Battery Capacity Needed')
xlabel('Path slope [deg]')
ylabel('Battery Capacity Needed [kWh]')

%wheel diameter vs motor speed
d = 2:0.1:12; %wheel diameter in inches
d_m = d.*0.0254; %wheel diameter in meters
circ = 2*pi.*(d./2); %wheel circumference in inches
circ_m = circ.*0.0254; %wheel circumference in meters
vf_mph = 3; %max cart speed in mph
cart_v = vf_mph*0.44704; %max cart speed in m/s
mot_speed = cart_v./circ_m.*60; %motor speed in RPM to reach desired vf
figure
plot(d,mot_speed)
title('Wheel Diameter vs. Effective Motor Speed To Obtain 3 MPH')
xlabel('Wheel Diameter [in]')
ylabel('Effective Motor Speed [RPM]')

%Wheel diamter vs gear reduction
d = [4 6 8 10]; %wheel diameter in inches
d_m = d.*0.0254; %wheel diameter in meters
circ = 2*pi.*(d./2); %wheel circumference in inches
circ_m = circ.*0.0254; %wheel circumference in meters
vf_mph = 3; %max cart speed in mph
cart_v = vf_mph*0.44704; %max cart speed in m/s
mot_speed = cart_v./circ_m.*60; %motor speed in RPM to reach desired vf
speed = 500:1:5000; %possible motor speeds in RPM
grstore = [];

for i = 1:length(mot_speed)
    gr = speed/mot_speed(i);
    grstore = [grstore ; gr];
end

figure
hold on
plot(speed,grstore(1,:))
plot(speed,grstore(2,:))
plot(speed,grstore(3,:))
plot(speed,grstore(4,:))
lgd = legend('D = 4 in.','D = 6 in.','D = 8 in.','D = 10 in.');
lgd.Location = 'northwest';
title('Motor Speed vs. Gear Reduction To Obtain 3 MPH')
xlabel('Motor Speed [RPM]')
ylabel('Gear Reduction [ ]')

%battery capacity vs battery cost
capacity = 100:1:1200; %battery capacity needed in kWh

v_motor = 24; %motor voltage
v_batt = 3.6; %battery voltage per cell
cap_batt = 4.2; %battery capacity in Ah
req_Ah = capacity./v_motor; %total battery Ah needed
parallel = ceil(req_Ah./cap_batt); %number of cells needed for desired Ah 
curr = 14.5; % max discharge current per cell
max_current = curr.*parallel; %max battery pack discharge
series = ceil(v_motor/v_batt); %number of cells needed for desired motor voltage
num_cells = parallel.*series; %number of battery cells needed
batt_weight = 70/1000; %battery weight in kg
tot_weight = num_cells*batt_weight; %total battery weight
batt_cost = 4.15; %battery cell cost in dollars
tot_cost = num_cells*batt_cost; %total battery cost

figure
hold on
plot(capacity,tot_cost)
plot([581 581],[0 400],'k-.')
title('Battery Capacity vs. Total Battery Cost')
xlabel('Battery Capacity [kWh]')
ylabel('Total Battery Cost [$]')

%cart weight vs battery cost
g = 9.81; %gravity in m/s^2
theta = [2.5 5 7.5 10 12.5 15]; %max slope angle
coststo = [];
for i = 1:length(theta)
    m = 50:50:200; % kg, mass of cart fully loaded
    vo_mph = 0; %initial velocity
    vf_mph = 3; % final velocity in mph
    vo = vo_mph*0.44704; %initial velocity in m/s
    vf = vf_mph*0.44704; %final velocity in m/s
    %theta = 7.5; %max slope angle
    vfy = vf*sind(theta(i)); %vertical component of velocity
    dist_mi = 5; %total distance cart is to travel in miles
    dist = dist_mi*1609.34; %total distance cart is to travel in meters
    dh = dist*sind(theta(i)); %vertical component of total distance for given slope
    KE = 1/2.*m.*(vf^2-vo^2); %kinetic energy of cart
    PE = m.*g.*dh; %potential energy of cart
    Wnet = KE + PE; %net work
    dx = 3; %meters
    a = vf^2/(2*dx); %acceleration needed to achieve max speed in dx meters
    t = vf/a; %time to reach max speed
    KEdot = KE/t; %power needed to achieve max speed
    PEdot = m.*g*vfy; %power needed to climb slope
    dt = dh./vfy; % time it takes to climb slope at max speed in seconds
    dt_hr = dt./3600; %time it takes to travel distance in hrs
    losses = 0.75; %estimated losses in percent
    power_w = (KEdot+PEdot)./losses; %power needed in watts
    power = power_w.*0.00134102; % power in horsepower
    add_cap = 20*5; %additional capacity for charging 5 phones
    capacity = (power_w.*dt_hr)+add_cap; %battery capacity needed in kWh
    v_motor = 24; %motor voltage
    v_batt = 3.6; %battery voltage per cell
    cap_batt = 4.2; %battery capacity in Ah
    req_Ah = capacity./v_motor; %total battery Ah needed
    parallel = ceil(req_Ah./cap_batt); %number of cells needed for desired Ah
    curr = 14.5; % max discharge current per cell
    max_current = curr.*parallel; %max battery pack discharge
    series = ceil(v_motor/v_batt); %number of cells needed for desired motor voltage
    num_cells = parallel.*series; %number of battery cells needed
    batt_weight = 70/1000; %battery weight in kg
    tot_weight = num_cells*batt_weight; %total battery weight
    batt_cost = 4.15; %battery cell cost in dollars
    tot_cost = num_cells*batt_cost; %total battery cost
    coststo = [coststo ; tot_cost];
end

figure
hold on
plot(m,coststo(1,:))
plot(m,coststo(2,:))
plot(m,coststo(3,:))
plot(m,coststo(4,:))
plot(m,coststo(5,:))
plot(m,coststo(6,:))
plot([113 113],[0 500],'k-.')
lgd = legend('\theta = 2.5','\theta = 5','\theta = 7.5','\theta = 10','\theta = 12.5','\theta = 15');
lgd.Location = 'northwest';
title('Total Cart Mass vs. Total Battery Cost')
xlabel('Total Cart Mass [kg]')
ylabel('Total Battery Cost [$]')

%slope vs cost
g = 9.81; %gravity in m/s^2
m = [50 100 150 200]; % kg, mass of cart fully loaded
coststo = [];
for i = 1:length(m)
    vo_mph = 0; %initial velocity
    vf_mph = 3; % final velocity in mph
    vo = vo_mph*0.44704; %initial velocity in m/s
    vf = vf_mph*0.44704; %final velocity in m/s
    theta = 1:0.1:15; %max slope angle
    vfy = vf.*sind(theta); %vertical component of velocity
    dist_mi = 5; %total distance cart is to travel in miles
    dist = dist_mi*1609.34; %total distance cart is to travel in meters
    dh = dist.*sind(theta); %vertical component of total distance for given slope
    KE = 1/2*m(i)*(vf^2-vo^2); %kinetic energy of cart
    PE = m(i)*g.*dh; %potential energy of cart
    Wnet = KE + PE; %net work
    dx = 3; %meters
    a = vf^2/(2*dx); %acceleration needed to achieve max speed in dx meters
    t = vf/a; %time to reach max speed
    KEdot = KE/t; %power needed to achieve max speed
    PEdot = m(i).*g.*vfy; %power needed to climb slope
    dt = dh./vfy; % time it takes to climb slope at max speed in seconds
    dt_hr = dt./3600; %time it takes to travel distance in hrs
    losses = 0.75; %estimated losses in percent
    power_w = (KEdot+PEdot)./losses; %power needed in watts
    power = power_w.*0.00134102; % power in horsepower
    add_cap = 20*5; %additional capacity for charging 5 phones
    capacity = (power_w.*dt_hr)+add_cap; %battery capacity needed in kWh
    v_motor = 24; %motor voltage
    v_batt = 3.6; %battery voltage per cell
    cap_batt = 4.2; %battery capacity in Ah
    req_Ah = capacity./v_motor; %total battery Ah needed
    parallel = ceil(req_Ah./cap_batt); %number of cells needed for desired Ah
    curr = 14.5; % max discharge current per cell
    max_current = curr.*parallel; %max battery pack discharge
    series = ceil(v_motor/v_batt); %number of cells needed for desired motor voltage
    num_cells = parallel.*series; %number of battery cells needed
    batt_weight = 70/1000; %battery weight in kg
    tot_weight = num_cells*batt_weight; %total battery weight
    batt_cost = 4.15; %battery cell cost in dollars
    tot_cost = num_cells*batt_cost; %total battery cost
    coststo = [coststo ; tot_cost];
end

figure
hold on
plot(theta,coststo(1,:))
plot(theta,coststo(2,:))
plot(theta,coststo(3,:))
plot(theta,coststo(4,:))
plot([7.5 7.5],[0 500],'k-.')
lgd = legend('Mass = 50 kg','Mass = 100 kg','Mass = 150 kg','Mass = 200 kg');
lgd.Location = 'northwest';
title('Path Slope vs. Total Battery Cost')
xlabel('Path slope [deg]')
ylabel('Total Battery Cost [$]')

%% Battery Pack Dimensions - Capacity Change
capacity = 500:250:1250; %battery capacity needed in kWh
wsto = [];
hsto = [];
for i = 1:length(capacity)
    v_motor = 24; %motor voltage
    v_batt = 3.6; %battery voltage per cell
    cap_batt = 5; %battery capacity in Ah
    req_Ah = capacity(i)/v_motor; %total battery Ah needed
    parallel = ceil(req_Ah/cap_batt); %number of cells needed for desired Ah
    curr = 14.5; % max discharge current per cell
    max_current = curr.*parallel; %max battery pack discharge
    series = ceil(v_motor/v_batt); %number of cells needed for desired motor voltage
    num_cells = parallel.*series; %number of battery cells needed
    batt_weight = 70/1000; %battery weight in kg
    tot_weight = num_cells*batt_weight; %total battery weight
    batt_cost = 4.15; %battery cell cost in dollars
    tot_cost = num_cells*batt_cost; %total battery cost
    width = 21.5/1000; %effective cell width (diameter)
    height = 71/1000; %effective cell height
    pack_width = series*width; %estimated pack width
    pack_height = parallel*height;
    wsto = [wsto ; -pack_width/2 pack_width/2];
    hsto = [hsto ; -pack_height/2 pack_height/2];
end

figure
hold on
plot([wsto(1,1) wsto(1,1)],[hsto(1,1) hsto(1,2)],'k-',[wsto(1,1) wsto(1,2)],[hsto(1,2) hsto(1,2)],'k-',[wsto(1,2) wsto(1,2)],[hsto(1,2) hsto(1,1)],'k-',[wsto(1,2) wsto(1,1)],[hsto(1,1) hsto(1,1)],'k-')
plot([wsto(2,1) wsto(2,1)],[hsto(2,1) hsto(2,2)],'b-',[wsto(2,1) wsto(2,2)],[hsto(2,2) hsto(2,2)],'b-',[wsto(2,2) wsto(2,2)],[hsto(2,2) hsto(2,1)],'b-',[wsto(2,2) wsto(2,1)],[hsto(2,1) hsto(2,1)],'b-')
plot([wsto(3,1) wsto(3,1)],[hsto(3,1) hsto(3,2)],'g-',[wsto(3,1) wsto(3,2)],[hsto(3,2) hsto(3,2)],'g-',[wsto(3,2) wsto(3,2)],[hsto(3,2) hsto(3,1)],'g-',[wsto(3,2) wsto(3,1)],[hsto(3,1) hsto(3,1)],'g-')
plot([wsto(4,1) wsto(4,1)],[hsto(4,1) hsto(4,2)],'r-',[wsto(4,1) wsto(4,2)],[hsto(4,2) hsto(4,2)],'r-',[wsto(4,2) wsto(4,2)],[hsto(4,2) hsto(4,1)],'r-',[wsto(4,2) wsto(4,1)],[hsto(4,1) hsto(4,1)],'r-')
lgd = legend('Cap. = 500 Kwh','Cap. = 750 Kwh','Cap. = 1000 Kwh','Cap. = 1250 Kwh');
lgd.Location = 'northwest';
title('Representative Battery Pack Dimensions')
xlabel('Battery Pack Width Relative To Center [m]')
ylabel('Battery Pack Height Relative To Center [m]')
xlim([-.4 0.4]) 

%% Battery Pack Dimensions - Voltage Change
v_motor = 12:12:48; %motor voltage
wsto = [];
hsto = [];
for i = 1:length(v_motor)
    v_batt = 3.6; %battery voltage per cell
    cap_batt = 5; %battery capacity in Ah
    capacity = 750; %battery capacity needed in kWh
    req_Ah = capacity/v_motor(i); %total battery Ah needed
    parallel = ceil(req_Ah/cap_batt); %number of cells needed for desired Ah
    curr = 14.5; % max discharge current per cell
    max_current = curr.*parallel; %max battery pack discharge
    series = ceil(v_motor(i)/v_batt); %number of cells needed for desired motor voltage
    num_cells = parallel.*series; %number of battery cells needed
    batt_weight = 70/1000; %battery weight in kg
    tot_weight = num_cells*batt_weight; %total battery weight
    batt_cost = 4.15; %battery cell cost in dollars
    tot_cost = num_cells*batt_cost; %total battery cost
    width = 21.5/1000; %effective cell width (diameter)
    height = 71/1000; %effective cell height
    pack_width = series*width; %estimated pack width
    pack_height = parallel*height;
    wsto = [wsto ; -pack_width/2 pack_width/2];
    hsto = [hsto ; -pack_height/2 pack_height/2];
end

figure
hold on
plot([wsto(1,1) wsto(1,1)],[hsto(1,1) hsto(1,2)],'k-',[wsto(1,1) wsto(1,2)],[hsto(1,2) hsto(1,2)],'k-',[wsto(1,2) wsto(1,2)],[hsto(1,2) hsto(1,1)],'k-',[wsto(1,2) wsto(1,1)],[hsto(1,1) hsto(1,1)],'k-')
plot([wsto(2,1) wsto(2,1)],[hsto(2,1) hsto(2,2)],'b-',[wsto(2,1) wsto(2,2)],[hsto(2,2) hsto(2,2)],'b-',[wsto(2,2) wsto(2,2)],[hsto(2,2) hsto(2,1)],'b-',[wsto(2,2) wsto(2,1)],[hsto(2,1) hsto(2,1)],'b-')
plot([wsto(3,1) wsto(3,1)],[hsto(3,1) hsto(3,2)],'g-',[wsto(3,1) wsto(3,2)],[hsto(3,2) hsto(3,2)],'g-',[wsto(3,2) wsto(3,2)],[hsto(3,2) hsto(3,1)],'g-',[wsto(3,2) wsto(3,1)],[hsto(3,1) hsto(3,1)],'g-')
plot([wsto(4,1) wsto(4,1)],[hsto(4,1) hsto(4,2)],'r-',[wsto(4,1) wsto(4,2)],[hsto(4,2) hsto(4,2)],'r-',[wsto(4,2) wsto(4,2)],[hsto(4,2) hsto(4,1)],'r-',[wsto(4,2) wsto(4,1)],[hsto(4,1) hsto(4,1)],'r-')
lgd = legend('Voltage = 12V','Voltage = 24V','Voltage = 36V','Voltage = 48V');
lgd.Location = 'northwest';
title('Representative Battery Pack Dimensions')
xlabel('Battery Pack Width Relative To Center [m]')
ylabel('Battery Pack Height Relative To Center [m]')
xlim([-.4 0.4]) 
