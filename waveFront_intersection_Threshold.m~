%% Characterising the movement of active Wnt response domain - position & rate of movement

rA_all_norm = rA_all_new./max(max(rA_all_new));
rA_error1_norm = rA_stdError./max(max(rA_all));
rA_colonies1_norm = rA_colonies1./max(max(rA_all));

rA_norm_colonies_avg  = cat(3, rA_colonies1_norm, rA_all_norm); %(t, bin, [colonies1-10 average]);
binValues = (bins(1:end-1)+bins(2:end))./2 ;
t1 = 3:47;
%% ------------------- find the intersection points of the wave front
L1 = [binValues; threshold*ones(1,21)];
highPosition = zeros(45,3,11); % sometimes there are three intersection points.
for ii = 1:11
    values = rA_norm_colonies_avg(:,:,ii);
    for jj = 1:45
        L2 = [binValues; values(jj,:)];
        p = InterX(L1,L2);
        
        if ~isempty(p)
            nColumns =  size(p,2);
            highPosition(jj,[1:nColumns],ii) = round(p(1,:));
        end
    end
end
%% ------------------ plot back and front end of all colonies.
colors = {[0 0 0.6], [0 0.6 0], [0.6 0 0]};
toPlot = [1 2]; %[back front1 front2].

figure; hold on;
labels = [strcat('Colony', strsplit(int2str([1:9]),' ')), 'coloniesAverage'];

for ii = 1:10
    subplot(3,4,ii); hold on;
    
    values_colony1 = highPosition(:,[toPlot],ii);
    %values_colony1 = values_colony1(any(values_colony1,2), 1:2);
    nElements = size(values_colony1,1);
    t1_colony1 = t1(numel(t1)-nElements+1 : end);
    
    for jj = 1:numel(toPlot)
        plot(t1_colony1, values_colony1(:,toPlot(jj)),  'Color', colors{jj}, 'LineWidth', 2);
        title(labels(ii));
        xlim([1 50]); ylim([0 400]);
        xlabel('Time(h)'); ylabel('Distance from edge(\mum)');
        ax = gca; ax.FontSize = 12; ax.FontWeight = 'bold';
    end
    
end
%%
frontEnd = squeeze(highPosition(:,2,:)); %get the position of the front end for all colonies all timepoints.
frontEnd_21 = frontEnd(21:end,:);
x21 = t1(21:end);
c1 = rand(11,3); %colors
c1(end,:) = [0 0.5 0]; %for the coloniesAverage
%% %% ------------------------- plot1 -average and individual colonies: position of front end of wavefront at different times
figure; hold on;
labels = [strcat('Colony', strsplit(int2str([1:6 8:10]),' ')), 'coloniesAverage'];

for ii = 1:11
    front_colony1 = frontEnd_21(:,ii);
    front_colony1 = front_colony1(any(front_colony1,2), 1);
    
    nElements = size(front_colony1,1);
    x21_colony1 = x21(numel(x21)-nElements+1 : end);
    
    if ii<11
        plot(x21_colony1, front_colony1,  'Color', c1(ii,:), 'LineWidth', 2);
    else
        plot(x21_colony1, front_colony1, 'Marker', '*', 'MarkerSize', 10, 'Color', c1(ii,:), 'LineWidth', 6);
    end
end
legend(labels);
xlim([20 50]); ylim([0 400]);
xlabel('Time(h)'); ylabel('Distance from edge(\mum)');
ax = gca; ax.FontSize = 12; ax.FontWeight = 'bold';

%% ----------------------------------------plot2-average and individual colonies: speed at different times
% start with the position of the second positive number in every column.

frontEnd_21_speed = diff(frontEnd_21);

figure; hold on;
for ii = [11]
    p1 = find(frontEnd_21_speed(:,ii) > 0);
    displacement_colony1 = frontEnd_21_speed(p1(2):end,ii);
    
    nElements = size(displacement_colony1,1);
    x21_colony1 = x21(numel(x21)-nElements+1 : end);
    
    if ii <11
        plot(x21_colony1, displacement_colony1,  'Color', c1(ii,:), 'LineWidth', 2);
    else
        plot(x21_colony1, displacement_colony1, 'Marker', '*', 'MArkerSize', 8, 'Color', c1(ii,:), 'LineWidth', 4);
    end
end

legend(labels);
xlim([20 50]); ylim([-52 45]);
xlabel('Time(h)'); ylabel('Displacement(\mum)');
ax = gca; ax.FontSize = 12; ax.FontWeight = 'bold';


%% fitting the wavefront position of average radial average to a linear function
front_colonyAvg = frontEnd_21(4:end,11);
front_colonyAvg = front_colonyAvg(any(front_colonyAvg,2), 1);
nElements = size(front_colonyAvg,1);
x21_colonyAvg = x21(numel(x21)-nElements+1 : end);

[m, ~] = polyfit(x21_colony1, front_colonyAvg',1);
f = polyval(m,x21_colony1);

figure; plot(x21_colonyAvg, front_colonyAvg, 'Marker', '*', 'MarkerSize', 10, 'Color', [0 0.6 0], 'LineWidth', 3);
hold on;
plot(x21_colonyAvg, f, 'r-', 'LineWidth', 2);
xlim([25 50]); ylim([150 330]);
xlabel('Time(h)'); ylabel('Distance from edge(\mum)');
ax = gca; ax.FontSize = 12; ax.FontWeight = 'bold';

%%















