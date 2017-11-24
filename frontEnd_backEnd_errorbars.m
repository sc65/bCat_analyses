%%
% combine front and back end

tStart = 1;
frontEnd_colonies1 = frontEnd(tStart:end,[1:6 8:10]);
frontEnd_avg = frontEnd(tStart:end,end);
%%
std_error = zeros(size(frontEnd_avg,1), 1); std_dev = std_error;
for ii = 1:size(frontEnd_avg,1)
std_dev(ii,1) = sqrt(sum((frontEnd_colonies1(ii,:)- frontEnd_avg(ii)).^2)./(8));
std_error(ii,1) = std_dev(ii,1)/3;
end
%%
figure; errorbar(t1(tStart:end), frontEnd_avg', std_error');
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
hold on;
errorbar(t1(tStart:end), backEnd_avg, std_error2);
%%
hold on;
