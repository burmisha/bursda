clear all;

run('../vlfeat/toolbox/vl_setup')

% im = imread('Zebra_Kruger.jpg');
% im = imread('Zebra-Resimleri5-300x230.jpg');
% im = imread('91010177_large_MTS_Blaggiii1244376picture6.jpg');
im = imread('lena_std.tif');
w = size(im,1);
h = size(im,2);
%%
regionSize = 35 ;
regularizer = 2;
imlab = vl_xyz2lab(vl_rgb2xyz(im));
segments = vl_slic(im2single(imlab), regionSize, regularizer);
m = -ones([w,h] + [2,2]);   m(2:(w+1),2:(h+1)) = segments;
a = 2:(w+1);                b = 2:(h+1);
border = (m(a,b) ~= m(a-1,b)) + (m(a,b) ~= m(a+1,b)) + (m(a,b) ~= m(a,b-1)) + (m(a,b) ~= m(a,b+1));
border = repmat(border,[1 1 3]);
% imshow(double(im) .* double(border == 0)/255);
imshow(double(border == 0));
%% 
% idea: people change poiniins soon
% robots give multiple deals
% one market sets the price to the second: build regression