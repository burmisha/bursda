function SnakeSegmentation(DataPath,SegResultsSubPath)

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
    [xs ys] = getsnake(image);
	% you should tune this parameter here
    alpha = ...;
	% you should tune this parameter here
    beta = ...;
    gamma = 1;
	% you should tune this parameter here
    kappa = ...;
    wl = 0.3;
    we = 0.4;
    wt = 0.7;
	% you should tune this parameter here
    iterations = ...;
    SegImage = iterate(image, xs, ys, alpha, beta, gamma, kappa, wl, we, wt, iterations);
    imshow(SegImage);
    disp('Press Enter...');
    pause;
    
	imwrite(SegImage, fullfile(ResultSubfolder, 'result.jpg'))
end;
end