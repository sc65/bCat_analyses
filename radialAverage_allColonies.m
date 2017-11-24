%%
% Calculating radial average across different colonies, different
% timepoints.
clearvars;
radius = 400;
outerBin = 10;
bins = getBinEdgesConstantArea(radius, outerBin);

timePoints = 45;

coloniesToUse = [1:6 8:10];
nColonies = numel(coloniesToUse);

rA_colonies1 = zeros(timePoints,  numel(bins)-1, nColonies); % stores rA in individual colonies for all timepoints.
rA_all_new = zeros(timePoints, numel(bins)-1); rA_error1_new = rA_all_new; rA_error2 = rA_all_new; % stores average rA across different colonies at every timepoint

masterFolder = ['/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging'];

for ii = 1:timePoints
    tic;
    ii
    rA=zeros(1,round(5000/outerBin)); rA2=rA; counter=rA; % calculate radial average for every timepoint
    
    for jj = coloniesToUse % loop over timePoints
        colonyMask = imread([masterFolder filesep 'colonyMasks/Colony' int2str(jj) '.tif']);
        membraneMask1 = readIlastikFile([masterFolder filesep 'compositeColonyImages/Colony' int2str(jj) ...
            '_Simple Segmentation.h5']);
        rawImagePath = [masterFolder filesep 'compositeColonyImages/Colony' int2str(jj) '.tif'];
        
        reader = bfGetReader(rawImagePath);
        iPlane = reader.getIndex(1-1, 2-1, ii-1)+1;
        rawImage1 = bfGetPlane(reader, iPlane);
        rawImage1 = SmoothAndBackgroundSubtractOneImage(rawImage1);
        membraneMask1 = membraneMask1(:,:,ii);
        
        [rA1, nPixels]=radialAverageOneColonyOnetimePoint_nonMembrane(colonyMask, membraneMask1, rawImage1, bins);
        npoints=length(rA1);
        if npoints > length(rA)
            continue;
        end
        rA(1,1:npoints)=rA(1,1:npoints)+rA1.*nPixels;
        rA2(1,1:npoints)=rA2(1,1:npoints)+rA1.*rA1.*nPixels;
        counter(1,1:npoints)=counter(1:npoints)+nPixels;
        
        rA_colonies1(ii,:,jj)=rA1;
    end
    
    rA=rA./counter;
    rA2=rA2./counter;
    rAerr1=sqrt(rA2-rA.*rA);%standard deviation
    rAerr2=rAerr1./sqrt(counter); % standard error over pixels 
    badinds=isnan(rA);
    rA(badinds)=[]; rAerr1(badinds)=[]; rAerr2(badinds)=[];
    
    rA_all_new(ii,:) = rA; rA_error1_new(ii,:) = rAerr1; rA_error2(ii,:) = rAerr2;
    toc;
end

%% ------------------ plotting --------------------
%% heat map for average radial average across all colonies
figure;
rA_all_norm = rA_all_new./max(max(rA_all_new));
 radialAverage1 = rA_all_norm';
 radialAverage1 = flipud(radialAverage1);
imagesc(radialAverage1); caxis([0 1.0]);
ylabel('Distance from edge (\mum)');
xlabel('Time(h)');

ax = gca;
x1= linspace(3,47,10); %On the Y axis, go down up.
ax.XTickLabel = floor(x1(2:end));
ax.YTickLabel = fliplr(floor(bins([2:2:20])));
ax.FontSize = 13;
ax.FontWeight = 'bold';

%% heat map for individual colonies' radial average.
nColonies = 10;
%rA_colonies1_norm = rA_colonies1./max(max(rA_all));

for ii = 1:10
    radialAverage1 = rA_colonies1(:,:,ii);
    radialAverage1 = radialAverage1';
    radialAverage1 = flipud(radialAverage1);
    
    figure; imagesc(radialAverage1); colorbar; caxis([100 900]);
    title(['Colony' int2str(ii)]);
    ylabel('Distance from edge (\mum)');
    xlabel('Time(h)');
    
    ax = gca;
    x1= linspace(3,47,10); %On the Y axis, go down up.
    ax.XTickLabel = floor(x1(2:end));
    ax.YTickLabel = fliplr(floor(bins([2:2:20])));
    ax.FontSize = 13;
    ax.FontWeight = 'bold';
end
%%
save('output.mat', 'rA_all', 'rA_error1', 'rA_error2', 'rA_colonies1', 'bins');













