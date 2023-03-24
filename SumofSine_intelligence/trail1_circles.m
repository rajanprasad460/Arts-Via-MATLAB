clc;
clear;
close all;

%% Plotting simply circles only

% with decreasing radius
center = [0 0];
radius = 0;

% Selecting a rotation angle 
theta = 180; % radian
for j = 1:15
    hold on
    % radius scales as 1/3 , 1/5, 1/7, 1/9 and so on
    radius = 1/(2*(j-1)+1);
    % plotting centers
    plot(center(1),center(2),'.k');    
    
    viscircles(center,radius)
    % centers to be rotated depending on the angles 3, 5, 7, 9 etc
    center1 = radius*[cosd(theta) sind(theta)];

    center = center + center1;
end
