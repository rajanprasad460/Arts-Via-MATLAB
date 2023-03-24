clc;
clear;
close all;

%% Plotting simply circles only
n_circles = 80;
figure;
axis normal

% Selecting a rotation angle
for k = 1:361
    % with decreasing radius
    center = [0 0];
    radius1 = 100;

    theta = 1*(k-1); % radian
    for j = 1:n_circles
        subplot(1,2,1)
        hold on
        % radius scales as 1/3 , 1/5, 1/7, 1/9 and so on
        radius = radius1*(1/(2*(j-1)+1));
        % plotting centers
        plot(center(1),center(2),'.k');

        viscircles(center,radius);
        % centers to be rotated depending on the angles 3, 5, 7, 9 etc
        center1 = radius*[cosd(theta*(2*(j-1)+1)) sind(theta*(2*(j-1)+1))];
        t_center = center + center1;
        % Connecting centers
        %     plot([center(1) t_center(1)],[center(2) t_center(2)],'--b');
        center = t_center;
        if j == n_circles
            c_center(k,:) = center;
            plot(c_center(1:k,1),c_center(1:k,2),'.g');
        end

        % Plotting the resulting effects
        subplot(1,2,2)


    end
    pause(0.01)
    clf;
end