%% Plotting data from measurements and finding transfer functions

clear;clc;close all;

sample_time = 0.9; % 900 ms

% importing data from measurements of physical system
%data_set_1 = csvread('5Volt_0.3Amps_with_lid_without_time_and_sample_number.csv');
data_set_1 = csvread('5Volt_0.3Amps_with_lid_without_time_and_sample_number.csv',1,0,[1,0,7948,0]);
data_set_2 = csvread('7.5Volt_1Amps_with_lid_without_time_and_sample_number.csv',1,0,[1,0,7948,0]);
data_set_3 = csvread('10Volt_1.2Amps_with_lid_without_time_and_sample_number.csv',1,0,[1,0,7948,0]);

% plotting all 3 data sets
a = [1 : 7948]';
t = a * sample_time;
figure
subplot(2,4,[1,2])
plot (t,data_set_1);
hold on; grid on;
title('Graphs of 3 data sets from temperature sensor');
xlabel('Time (seconds)');
ylabel('Amplitude of temperature sensor (mV)');

plot (t,data_set_2);
plot (t,data_set_3);
legend('dataset 1 = 5 V and 0.3 A','dataset 2 = 7.5 V and 1.0 A','dataset 3 = 10 V and 1.2 A');

% Finding the 3 Transfer Functions
% from reading the time constants and gains of the graphs
% assuming 1. order in the form G = k/(tau*s+1)
% sv = start value
% ss = steady state
% ytc = y-axis value for time constant
% tc = time constants in seconds read of the ytc point on the graphs
% k = gain
In_5 = 5*1000; In_75 = 7.5*1000; In_10 = 10*1000;
sv1 = 239; sv2 = 247; sv3 = 216; % start values for the 3 data sets
ss1 = 311; ss2 = 394; ss3 = 514; % steady state values for the 3 data sets
ytc1 = (ss1-sv1)*0.632+sv1; ytc2 = (ss2-sv2)*0.632+sv2; ytc3 = (ss3-sv3)*0.632+sv3;
tc1 = 1650; tc2 = 1600; tc3 = 1528;
k1 = ss1/In_5; k2 = ss2/In_75; k3 = ss3/In_10;
s =tf('s');
G1 = k1/(tc1*s+1) % TF for data_set_1
G2 = k2/(tc2*s+1) % TF for data_set_2
G3 = k3/(tc3*s+1) % TF for data_set_3
subplot(2,4,[5,6])
step(G1);grid on; hold on; xlim([0 8000]);
step(G2);
step(G3);
legend('TF for dataset 1','TF for dataset 2','TF for dataset 3');

fprintf('Average Transfer function from the 3 data sets:')
G_average = ((k1+k2+k3)/3)/((tc1+tc2+tc3)/3*s+1)

subplot(2,4,[3,4,7,8])
step(G_average);grid on; xlim([0 8000]);

legend('Step response of the average transfer function');

