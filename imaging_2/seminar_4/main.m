clear all;

run('../vlfeat/toolbox/vl_setup')

% im = imread('Zebra_Kruger.jpg');
% im = imread('Zebra-Resimleri5-300x230.jpg');
im = imread('91010177_large_MTS_Blaggiii1244376picture6.jpg');
% im = imread('lena_std.tif');
w = size(im,1);
h = size(im,2);
%%
regionSize = 20 ;
regularizer = 80;
imlab = vl_xyz2lab(vl_rgb2xyz(im));
segments = vl_slic(im2single(imlab), regionSize, regularizer)+1;
m = -ones([w,h] + [2,2]);   m(2:(w+1),2:(h+1)) = segments;
a = 2:(w+1);                b = 2:(h+1);
border = (m(a,b) ~= m(a-1,b)) + (m(a,b) ~= m(a+1,b)) + (m(a,b) ~= m(a,b-1)) + (m(a,b) ~= m(a,b+1));
border = repmat(border,[1 1 3]);
% imshow(double(im) .* double(border == 0)/255);
imshow(double(border == 0));
%% 
SegNum=max(max(segments));
meanColor=zeros(SegNum,3);
R = im(:,:,1);  G = im(:,:,2);  B = im(:,:,3);
RR = R * 0;     GG = G * 0;     BB = B * 0;
for i=1:SegNum
    idx = segments==i;
    r = mean(R(idx));   g = mean(G(idx));   b = mean(B(idx));
    RR(idx) = r;        GG(idx) = g;        BB(idx) = b;
    meanColor(i,:) = [r,g,b];
end
im_colored(:,:,1) = RR;     im_colored(:,:,2) = GG;     im_colored(:,:,3) = BB;
% imshow(abs(im_colored - im))
im_colored=round(im_colored);
imshow(im_colored)

%%

s = regionprops(segments, 'Centroid');
DataToInterp=[Centers, meanColor];
DataToInterp = DataToInterp(~any(isnan(DataToInterp),2),:);
Centers = cat(1, s.Centroid);
[xq,yq] = meshgrid(1:w, 1:h);
method = 'linear'; % 'linear', 'cubic', 'natural','nearest','v4'
im_int(:,:,1) = griddata(Centers(:,1),Centers(:,2),meanColor(:,1),xq,yq,method);
im_int(:,:,2) = griddata(Centers(:,1),Centers(:,2),meanColor(:,2),xq,yq,method);
im_int(:,:,3) = griddata(Centers(:,1),Centers(:,2),meanColor(:,3),xq,yq,method);
imshow(im_int/255)