%% Function Name: simulatedPlot
%
% Description: 
% 
% Animate a vehicle with:
%   single-track wheels
%   vehicle wheels
%   vehicle frame
%
% Parameters:
%   x         ... x position of vehicle (center of roation/gravity)
%   y         ... y position of vehicle (center of roation/gravity)
%   r         ... angle of yaw
%   delta_f   ... Steering lock/angle of front wheel of the single-track model
%   delta_r   ... Steering lock/angle of rear wheel of the single-track model
%   a         ... Length from front wheel-axis to center of rotation
%   b         ... Length form rear wheel-axis to center of rotation
%
% Returns:
%   -
%
% Other files required: 
%     - mAckermannSteering, 
%     - rotateLine
%
% $Revision: R2018b
% $Author: Sebastian Knoll
% $Email: matlab@sebastanknoll.net 
% $Date: June 16, 2020
%---------------------------------------------------------
function simulatedPlot(x, y, r, delta_f, delta_r, a, b)

  step_size = 10;
  filename = "simulatedPlot.gif";
  plot_lines = 1;

  iszero = @(value) abs(value) <= 1e-3;

  if ~exist('a','var')
    a = 1;
  end

  if ~exist('b','var')
    b = 1;
  end

  fig_num = 1;

  %Vehicle
  vehicle_frame_length = a + b;
  vehicle_frame_width = 1.5;

  vehicle_wheel_size = .5; %m
  vehicle_wheel_width = 0.1; %m

  vehicle_singletrack_width = .01; %m
  vehicle_size_border = max([vehicle_frame_length, vehicle_singletrack_width]);

  for index = 1:step_size:length(x)
    
      figure(fig_num);
      clf;
      
      hold on;
      
      %Vehicle
      vehicle_xy = rotateLine(a, b, vehicle_singletrack_width, r(index), [x(index); y(index)]);
      plot(vehicle_xy(1,:), vehicle_xy(2, :), 'b--');
      
      %Front wheel
      vehicle_front_xy = rotateLine(vehicle_wheel_size/2, vehicle_wheel_size/2, vehicle_wheel_width, r(index) + delta_f(index), vehicle_xy(:, 2));
      fill(vehicle_front_xy(1,:), vehicle_front_xy(2, :), 'k');
      
      %Rear wheel
      vehicle_rear_xy = rotateLine(vehicle_wheel_size/2, vehicle_wheel_size/2, vehicle_wheel_width, r(index) + delta_r(index), vehicle_xy(:, 1));
      fill(vehicle_rear_xy(1,:), vehicle_rear_xy(2, :), 'k');
      
      %Real wheels
      [delta_f_1, delta_f_2, delta_r_1, detla_r_2, cl, lf1, lf2, lr1, lr2, ~] = mAckermannSteering(vehicle_frame_length, vehicle_frame_width, delta_f(index), delta_r(index));
      real_wheels = [detla_r_2, delta_f_1, delta_f_2, delta_r_1];
      real_wheel_length_to_cor = [lr2, lf1, lf2, lr1];
    
      %Frame
      vehicle_frame_xy = rotateLine(a + vehicle_wheel_size/2, b + vehicle_wheel_size/2, vehicle_frame_width, r(index), [x(index); y(index)]);
      vehicle_wheel_positions_xy = rotateLine(a, b, vehicle_frame_width, r(index), [x(index); y(index)]);
      for plot_index = [1, 2, 3, 4]
          line_data = [vehicle_frame_xy(:, plot_index)'; vehicle_frame_xy(:, max(1, mod(plot_index+1, 5)))'];
          plot(line_data(:, 1), line_data(:, 2), 'k');
          
          % Real wheel i
          vehicle_real_wheel_xy = rotateLine(vehicle_wheel_size/2, vehicle_wheel_size/2, vehicle_wheel_width, r(index) + real_wheels(plot_index), vehicle_wheel_positions_xy(:, plot_index));
          fill(vehicle_real_wheel_xy(1,:), vehicle_real_wheel_xy(2, :), 'k');
          
          %Lines from real wheel to COR
          if or(~iszero(delta_f(index)), ~iszero(delta_r(index)))
              line_real_xy = rotateLine(real_wheel_length_to_cor(plot_index), 0, .01, r(index) + real_wheels(plot_index) + pi/2, vehicle_wheel_positions_xy(:, plot_index));
              plot(line_real_xy(1, :), line_real_xy(2, :), 'b--');
          end
      end
      
      %Lines from singel tack to COR
      if or(~iszero(delta_f(index)), ~iszero(delta_r(index)))
          len = cl / cos(delta_f(index));
          if delta_f(index) < 0 len = -len; end
          line_f_xy = rotateLine(len, 0, .01, r(index) + delta_f(index) + pi/2, vehicle_xy(:, 2));
          plot(line_f_xy(1, :), line_f_xy(2, :), 'g--');

          len = cl/cos(delta_r(index));
          if delta_f(index) < 0 len = -len; end
          line_r_xy = rotateLine(len, 0, .01, r(index) + delta_r(index) + pi/2, vehicle_xy(:, 1));
          plot(line_r_xy(1, :), line_r_xy(2, :), 'g--');
      end
      
      min_plot = min([min(x)-vehicle_size_border, min(y)-vehicle_size_border]);
      max_plot = max([max(x)+vehicle_size_border, max(y)+vehicle_size_border]);
      
      %Lines
      if(plot_lines ~= 0)
        plot(x(1:index), y(1:index), 'r--');
      end
      
      axis(1.1*[min_plot, max_plot, min_plot, max_plot]);
      axis square;
      
      xlabel('\leftarrow x in m');
      ylabel('\leftarrow y in m');

      drawnow;
      frame = getframe(fig_num);
      im = frame2im(frame);
      [imind,cm] = rgb2ind(im,256);
      
      if index == 1
        imwrite(imind,cm,filename,'gif','Loopcount',inf,'DelayTime', 1);
      else
        imwrite(imind,cm,filename,'gif','WriteMode','append','DelayTime', 1);
      end
  end
end