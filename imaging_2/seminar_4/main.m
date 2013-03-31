clear all;

run('../vlfeat/toolbox/vl_setup')

% im = imread('Zebra_Kruger.jpg');
% im = imread('Zebra-Resimleri5-300x230.jpg');
im = imread('91010177_large_MTS_Blaggiii1244376picture6.jpg');
w = size(im,1);
h = size(im,2);

regionSize = 40 ;
regularizer = 500 ;
imlab = vl_xyz2lab(vl_rgb2xyz(im));
segments = vl_slic(im2single(imlab), regionSize, regularizer);
mask = -ones([w,h] + [2,2]);
mask(2:(w+1),2:(h+1)) = segments;
%%

lines = ones(size(im))*255;
for i=2:(w+1)
    for j=2:(h+1)
        if (mask(i,j) ~= mask(i+1,j)) || (mask(i,j) ~= mask(i-1,j)) || (mask(i,j) ~= mask(i,j+1)) || (mask(i,j) ~= mask(i,j-1))
           lines(i-1,j-1,:) = [0, 0, 0];
        end
    end
end


size(segments)
max(max(segments))
min(min(segments))
imshow(lines)

%% 
% idea: people change poiniins soon
% robots give multiple deals
% one market sets the price to the second: build regression