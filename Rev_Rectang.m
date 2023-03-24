clc;
clear;
close all

% Save animation as .gif file
save_animate = 1;
% save_animate = 0;
% Length of square

a = 1;
% rotating the plots

% Gap between recatangels (in between 0 to 1)
lscale = 0.03;
% Choose origin as (0,0).

% Lets get equation of all 4 sides
o1 = [0 0];

% identify the 4 end points of squarae
% Initialize a counter for storing information for gif creation
count = 1;
figure
hold on;
% axis([-a a -a a]) % required only when all 4 quadrants are selected for plotting
for k = 1%:4 % for each quadrants
    p1 = o1;
    if k ==2||k==3
        p2 = [-a 0];
    else
        p2 = [a 0];
    end
    if k ==1
        p3 = [a a];
    elseif k == 2
        p3 = [-a a];
    elseif k == 3
        p3 = [-a -a];
    else
        p3 = [a -a];
    end

    if k ==1||k==2
        p4 = [0 a];
    else
        p4 = [0 -a];
    end



    if k == 2 || k ==4
        in = struct('p1',p1,'p2',p4,'p3',p3,'p4',p2);
    else
        in = struct('p1',p3,'p2',p2,'p3',p1,'p4',p4);
    end


    for j = 1:4 % Four lines
        hold on;
        tp1 = in.(strcat('p',num2str(j)));
        if j <= 3
            tp2 = in.(strcat('p',num2str(j+1)));
        else
            tp2 = in.(strcat('p',num2str(j+1-4)));
        end
        plot([tp1(1) tp2(1)], [tp1(2) tp2(2)])


    end
    % Reading frame
    frame = getframe(gcf);
    im(count)=frame;
    im2{count} = frame2im(frame);
    count = count+1;

    dis = a;

    while(dis>lscale)
        in = NewRectCoordinate(in,lscale);
        % plot new outputs here
        hold on;
        for j = 1:4
            hold on;
            tp1 = in.(strcat('p',num2str(j)));
            if j <= 3
                tp2 = in.(strcat('p',num2str(j+1)));
            else
                tp2 = in.(strcat('p',num2str(j+1-4)));
            end
            plot([tp1(1) tp2(1)], [tp1(2) tp2(2)])

        end
        % Reading frame
        frame = getframe(gcf);
        im(count)=frame;
        im2{count} = frame2im(frame);
        count = count+1;

        % Calculate new distance here

        dis = pdist([in.p1;in.p2],'euclidean');


        pause(0.01)
    end

end
% axis equal


%% ------------ Save animation file ----------------------------
if save_animate == 1
    filename = AutoRename(cd,'Combined_Art.gif');
    for i = 1:1:length(im)
        [A1,map] = rgb2ind(im2{i},256);
        if i == 1
            imwrite(A1,map,filename,'gif','LoopCount',Inf,'DelayTime',0.005);
        else
            imwrite(A1,map,filename,'gif','WriteMode','append','DelayTime',0.005);
        end
    end
end