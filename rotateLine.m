%% Function Name: rotateLine
%
% Description: 
% 
% Rotate a line by a given radius.
%
% Line:    <-     a     ->cg<- b ->
%
%   cg':    Center of Rotation
%
% Parameters:
%   a       ... Length from 'left' point to cg
%   b       ... Length from 'right' point to cg
%   width   ... Width of line - set to zero if just two points need to be rotated
%   phi     ... Angle of rotation
%   cg      ... Center of roation / gravity
%
% Returns:
%   points  ... array[point_i] i = 1...4
%
%           ------2
%   1-----  ------3
%   4-----
%
% $Revision: R2018b
% $Author: Sebastian Knoll
% $Email: matlab@sebastanknoll.net 
% $Date: June 16, 2020
%---------------------------------------------------------
function points = rotateLine(a, b, width, phi, cg)

    roation_matrix = [cos(phi), -sin(phi); sin(phi), cos(phi)];

    point_1 = cg + roation_matrix * [-b; width/2];
    point_2 = cg + roation_matrix * [a; width/2];
    point_3 = cg + roation_matrix * [a; -width/2];
    point_4 = cg + roation_matrix * [-b; -width/2];

    points = [point_1, point_2, point_3, point_4];
end

