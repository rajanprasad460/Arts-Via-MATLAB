clc;
clear;
close all;

% with decreasing radius
center = [0 0];
radius1 = 10;
radius = radius1;
delta_x = radius*1.2;
number_circle = 12;
count = 1;

figure('units','normalized','outerposition',[0.1300 0.0700 0.6250 0.90])
% figure
% xlim([-10 220]);
axis off;
axis  xy
% axis equal


for k = 1:number_circle


    viscircles(center(k,:),radius(k));
    hold on
    A.(strcat('circ',num2str(k))).h = plot(center(k,1),center(k,2),'.k'); % Tracker on circle
        A.(strcat('circ',num2str(k))).h2 = plot(center(k,1),center(k,1)); % Sine wave
    A.(strcat('circ',num2str(k))).h3 = plot([center(k,1) center(k,1)],[center(k,2) center(k,2)],'--m'); % line connecting the circle tracker and sine wave


    radius(k+1) = radius1*(1/(2*(k)+1));
    center(k+1,:) = center(k,:) ;%+ [0 radius(k)+1*radius(k+1)+k/4];
end


rev_angles = [1:2:420];
for j = 1:length(rev_angles)
    theta = rev_angles(j); % degree

    for k = 1:number_circle
        y(k,j) = radius(k)*sind(theta*(2*(k-1)+1));
        x(k,j) = radius(k)*cosd(theta*(2*(k-1)+1));
        % updating the sine wave
        set(A.(strcat('circ',num2str(k))).h2,'XData',(1:j)/2+delta_x,'YData',y(k,1:j)+center(k,2));
        %         plot((1:j)/2+delta_x,y(k,1:j)+center(k,2));
        hold on
        % Updating the line connecting
        if j ~= length(rev_angles)
        set(A.(strcat('circ',num2str(k))).h3,'XData',[x(k,j) j/2+delta_x],'YData',[y(k,j)+center(k,2) y(k,j)+center(k,2)]);
        %     plot([x(j) j+radius],[y(j) y(j)],'-m')
        else
            set(A.(strcat('circ',num2str(k))).h3,'XData',[center(k,1) center(k,1)],'YData',[center(k,2) center(k,2)]);
        end
        % Updating the tracker location
        set(A.(strcat('circ',num2str(k))).h,'XData',x(k,j)+center(k,1),'YData',y(k,j)+center(k,2));


        % Reading frame
        frame = getframe(gcf);
        im(count)=frame;
        im2{count} = frame2im(frame);
        count = count+1;

        pause(0.01);
        drawnow;
    end
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
    v.FrameRate=120;% No. of frames per second
    %     v.FileFormat = 'mp4';
    open(v);
    writeVideo(v,im);
    close(v);
end