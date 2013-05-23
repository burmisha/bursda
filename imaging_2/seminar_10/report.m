clear all
im1 = rgb2gray(imread('tsukuba1.png'));
im2 = rgb2gray(imread('tsukuba2.png'));

disp_window = -20:20;
mask_window = 3; % window

h = size(im1,1);
w = size(im1,2);
%%
cut = @(x, l, r) [zeros(1,min(max(1-l,0),r-l+1)), x(max(1,l):min(length(x),r)), zeros(1,max(r-length(x),0))];
% dist = @(x, y) sum((x - y).^2);
% zeros(1,max([1+2,0,]))
cut(1,-2,3)
%%
Disparity = zeros(h, w);
for r = 1:h
    Dist = zeros(length(disp_window), w);
    for j = 1:length(disp_window)
        d = disp_window(j);
        line_2 = cut(im1(r,:), 1+d, w+d);
        Dist(j,:) = conv((im1(r,:) - line_2).^2, -mask_window:mask_window, 'same');
    end
    [~,d_idx] = min(Dist);
    Disparity(r,:) = disp_window(d_idx);
end

%%
imshow(Disparity,[-20,20])