% for i=4
%     I = imread(sprintf('../data/%d/src.png', i));
%     kmeans(rgb2gray(I),2);
%     %imshow(I)
% end

KmeansSegmentation('../data/', 'kmeans')