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
    alpha = 1;    % alpha: Controls tension
    beta = 4;     % beta: Controls rigidity
    gamma = 1;      % gamma: Step size
    kappa = 0.6;    % kappa: Controls enegry term
    % wl, we, wt: Weights for line, edge and terminal energy components
    wl = 0.3;
    we = 0.6;
    wt = 0.7;
	% you should tune this parameter here
    iterations = 100;
    SegImage = iterate(image, xs, ys, alpha, beta, gamma, kappa, wl, we, wt, iterations);
    imshow(SegImage);
    disp('Press Enter...');
    %pause;
    
	imwrite(SegImage, fullfile(ResultSubfolder, 'result.jpg'))
end;
end