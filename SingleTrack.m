% -------------------
clear;
close all;
clc;

% -------------------
delta_r_option = 3; % 1...rear fixed, 2...rear equeal front, 3...rear inverse of front, 4...half inverse of front
steering_factor = 1/3;
speed = 2;
% -------------------
C = 50; %50
a = 1;
b = 1;
Iz = 5; %25

% -------------------
sim('SingleTrackSimulation_R2016b', 10);

%%
if(length(delta_r.data) <= 1)
    delta_r.data = delta_r.data * ones(1, length(delta_f.data));
end

simulatedPlot(x.data, y.data, r.data, delta_f.data, delta_r.data, a, b);
