function [rA, nPixels] =   radialAverageOneColonyOnetimePoint_nonMembrane(colonyMask, membraneMask, colonyImage, bins)

dists = bwdist(~colonyMask); % distance from the edges;
dists = dists*0.621; % convert into microns
rA = zeros(1,numel(bins)-1);
nPixels = rA;
%%
for kk = 1:numel(bins)-1
    idx = find(dists>bins(kk) & dists<bins(kk+1));
    nonMembrane = membraneMask(idx)==0;
    idx2 = idx(nonMembrane);
    rA(kk) = mean(colonyImage(idx2));
    nPixels(kk) = numel(idx2);
end
