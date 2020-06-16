%% Function Name: mAckermannSteering
%
% Description: 
% 
% Calculating the steering lock/angle for
% each wheel when steering lock/angle for
% the single-track model is given.
%
% Parameters:
%   vehicle_length  ... Length between front and rear axis
%   vehicle_width   ... Width between left and right wheel/ rotation axis 
%   delta_f         ... Steering lock/angle of front wheel of the single-track model
%   delta_r         ... Steering lock/angle of rear wheel of the single-track model
%
% Returns:
%   delta_f_1       ... Steering lock/angle for front wheel 1
%   delta_f_2       ... Steering lock/angle for front wheel 2
%   delta_r_1       ... Steering lock/angle for rear wheel 1
%   delta_r_2       ... Steering lock/angle for rear wheel 2
%   cl              ... Length to center of rotation - referred normal from length axis
%   lf1             ... Length to cneter of rotation - referred normal from front wheel 1
%   lf2             ... Length to cneter of rotation - referred normal from front wheel 2
%   lr1             ... Length to cneter of rotation - referred normal from rear wheel 1
%   lr2             ... Length to cneter of rotation - referred normal from rear wheel 2
%   info            ....Information string 
%
% $Revision: R2018b
% $Author: Sebastian Knoll
% $Email: matlab@sebastanknoll.net 
% $Date: June 16, 2020
%---------------------------------------------------------
function [delta_f_1, delta_f_2, delta_r_1, delta_r_2, cl, lf1, lf2, lr1, lr2,info] = mAckermannSteering(vehicle_length, vehicle_width, delta_f, delta_r)

vehicle_width_half = vehicle_width / 2;

r_negativ = delta_r < 0;
f_negativ = delta_f < 0;

% Both wheel sets same direction -> no ackerman
if delta_f == delta_r
    delta_f_1 = delta_f;
    delta_f_2 = delta_f;
    delta_r_1 = delta_r;
    delta_r_2 = delta_r;
    cl = Inf;
    lf1 = Inf;
    lf2 = Inf; 
    lr1 = Inf;
    lr2 = Inf;
    info = 'Both wheel sets same direction - keep same delta';
    return;
end

delta_r = abs(delta_r);
delta_f = abs(delta_f);

cl = vehicle_length/(tan(delta_f) + tan(delta_r));

% mutli Ackermann Steering
cr = cl*tan(delta_r);
cf = vehicle_length - cr;

if f_negativ
    delta_f_1 = -atan(cf / (cl + vehicle_width_half));
    delta_f_2 = -atan(cf / (cl - vehicle_width_half));
    lf1 = -(cl + vehicle_width_half) / cos(delta_f_1);
    lf2 = -(cl - vehicle_width_half) / cos(delta_f_2);
else
    delta_f_1 = atan(cf / (cl - vehicle_width_half));
    delta_f_2 = atan(cf / (cl + vehicle_width_half));
    lf1 = (cl - vehicle_width_half) / cos(delta_f_1);
    lf2 = (cl + vehicle_width_half) / cos(delta_f_2);
end

if r_negativ
    delta_r_1 = -atan(cr / (cl + vehicle_width_half));
    delta_r_2 = -atan(cr / (cl - vehicle_width_half));
    lr1 = (cl + vehicle_width_half) / cos(delta_r_1);
    lr2 = (cl - vehicle_width_half) / cos(delta_r_2);
else
    delta_r_1 = atan(cr / (cl - vehicle_width_half));
    delta_r_2 = atan(cr / (cl + vehicle_width_half));
    lr1 = -(cl - vehicle_width_half) / cos(delta_r_1);
    lr2 = -(cl + vehicle_width_half) / cos(delta_r_2);
end

info = "mAckerman";

end

