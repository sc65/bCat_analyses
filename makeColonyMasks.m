%%
%% make colony  masks from ilastik segmentation
saveInPath = '/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging/colonyMasks';
mkdir(saveInPath);

filePath = '/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging/colonies_25h';
files = dir([filePath filesep '*.h5']);
%%
%for ii = [5 6]
for ii = 1:numel(files)
    ii
    file1 = readIlastikFile([filePath filesep 'Colony' int2str(ii) '_25_Simple Segmentation.h5']); 
    stats = regionprops(file1, 'Area', 'PixelIdxList');
    allArea = [stats.Area];
    
    largest = find(allArea == max(allArea));
    image2 = bwlabel(file1);
    image2(image2~=largest) = 0;
    image2 = imbinarize(image2);
    image2 = imfill(image2, 'holes'); 
    
    figure; imshow(image2);
    title(['Colony' int2str(ii)]);
    imwrite(image2, [saveInPath filesep 'Colony' int2str(ii) '.tif']);
end
%%

