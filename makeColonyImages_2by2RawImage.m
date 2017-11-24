%% aligning a 2*2 LSM image

clearvars;

colonyIds = [3 16];
timePoints = 4;

rawFilesPath = '/Volumes/SAPNA/171120_liveCell_bCat_notWork/171119_bCatLiveCell2';
newFilesPath = '/Volumes/SAPNA/171120_liveCell_bCat_notWork/alignedImages2';
mkdir(newFilesPath);

channelOrder = [2 1]; 
%[RFP GFP brightfield], start with the channel used for aligning images -
%usually the nuclear channel.
%%
for colony = colonyIds(1:end)
%for colony = 1:nColonies
    colony
    imageNumbers = 4* (colony-1)+1:4*(colony-1)+4;
    rowImages = cell(1,2);
    rowShift = [0 0 0];
    colShift = rowShift;
    maxOverlap = 140;
    %%
    for ii = 1:timePoints
        for jj = 1:2 % 2 horizontal alignments
            if jj == 1
                imageNumbers1 = imageNumbers(1:2);
            else
                imageNumbers1 = imageNumbers(3:4);
            end
            
            %%
            %image1 = rgb image starting with nuclear channel for timepoint ii, imageNumbers1(1)
            %image2 = rgb image starting with nuclear channel for timepoint ii, imageNumbers1(2)
            
            image11 = dir([rawFilesPath filesep sprintf('Track%04d', imageNumbers1(1)) filesep '*.oif']);
            image1_reader = bfGetReader([rawFilesPath filesep sprintf('Track%04d', imageNumbers1(1)) ...
                filesep image11(ii).name]);
            image1 = MakeMaxZImage(image1_reader, channelOrder, 1);
            
            image11 = dir([rawFilesPath filesep sprintf('Track%04d', imageNumbers1(2)) filesep '*.oif']);
            image2_reader = bfGetReader([rawFilesPath filesep sprintf('Track%04d', imageNumbers1(2)) ...
                filesep image11(ii).name]);
            image2 = MakeMaxZImage(image2_reader, channelOrder, 1);
            
            
            if ii == 1
                [rowImages{jj}, rowShift(jj), colShift(jj)] = alignTwoImagesFourier_multiChannel(image1, image2, 4, maxOverlap); %align left right
            else
                rowImages{jj}   = applyImageAlignment(image1, image2, 4,  rowShift(jj), colShift(jj));
            end
        end
        %% vertical alignment
        if ii == 1
            [alignedImage, rowShift(3), colShift(3)] = alignTwoImagesFourier_multiChannel(rowImages{1}, rowImages{2}, 1, maxOverlap); %align top bottom
        else
            alignedImage = applyImageAlignment(rowImages{1}, rowImages{2}, 1,  rowShift(3), colShift(3));
        end
        
        %% writing Image
        if ii == 1
            numRows = size(alignedImage,1);
            numCols = size(alignedImage,2);
        end
        
         data = alignedImage;
%         data = data(:,:,2);
% %         
%        %-----to write a 3 channel multi-time image
        if size(data,3) == 2
            data = cat(3, data, zeros(numRows, numCols));
        elseif size(data,3) > 3
            data = data(:,:,1:3); % only an rgb image can be written with imwrite.       
        end         
        if ii == 1
            newFile = [newFilesPath filesep 'Colony' int2str(colony) '.tif'];
            imwrite(data, newFile);     
        else
            imwrite(data, newFile, 'WriteMode', 'append');
        end
%         
        %-----to write a 4channel, 1 timepoint image
%         saveInPath = [newFilesPath filesep 'Colony_' int2str(colony) '.tif'];
%         writeMultiTiff(data, saveInPath);
        
        
    end
end
%%














