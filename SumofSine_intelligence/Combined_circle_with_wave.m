clc;
clear;
close all;

% with decreasing radius
center = [0 0];
center2 = center;
radius1 = 20;
radius = radius1;
delta_x = radius*2.5;
number_circle = 15;
count = 1;


figure('units','normalized','outerposition',[0.1300 0.0700 0.6250 0.60])
% figure
% xlim([-10 220]);

% axis equal;
axis off;


rev_angles = [-2:1:380];
% rev_angles = [0:0.4:10 11:3:170 171:0.4:190 191:3:350 351:0.4:370];

for j = 1:length(rev_angles)
    theta = rev_angles(j); % degree
    s_radius = 0;
    for k = 1:number_circle

        if k ==1
            viscircles(center(k,:),radius(k),'Color','m','Linewidth',2);
        else
            viscircles(center(k,:),radius(k),'Color','m','Linewidth',1);
        end
        radius(k+1) = radius1*(1/(2*(k)+1));
        center(k+1,:) = center(k,:);% + [0 radius(k)+1*radius(k+1)+k/4];

        % Circle details estimation
        y(k,j) = radius(k)*sind(theta*(2*(k-1)+1));
        x(k,j) = radius(k)*cosd(theta*(2*(k-1)+1));


        % Updating the sine wave
        plot((1:j)/4+delta_x,y(k,1:j)+center(k,2));

        hold on
        % Updating the line connecting
        if j ~= length(rev_angles)
            plot([x(k,j) j/3+delta_x],[y(k,j)+center(k,2) y(k,j)+center(k,2)],'--m','LineWidth',0.01);
        else
            plot([center(k,1) center(k,1)],[center(k,2) center(k,2)],'--m','LineWidth',0.01);
        end
        % Updating the tracker location
        plot(x(k,j)+center(k,1),y(k,j)+center(k,2),'o')


        %% Plotting the combined effect in same

        hold on
        axis off;
        %         axis equal;

        % plotting centers
        plot(center2(k,1),center2(k,2),'.k');

        if k ==1
            viscircles(center2(k,:),radius(k),'Color','m','Linewidth',2);
        else
            viscircles(center2(k,:),radius(k),'Color','k','Linewidth',1);
        end

        % centers to be rotated depending on the angles 3, 5, 7, 9 etc
        center1 = radius(k)*[cosd(theta*(2*(k-1)+1)) sind(theta*(2*(k-1)+1))];
        center2(k+1,:) = center2(k,:) + center1;
        % Connecting centers
        plot([center2(k,1) center2(k+1,1)],[center2(k,2) center2(k+1,2)],'--b');
        % Center point plot
        plot(center2(k,1),center2(k,2),'.y');




        if k == number_circle
             % Also plotting the line by pushing in far right
            x_com(j) = j/4+delta_x;
            c_com(j) = center2(k,2);
            plot(x_com(1:j),c_com(1:j),'LineWidth',2);

            % plotting line connecting the circles and the equivalent rect
            hold on
            plot([center2(k,1) j/4+delta_x],[center2(k,2),center2(k,2)],'--r','LineWidth',1.5)
            
            % Plotting sqaure wave herewith for reference
%             plot((1:length(rev_angles))/2+delta_x,0.801*radius1*square(rev_angles*pi/180),'LineWidth',1)
        end






    end
    % Reading frame
    frame = getframe(gcf);
    im(count)=frame;
    im2{count} = frame2im(frame);
    count = count+1;

    drawnow
    pause(0.01);
    axis off;
    clf;

    axis off;
    %     axis equal
end

save_animate  =1;

%% ------------ Save animation file ----------------------------
if save_animate == 1
    filename = AutoRename(cd,'Combined_Art.gif');
    for i = 1:7:length(im)
        [A1,map] = rgb2ind(im2{i},256);
        if i == 1
            imwrite(A1,map,filename,'gif','LoopCount',Inf,'DelayTime',0.005);
        elseif i == count-7
            imwrite(A1,map,filename,'gif','WriteMode','append','DelayTime',5);
        else
            imwrite(A1,map,filename,'gif','WriteMode','append','DelayTime',0.005);
        end
    end
end
if save_gif == 1
    % ------- Saving Video File ------------------------------------------
    filename = AutoRename(cd,'Sprial_c.mp4');
    v = VideoWriter(filename,'MPEG-4');
    v.Quality=100;
    v.FrameRate=20;% No. of frames per second
    %     v.FileFormat = 'mp4';
    open(v);
    writeVideo(v,im);
    close(v);
end