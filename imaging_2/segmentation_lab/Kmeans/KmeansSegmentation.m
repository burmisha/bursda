function KmeansSegmentation(DataPath,SegResultsSubPath)

ImageSubfolders =['1'...   %image subfolders
                  '2'...
				  '3'...
                  '4'];

for i=1:length(ImageSubfolders)
    ResultSubfolder = fullfile(DataPath, ImageSubfolders(i), SegResultsSubPath);
    if exist(ResultSubfolder)
        rmdir(ResultSubfolder, 's');
    end
    mkdir(ResultSubfolder)
    image = rgb2gray(imread(fullfile(DataPath, ImageSubfolders(i), 'src.png')));
    imshow(image);
    disp('Press Enter...');
    pause;
	SegImage = kmeans(image, 2);
    imshow(SegImage);
    disp('Press Enter...');
    pause;
	imwrite(SegImage, fullfile(ResultSubfolder, 'result.jpg'))
end;
end