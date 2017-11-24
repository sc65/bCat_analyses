%%
% starting analyses of live cell data.
% make max z projections, combining all time points for every position.
% start with position1.
totalPositions = 40; % number of positions imaged.
rawFilesPath = '/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging/FV10__20171008_185839';
newFilesPath = '/Volumes/SAPNA/171010_bCat_reporterCells_liveCellImaging/movies1'; %path where multi-tiff images for each position are saved.
mkdir(newFilesPath);
%%
tic;
mkdir(newFilesPath);
for ii = 1:totalPositions
    ii
    filesToRead = dir([rawFilesPath filesep sprintf('Track%04d', ii) filesep '*.oif']);
    
    for jj = 1:numel(filesToRead)
        file1 = [filesToRead(1).folder filesep filesToRead(jj).name];
        
        % making max_z intensity images for each timepoint.
        filereader = bfGetReader(file1);
        channels = 1:filereader.getSizeC;
        
        maxIntensityImage = MakeMaxZImage(filereader, channels, 1);
        if size(maxIntensityImage,3) < 3
            data = cat(3, data, zeros(numRows, numCols));
        end
        
        newFileName = ['Track' int2str(ii) '.tif'];
        if jj == 1
            imwrite(maxIntensityImage, [newFilesPath filesep newFileName]);
        else
            imwrite(maxIntensityImage, [newFilesPath filesep newFileName], 'writemode', 'append', 'Compression','none');
        end
        
    end
end
toc;