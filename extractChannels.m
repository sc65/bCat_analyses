
%% make a sub movie from a movie, e.g: extract only one channel from a multiChannel movie.
rawImagesPath = '.';
newImagesPath = rawImagesPath;

channel = 1; % channel to be extracted.
timePoints = 1:1;

for ii = 5
    rawImage1 = [rawImagesPath filesep 'Colony', int2str(ii) '.tif'];
    reader = bfGetReader(rawImage1);
    newImage1 = [newImagesPath filesep 'Colony' int2str(ii) '_ch' int2str(channel) '.tif'];
    
    for jj = timePoints
        iPlane = reader.getIndex(1-1, channel-1, jj-1)+1;
        rawImage1 = bfGetPlane(reader, iPlane);
        
        if jj == 1
            imwrite(rawImage1,newImage1);
        else
            imwrite(rawImage1, newImage1, 'WriteMode', 'append');
        end
        
    end
end

