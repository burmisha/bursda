function SnakeSegmentation(DataPath,SegResultsSubPath)

% ImageSubfolders = ['1', '2', '3', '4'];
ImageSubfolders = ['3'];
for i=1:length(ImageSubfolders)
    ResultSubfolder = fullfile(DataPath, ImageSubfolders(i), SegResultsSubPath);
    if exist(ResultSubfolder)
        rmdir(ResultSubfolder, 's');
    end
    mkdir(ResultSubfolder)
    
    image = rgb2gray(imread(fullfile(DataPath, ImageSubfolders(i), 'src.png')));
    %disp('Press Enter...');
    %pause;
    [xs ys] = getsnake(image);
	% you should tune this parameter here
    alpha = 0.2;
	% you should tune this parameter here
    beta = 0.2;
    gamma = 1;
	% you should tune this parameter here
    kappa = 0.5;
    wl = 0.3;
    we = 0.4;
    wt = 0.7;
	% you should tune this parameter here
    iterations = 150;
    SegImage = iterate(image, xs, ys, alpha, beta, gamma, kappa, wl, we, wt, iterations);
    imshow(SegImage);
    disp('Press Enter...');
    %pause;
    
	imwrite(SegImage, fullfile(ResultSubfolder, 'result.jpg'))
end;
end