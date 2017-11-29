%%
% combine front, back end and linear fit.
tStart = 1;
frontEnd = squeeze(highPosition(:,2,:)); 
frontEnd_colonies1 = frontEnd(tStart:end,[1:6 8:10]);
frontEnd_avg = frontEnd(tStart:end,end);
%%
std_error = zeros(size(frontEnd_avg,1), 1); std_dev = std_error;
for ii = 1:size(frontEnd_avg,1)
std_dev(ii,1) = sqrt(sum((frontEnd_colonies1(ii,:)- frontEnd_avg(ii)).^2)./(8));
std_error(ii,1) = std_dev(ii,1)/3;
end
%%
backEnd = squeeze(highPosition(:,1,:)); %get the position of the front end for all colonies all timepoints.
backEnd_colonies1 = backEnd(tStart:end,[1:6,8:10]);
backEnd_avg = backEnd(tStart:end, end);
%%
std_error2 = zeros(size(backEnd,1),1); std_dev2 = std_error2;
for ii = 1:size(backEnd,1)
std_dev2(ii,1) = sqrt(sum((backEnd_colonies1(ii,:)- backEnd_avg(ii)).^2)./(8));
std_error2(ii,1) = std_dev2(ii,1)/3;
end
%%
frontEnd_avg1 = frontEnd_avg(24:end,1);
x1 = t1(24:end);

[m, ~] = polyfit(x1, frontEnd_avg1',1);
f = polyval(m,x1);

%% --- plot
figure;  hold on;
tStart1 = 1;
plot(t1(tStart1:end), frontEnd_avg(tStart1:end,:)', ...
    'Color', [0 0.6 0], 'LineWidth', 5);
errorbar(t1(tStart1:end), frontEnd_avg(tStart1:end,:)', std_dev(tStart1:end, :)', ...
    'Color', [0 0.6 0], 'LineWidth', 1);


plot(t1(tStart1:end), backEnd_avg(tStart1:end,:)', ...
    'Color', [0 0 0.6], 'LineWidth', 4);
errorbar(t1(tStart1:end), backEnd_avg(tStart1:end,:)', std_dev2(tStart1:end, :)', ...
    'Color', [0 0 0.6], 'LineWidth', 1);
% 
%plot(x1, f, 'm-', 'LineWidth', 2, 'Marker', '*', 'Color', 'm');
%%
xlabel('time (h)');
ylabel('Distance from the edge (\mum)');
ax = gca; ax.FontSize = 16; ax.FontWeight = 'bold';

