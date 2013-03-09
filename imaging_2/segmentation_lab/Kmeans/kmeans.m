function [SegImage] = kmeans(Image, k)

% create image histogram

ImgHist = zeros(256,1);
for i=1:256
    ImgHist(i)= sum(sum(Image == (i - 1)));
end;

ClosestCentroids = zeros(256,1);
% initiate centroids
Centroids = (1:k) * 255 / (k+1);
weighs = 0:255;
% start kmeans iterations
while(true)
    OldCentroids = Centroids;
    for i=1:256
        [~, ClosestCentroids(i)] = min(abs(i - 1 - Centroids));
    end
    for i=1:k
        idx = (ClosestCentroids == i);
        Centroids(i) = round(weighs(idx) * ImgHist(idx) / sum(ImgHist(idx)));
    end
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
% imshow(SegImage);
end
