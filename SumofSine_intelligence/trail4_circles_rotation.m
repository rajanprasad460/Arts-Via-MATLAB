clc;
clear;
close all;

%% Plotting simply circles only
n_circles = 150;

% figure('units','normalized','outerposition',[0.1300 0.0700 0.6250 0.90]);
% axis off;
figure;
axis equal;

delta_x = 350;
count = 1;

rev_angles = [0:0.4:10 11:8:170 171:0.4:190 191:8:350 351:0.4:370];
% rev_angles = 120:5:360;
% Selecting a rotation angle
for k = 138:length(rev_angles)
    % with decreasing radius
    center = [0 0];
    radius1 = 100;
    s_radius = 0;

    theta = rev_angles(k); % degree
    for j = 1:n_circles

        hold on
        % radius scales as 1/3 , 1/5, 1/7, 1/9 and so on
        radius = radius1*(1/(2*(j-1)+1));
        s_radius = s_radius + radius;
        % plotting centers
        plot(center(1),center(2),'.k');

        viscircles(center,radius);
        % centers to be rotated depending on the angles 3, 5, 7, 9 etc
        center1 = radius*[cosd(theta*(2*(j-1)+1)) sind(theta*(2*(j-1)+1))];
        center2(j,:) = center1;
        t_center = center + center1;
        % Connecting centers
        %     plot([center(1) t_center(1)],[center(2) t_center(2)],'--b');
        center = t_center;

        %         plot(delta_x(1:k)',center2(1:j,2),'-g');


        if j == n_circles
            c_center(k,:) = center;
            %             plot(c_center(1:k,1),c_center(1:k,2),'.g');
            % Also plotting the line by pushing in far right

            plot(delta_x(1:k),c_center(1:k,2),'-b');
            delta_x(k+1) = abs(c_center(k,1))/100 + delta_x(k);
            hold on
            % plotting line connecting the circles and the equivalent rect
            plot([c_center(k,1) delta_x(k)],[c_center(k,2),c_center(k,2)],'--m')
        end

        % Plotting the resulting effects

    end
    axis equal;
    axis off
    % Reading frame
    frame = getframe(gcf);
    im(count)=frame;
    im2{count} = frame2im(frame);
    count = count+1;
    pause(0.01)
    clf;
end



%% ------------ Save animation file ----------------------------
if save_animate == 1
    filename = AutoRename(cd,'Finalized.gif');
    for i = 1:2:length(im)
        [A1,map] = rgb2ind(im2{i},256);
        if i == 1
            imwrite(A1,map,filename,'gif','LoopCount',Inf,'DelayTime',0.005);
        elseif i == count-1
            imwrite(A1,map,filename,'gif','WriteMode','append','DelayTime',5);
        else
            imwrite(A1,map,filename,'gif','WriteMode','append','DelayTime',0.005);
        end
    end
end


if save_gif == 1
    % ------- Saving Video File ------------------------------------------
    filename = AutoRename(cd,'Sprial.mp4');
    v = VideoWriter(filename,'MPEG-4');
    v.Quality=100;
    v.FrameRate=5;% No. of frames per second
    %     v.FileFormat = 'mp4';
    open(v);
    writeVideo(v,im);
    close(v);
end