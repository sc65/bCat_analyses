
%% for making colony masks, separate one time point (when colonies are full) 
% in bCat channel(less debris) for all colonies.

saveInPath = '/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging/colonies_25h';
mkdir(saveInPath);
timePoint = 25;

imagesPath = '/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging/compositeColonyImages';
images = dir([imagesPath filesep 'Colony' '*.tif']);

for ii = 1:numel(images)
    ii
    reader = bfGetReader([images(1).folder filesep 'Colony' int2str(ii) '.tif']);
    
    imagePlane = reader.getIndex(1-1, 2-1, timePoint-1)+1; %[zPlane channel timePoint]
    image1 = bfGetPlane(reader, imagePlane);
    
    imwrite(image1, [saveInPath filesep 'Colony' int2str(ii) '_' int2str(timePoint) '.tif']);
end
    