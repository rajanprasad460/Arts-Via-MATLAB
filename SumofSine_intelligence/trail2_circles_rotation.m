clc;
clear;
close all;

%% Plotting simply circles only

% with decreasing radius
center = [0 0];
radius1 = 10;

% Selecting a rotation angle 
theta = 15; % radian
for j = 1:25
    hold on
    % radius scales as 1/3 , 1/5, 1/7, 1/9 and so on
    radius = radius1*(1/(2*(j-1)+1));
    % plotting centers
    plot(center(1),center(2),'.k');    
    
    viscircles(center,radius)
    % centers to be rotated depending on the angles 3, 5, 7, 9 etc
    center1 = radius*[cosd(theta*(2*(j-1)+1)) sind(theta*(2*(j-1)+1))];
    t_center = center + center1;
    % Connecting centers
    %     plot([center(1) t_center(1)],[center(2) t_center(2)],'--b');
    
    center = t_center;
end
