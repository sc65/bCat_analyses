%%
%% making colony nuclear masks from ilastik segmentation
saveInPath = '/Volumes/SAPNA/171003_LiveCell_bCat/colonyMasks';
mkdir(saveInPath);

filePath = '/Volumes/SAPNA/171003_LiveCell_bCat/fullColonies_t32';
files = dir([filePath filesep '*.h5']);

%%
for ii = 8
%for ii = 1:numel(files)
    ii
    file1 = readIlastikFile([filePath filesep 'Colony' int2str(ii) '_t32_Simple Segmentation.h5']); 
    stats = regionprops(file1, 'Area', 'PixelIdxList');
    allArea = [stats.Area];
    
    largest = find(allArea == max(allArea));
    image2 = bwlabel(file1);
    image2(image2~=largest) = 0;
    image2 = imbinarize(image2);
    image2 = imfill(image2, 'holes');   
    
    figure; imshow(image2);
    imwrite(image2, [saveInPath filesep 'Colony' int2str(ii) '.tif']);
end
%%

