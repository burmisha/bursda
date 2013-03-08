function [SegImage] = kmeans(Image, k)

% create image histogram

ImgHist = zeros(256,1);
for i=1:256
	ImgHist(i)= sum(sum(Image == (i - 1)));
end;

ClosestCentroids = zeros(256,1);


% initiate centroids
Centroids = (1:k) * 255 / (k+1);

% start kmeans iterations
while(true)
  OldCentroids = Centroids;
  % you should assign closest centroids labels here  
  ...
  % you should recalculate centroids here
  ...
  % stop if converge
  if(Centroids == OldCentroids)
      break;
  end;
end

% calculate segmented image
SegImage = zeros(size(Image));
for i=1:size(Image, 1)
    for j=1:size(Image, 2)
      distances = abs(double(Image(i,j)) - Centroids);
      closest = find(distances == min(distances));  
      SegImage(i,j) = 255 * (closest(1) - 1);
    end
end
imshow(SegImage);
