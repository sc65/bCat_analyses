function bins = getBinEdgesConstantArea(radius, outerBin)

%% given the width of the outermost bin and radius of the colony, 
% this function returns the binEdges for calculating radial average. 
% Bin edges are calculated such that bin area is constant across all bins. 

bins = zeros(1,10);
bins(1:2) = [radius radius-outerBin];
%%
a = bins(2);
b = bins(1);
counter = 3;

c = b;
while c>1
    c = sqrt(2*a^2 - b^2);
    bins(counter) = c;
    counter = counter+1;
    
    b = a;
    a = c;
end
%%
bins = real(bins); %last value has an imaginary component.
bins = radius-bins; %returns distance from edge

if bins(end)<radius-outerBin 
    bins = [bins radius];
end