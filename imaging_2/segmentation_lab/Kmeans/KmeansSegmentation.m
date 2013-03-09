function KmeansSegmentation(DataPath,SegResultsSubPath)
ImageSubfolders =['1', '2', '3', '4'];

for i=1:length(ImageSubfolders)
    ResultSubfolder = fullfile(DataPath, ImageSubfolders(i), SegResultsSubPath);
    if exist(ResultSubfolder)
        rmdir(ResultSubfolder, 's');
    end
    mkdir(ResultSubfolder)
    image = rgb2gray(imread(fullfile(DataPath, ImageSubfolders(i), 'src.png')));
    % imshow(image);
    SegImage = kmeans(image, 2);
    % imshow(SegImage);
    imwrite(SegImage, fullfile(ResultSubfolder, 'result.jpg'))
end;
end