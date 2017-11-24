%%
%%
% save brightfield images for individual colonies

rawImagesPath = '/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging/compositeColonyImages';
newImagesPath = '/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging/brightField_Images';

channel = 3;
timepoint = 20;

for ii = 1:10
    rawImage1 = [rawImagesPath filesep 'Colony', int2str(ii) '.tif'];
    reader = bfGetReader(rawImage1);
    iPlane = reader.getIndex(1-1, channel-1, timepoint-1)+1;
    rawImage1 = bfGetPlane(reader, iPlane);
    newImage1 = [newImagesPath filesep 'Colony' int2str(ii) '.tif'];
    
    imwrite(rawImage1,newImage1);
end
