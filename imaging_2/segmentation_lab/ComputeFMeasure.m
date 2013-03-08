function [Results]=ComputeFMeasure(DataPath,SegResultsSubPath)
%Compute the F-measure for a single segment
%Syntax:
%       [Results]=ComputeFMeasure(DataPath,SegResultsSubPath)
%Input:
%       DataPath - The directory of the entire evaluation Database
%       SegResultsSubPath - The name of the sub-directory  in which the results of
%                           the algorithm to be evaluated  are placed.
%Output:
%       Results - An N * 3 matrix where N is the number of test images,
%                 Results(i,1) holds the best F-score for a segmentation of i-th image.
%                 Results(i,2) and Results(i,3) holds the corresponding Recall and Precision scores.


ImageSubfolders =['1'...   %image subfolders
                  '2'...
				  '3'...
                  '4'];

Results = zeros(length(ImageSubfolders),3);

for i=1:length(ImageSubfolders)
    Hmask=GetHumanSeg(fullfile(DataPath, ImageSubfolders(i), 'human_seg'));
    fprintf('Working on image:%s\n', ImageSubfolders(i)); 
    [Pmax Rmax Fmax]= CalcScore(fullfile(DataPath, ImageSubfolders(i), SegResultsSubPath),Hmask);
    Results(i,1)=Fmax;
    Results(i,2)=Rmax;
    Results(i,3)=Pmax;
end;
fprintf('Average F-measure:%f\n', mean(Results(:,1)));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Get the Human binary segmentation                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [mask]=GetHumanSeg(path)
% Get the human segmentation by considering the votes from each human
% subject
files=dir(path);
for k=1:length(files)
    if (files(k).isdir)
        continue;
    end;
    im=im2double(imread(fullfile(path, files(k).name)));
    if (exist('mask','var'))
        mask = mask + double((im(:,:,1) == 1) & (im(:,:,2) == 0));
    else
        mask = double((im(:,:,1) == 1) & (im(:,:,2) == 0));
    end;
end;
if (~exist('mask') || max(mask(:)) < 2)
    error('Error reading human segmentations please check path.');
end;
mask = mask >= 2;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Calcuate the F-score                                     %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [p r f]=CalcPRPixel(groundtruth, mask)
    if (sum(groundtruth(:) & mask(:)) == 0)
        p=0; r=0; f=0;
        return;
    end;
    r = sum(groundtruth(:) & mask(:)) ./ sum(groundtruth(:));
    c = sum(mask(:)) - sum(groundtruth(:) & mask(:));
    p = sum(groundtruth(:) & mask(:)) ./ (sum(groundtruth(:) & mask(:)) + c);
    f = (r*p)/(0.5*(r+p));
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             Calcuate the F-score of the evaluated method             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [Pmax Rmax Fmax]=CalcScore(SegPath,HumanSeg)

Fmax = 0;
Pmax = 0;
Rmax = 0;
files = dir(SegPath);
for i=1:length(files); %Go over all segmentations in the folder
    if (files(i).isdir)
        continue;
    end;
 
   Segmap=imread(fullfile(SegPath, files(i).name));
   NumOfSegs=unique(Segmap(:)); %find out how many segments
   
   for j=1:length(NumOfSegs) %Go over all segments in the image
             t=(Segmap == NumOfSegs(j));
             if sum(t(:)) <= 5
                 continue; %skip small segments
             end; 
             [p r f]=CalcPRPixel(t,HumanSeg);
             if (f > Fmax)
                 Fmax=f;
                 Pmax=p;
                 Rmax=r;
             end;
             
   end;      
end;
end


