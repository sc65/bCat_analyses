%% Radial Average Plots
rA_all_norm = rA_all_new./max(max(rA_all_new));
rA_error1_norm = rA_stdError./max(max(rA_all_new));
rA_colonies1_norm = rA_colonies1./max(max(rA_all_new));

%% plot rA for last timepoint
xValues = (bins(1:end-1)+bins(2:end))./2 ;
figure; plot(xValues, rA_all_norm(end,:), 'Color', [0.7 0 0], 'LineWidth',4);
hold on;
errorbar(xValues, rA_all_norm(end,:), rA_error1_norm(end,:), 'Color', [0.7 0 0], 'LineWidth', 1);

xlabel('Distance from edge (\mum)'); ylabel('radialAverage'); title('48h');
ax = gca;
ax.FontSize = 12; ax.FontWeight = 'bold';
%% find and plot threshold
threshold = min(rA_all_norm(end,:)) + 0.5*(max(rA_all_norm(end,:))-min(rA_all_norm(end,:)));
hold on;
plot([0 400], [threshold threshold], 'k:', 'LineWidth', 3);

%% ------------------------ plot average radial average for selected timepoints
colors = colorcube(45);

%colors = rand(45,3);
%%
colors = colorblind([1 7 8 6 4 5],:);
markers = {'o', '+', '*', 'x', 's', 'd'};

figure; hold on;
xValues = (bins(1:end-1)+bins(2:end))./2 ;
timePoints1 = [1:45];
toUse = [18 23 28 33 38 43];
timePointsToUse = timePoints1(toUse);

legendLabels = strcat(strsplit(int2str(2+timePointsToUse), ' '), ' h');
counter = 1;

for jj = timePointsToUse
    
    % for proper legend
    for ii = 1:numel(toUse)
        plot(0,0,'Color', colors(ii,:));
    end
    [~,hObj]=legend(legendLabels, 'FontSize', 12);           % return the handles array
    hL=findobj(hObj,'type','line');  % get the lines, not text
    set(hL,'linewidth',4);
    
    % plot actual data
    plot(xValues, rA_all_norm(jj,:),'Color', colors(counter,:), ...
         'LineWidth', 4);
    errorbar(xValues, rA_all_norm(jj,:), rA_error1_norm(jj,:), ...
        'Color', colors(counter,:), 'LineWidth', 1);
    counter = counter+1;
    
%     if jj == timePoints1(end)
%         plot(xValues, rA_all_norm(jj,:), 'Color', colornames{counter}, 'LineWidth', 4);
%         %errorbar(xValues, rA_all_norm(jj,:), rA_error1_norm(jj,:), 'Color', [0.7 0 0], 'LineWidth', 1);
%     else
%         plot(xValues, rA_all_norm(jj,:), 'Color', colornames{counter}, 'LineWidth',4);
%         %errorbar(xValues, rA_all_norm(jj,:), rA_error1_norm(jj,:), 'Color', colors(jj,:), 'LineWidth', 1);
%     end
    
    
end

%legend(labels);
ylim([0.1 1.1]);
xlabel('Distance from edge (\mum)'); ylabel('radialAverage');
ax = gca;
ax.FontSize = 16; ax.FontWeight = 'bold';
%% --threshold line
hold on;
plot([0 400], [threshold threshold], 'k:', 'LineWidth', 2);
%% --threshold point
hold on;
plot(0, threshold, 'Marker', '*' , 'Color', 'r', 'MarkerSize', 20);

%% -------------------------------------------------------------------------------------------------------
%% -------------------------------------------------------------------------------------------------------
%% -------------------------------------- plot radial average for individual colonies
xValues = (bins(1:end-1)+bins(2:end))./2 ;
timePoints1 = [1:45];
toUse = {[1:10], [10:20], [20:36], [36:45]};

for ii = 1:10 %colony  number
    
    for tt = 1:4 %time
        timePointsToUse = timePoints1(toUse{tt});
        legendLabels = strsplit(int2str(2+timePointsToUse), ' ');
        figure; hold on;
        for jj = timePointsToUse
            if jj == timePoints1(end)
                plot(xValues, rA_colonies1_norm(jj,:,ii), 'Color', [0.7 0 0], 'LineWidth', 3);
            else
                plot(xValues, rA_colonies1_norm(jj,:,ii), 'Color', colors(jj,:), 'LineWidth', 3);
            end
        end
        
        threshold = min(rA_all_norm(end,:)) + 0.5*(max(rA_all_norm(end,:))-min(rA_all_norm(end,:)));
        plot([0 400], [threshold threshold], 'k:', 'LineWidth', 2);
        
        xlim([0 400]); ylim([0.1 1.1]); legend(legendLabels); title(['Colony' int2str(ii)]);
        xlabel('Distance from edge (\mum)'); ylabel('radialAverage');
        ax = gca;
        ax.FontSize = 12; ax.FontWeight = 'bold';
    end
end

%%