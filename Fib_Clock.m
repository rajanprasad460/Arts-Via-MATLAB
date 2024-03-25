clc;
clear;
close all;

%% Fibnacci clock design matlab


% Define rotation matrix
R = @(a) [cosd(a), -sind(a); sind(a), cosd(a)];

%% Fibanacci series drawing

% % Creat a sqauare for fib spiral
% % n = 10;
% % a_l = fibonacci(n);
% 
% % Use for loop to creat squares
% p_count = 0;
% x = 0;
% y = 1;
% syms v u
% 
% axis off
% hold on
% 
% for n = 1:10
% 
%     a = fibonacci(n);
% 
%     % Define squares and arcs
%     switch mod(n,4)
%         case 0
%             y = y - fibonacci(n-2);
%             x = x - a;
%             eqnArc = (u-(x+a))^2 + (v-y)^2 == a^2;
%         case 1
%             y = y - a;
%             eqnArc = (u-(x+a))^2 + (v-(y+a))^2 == a^2;
%         case 2
%             x = x + fibonacci(n-1);
%             eqnArc = (u-x)^2 + (v-(y+a))^2 == a^2;
%         case 3
%             x = x - fibonacci(n-2);
%             y = y + fibonacci(n-1);
%             eqnArc = (u-x)^2 + (v-y)^2 == a^2;
%     end
% 
%     % Draw square
%     pos = [x y a a];
%     %     rectangle('Position', pos)
% 
%     % Add Fibonacci number
%     xText = (x+x+a)/2;
%     yText = (y+y+a)/2;
%     %     text(xText, yText, num2str(a))
% 
%     % Draw arc
%     interval = [x x+a y y+a];
% 
%     fimplicit(eqnArc, interval, 'b');
%     pause(1);
%     % Get the handle of the plotted curve
%     h = gca; % Get current axis handle
%     curve = h.Children; % Get the plotted curve
% 
% 
%     % Extract x and y data of the plotted curve
%     x_data.(strcat('Mode',num2str(n))) = curve.XData-1;
%     y_data.(strcat('Mode',num2str(n))) = curve.YData-1;
%     p_count = p_count+length(curve.XData);
% 
% 
%     clf;
% 
% 
% 
% 
% end


%% Instead of running whole code, lets load equivalent data

load fib_curve.mat
a = fibonacci(10);
%%
figure('MenuBar','none','ToolBar','none','Name','Spiral Clock','Color',[1,1,1],'units','normalized','outerposition',[0 0 1 1])
% figure
% Define center and radius of the clock face
center = [0, 0];
radius = a+15;

% Plot clock face
theta = linspace(0, 2*pi, 100);
x_circle = 1.1*radius * cos(theta) + center(1);
y_circle = 1.1*radius * sin(theta) + center(2);
plot(x_circle, y_circle, '.k', 'LineWidth', 2);
hold on

x_circle2 = 1.2*radius * cos(theta) + center(1);
y_circle2 = 1.2*radius * sin(theta) + center(2);
plot(x_circle2, y_circle2, '-b', 'LineWidth', 5);


hold on;

% Plot hour numbers
% hour_numbers = {'12', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11'};
hour_numbers = {'XII', 'I', 'II', 'III', 'IV', 'V', 'VI', 'VII', 'VIII', 'IX', 'X', 'XI'};


for hour = 1:12
    theta_hour = pi/2 - (hour-1) * pi/6;
    x_hour = 0.99 * radius * cos(theta_hour) + center(1);
    y_hour = 0.99 * radius * sin(theta_hour) + center(2);
    text(x_hour, y_hour, hour_numbers{hour}, 'FontSize', 16, 'HorizontalAlignment', 'center','FontWeight','bold','Color','b');
end

% % Get current time
% curr_time = clock;
% hours = curr_time(4);
% minutes = curr_time(5);
% seconds = curr_time(6);
%
% % Plot hour hand
% hour_theta = pi/2 - (hours * 30 + minutes / 2) * pi/180;
% hour_hand_length = 0.6 * radius;
% hour_hand_x = hour_hand_length * cos(hour_theta) + center(1);
% hour_hand_y = hour_hand_length * sin(hour_theta) + center(2);
% plot([center(1), hour_hand_x], [center(2), hour_hand_y], 'r', 'LineWidth', 2);
%
% % Plot minute hand
% minute_theta = pi/2 - minutes * 6 * pi/180;
% minute_hand_length = 0.8 * radius;
% minute_hand_x = minute_hand_length * cos(minute_theta) + center(1);
% minute_hand_y = minute_hand_length * sin(minute_theta) + center(2);
% plot([center(1), minute_hand_x], [center(2), minute_hand_y], 'g', 'LineWidth', 2);
%
% % Plot second hand
% second_theta = pi/2 - seconds * 6 * pi/180;
% second_hand_length = 0.9 * radius;
% second_hand_x = second_hand_length * cos(second_theta) + center(1);
% second_hand_y = second_hand_length * sin(second_theta) + center(2);
% plot([center(1), second_hand_x], [center(2), second_hand_y], 'b', 'LineWidth', 1);

% Plot hour hand
h_hand = plot([0 0], [0, radius*0.75], 'r', 'LineWidth', 3);

% Plot minute hand
m_hand = plot([0,0], [0,radius*0.8], 'g', 'LineWidth', 2);

% % Plot second hand
s_hand = plot([0,0], [0,radius*0.85], 'b', 'LineWidth', 1);

% % Plot second hand
% plot([0,0], [0,radius], 'b', 'LineWidth', 1);

% Put a big marker at origin  and plot a cross
plot(0,0,'o','Marker','o','MarkerFaceColor','m','MarkerEdgeColor','m','MarkerSize',15)

% plot([0 0],[-radius radius]);
% plot([-radius radius], [0 0]);
axis equal;
axis off;
title('Fib Spiral Clock','Interpreter','latex');


%


com_data = [];

f_name = fieldnames(x_data);
for k = 1:length(f_name)
    hold on
    n_vec = [x_data.(f_name{k});y_data.(f_name{k})];
    IMG.(strcat('TRACK',num2str(k))) = plot(n_vec(1,:),n_vec(2,:),'Color','m','LineWidth',1);
    %     % plotting rotated
    %     r_vec = R(theta)*[x_data.(f_name{k});y_data.(f_name{k})];
    %     plot(r_vec(1,:),r_vec(2,:),'Color','m','LineWidth',2);
    com_data = [com_data n_vec];
end

% Find the dials for hour indicator for each hour
% x_range between (-10 10)


%



for theta = 0:30:330
    hold on

    r_vec = R(theta)*com_data;
    % Find the range of curve between [-10 10]
    % Lets set y range for min
    key = find(r_vec(1,:)<10 & r_vec(1,:)>-10);


    %     sort data based on y value and choose data with
    % find y axis having largest value - or +
    d_key = (diff(key)>1);
    d_key2 = find(d_key==1);

    if theta == 0 || theta == 180
        %         s_ind = d_key2(end-1);
        r_vec = r_vec(:,(key(d_key2(end-1)+1:d_key2(end)-1)));
        m_rvec = mean(r_vec(2,:));
        if m_rvec>0
            r_vec = r_vec(:,r_vec(2,:)>0);
        else
            r_vec = r_vec(:,r_vec(2,:)<0);
        end
        plot(r_vec(1,:),r_vec(2,:),'-k','LineWidth',1.5)
    else
        s_ind = d_key2(end);
        r_vec = r_vec(:,key(s_ind+1:end));
        plot(r_vec(1,:),r_vec(2,:),'-k','LineWidth',1.5)

        %         plot(r_vec(1,key(s_ind+1:end)),r_vec(2,key(s_ind+1:end)),'LineWidth',2)
    end
    dial = mod(abs((theta/30)-15),12);
    if dial == 0
        dial = 12;
    end
    text(1.71*min(r_vec(1,:)),max(r_vec(2,:)),num2str(dial),'Interpreter','latex');

end


% % For 30 min indicator
for theta = 15:30:375
    hold on

    r_vec = R(theta)*com_data;
    % Find the range of curve between [-10 10]
    % Lets set y range for min
    key = find(r_vec(1,:)<10 & r_vec(1,:)>-10);


    %     sort data based on y value and choose data with
    % find y axis having largest value - or +
    d_key = (diff(key)>1);
    d_key2 = find(d_key==1);

    if theta == 0 || theta == 180
        %         s_ind = d_key2(end-1);
        r_vec = r_vec(:,(key(d_key2(end-1)+1:d_key2(end)-1)));
        m_rvec = mean(r_vec(2,:));
        if m_rvec>0
            r_vec = r_vec(:,r_vec(2,:)>0);
        else
            r_vec = r_vec(:,r_vec(2,:)<0);
        end
        plot(r_vec(1,:),r_vec(2,:),'LineWidth',0.21)
    else
        s_ind = d_key2(end);
        r_vec = r_vec(:,key(s_ind+1:end));
        plot(r_vec(1,:),r_vec(2,:),'LineWidth',0.21)

        %         plot(r_vec(1,key(s_ind+1:end)),r_vec(2,key(s_ind+1:end)),'LineWidth',2)
    end
    dial = mod(abs((theta/30)-15),12);
    if dial == 0
        dial = 12;
    end
    text(1.21*max(r_vec(1,:)),min(r_vec(2,:)),num2str(dial),'Interpreter','latex');

end


%%

f_count = 1;

for theta2 = 360*360*360:-50:0
    theta = theta2/720;
    for k = 1:length(f_name)
        n_vec = [x_data.(f_name{k});y_data.(f_name{k})];
        % plotting rotated
        r_vec = R(theta+90)*n_vec;
        %         plot(r_vec(1,:),r_vec(2,:),'Color','m','LineWidth',2);
        set(IMG.(strcat('TRACK',num2str(k))),'XData',r_vec(1,:),'YData',r_vec(2,:));
    end
    h_hand_data = R(theta)*[0;radius*0.75];
    set(h_hand,'XData',[0,h_hand_data(1)],'YData',[0,h_hand_data(2)]);

    m_hand_data = R(theta2/60)*[0;radius*0.8];
    set(m_hand,'XData',[0,m_hand_data(1)],'YData',[0,m_hand_data(2)]);

    s_hand_data = R(theta2)*[0;radius*0.85];
    set(s_hand,'XData',[0,s_hand_data(1)],'YData',[0,s_hand_data(2)]);
   
    frame = getframe(gcf);
    im(f_count)=frame;
    im2{f_count} = frame2im(frame);
    f_count = f_count+1;
    pause(0.1);
end



%% Aligning with current time


% f_count = 1;
% 
% while(1)
% 
% 
%     % Get current time
%     curr_time = clock;
%     hours = curr_time(4);
%     minutes = curr_time(5);
%     seconds = curr_time(6);
% 
%     % Calculate the angles required 12 is 0 deg
% 
%     for k = 1:length(f_name)
%         n_vec = [x_data.(f_name{k});y_data.(f_name{k})];
%         % plotting rotated
%         r_vec = R((-hours+((-minutes-seconds/60))/60)*30+90)*n_vec;
%         %         plot(r_vec(1,:),r_vec(2,:),'Color','m','LineWidth',2);
%         set(IMG.(strcat('TRACK',num2str(k))),'XData',r_vec(1,:),'YData',r_vec(2,:));
%     end
%     h_hand_data = R((-hours+((-minutes-seconds/60))/60)*30)*[0;radius*0.65];
%     set(h_hand,'XData',[0,h_hand_data(1)],'YData',[0,h_hand_data(2)]);
% 
%     m_hand_data = R((-minutes-seconds/60)*6)*[0;radius*0.7];
%     set(m_hand,'XData',[0,m_hand_data(1)],'YData',[0,m_hand_data(2)]);
% 
%     s_hand_data = R(-seconds*6)*[0;radius*0.75];
%     set(s_hand,'XData',[0,s_hand_data(1)],'YData',[0,s_hand_data(2)]);
%     pause(0.1);
% 
% 
%     frame = getframe(gcf);
%     im(f_count)=frame;
%     im2{f_count} = frame2im(frame);
%     f_count = f_count+1;
% end


%%

im3 = im(1:10:end);

filename = AutoRename(cd,'FibWatch.avi');
v = VideoWriter(filename,'Motion JPEG AVI');
v.Quality= 100;
v.FrameRate= 5;% No. of frames per second
open(v);
writeVideo(v,im3);
close(v);

%%

im4 = im2(1:10:end);
filename = AutoRename(cd,'FibWatch.gif');
for i = 1:1:length(im4)
    [A1,map] = rgb2ind(im4{i},256);
    if i == 1
        imwrite(A1,map,filename,'gif','LoopCount',Inf,'DelayTime',0.0005);
    else
        imwrite(A1,map,filename,'gif','WriteMode','append','DelayTime',0.0005);
    end
end