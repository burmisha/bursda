clear all
im1 = imread('tsukuba1.png');
im2 = imread('tsukuba2.png');

Disparity = -20:20;
w = 10; % window
%%
cut = @(x, l, r) [zeros(1,min(max(1-l,0),r-l+1)), x(max(1,l):min(length(x),r)), zeros(1,max(r-length(x),0))];
dist = @(x, y) sum((x - y).^2);
% zeros(1,max([1+2,0,]))
cut(1,-2,3)
%%
D = zeros(size(im1));
for r = 1:size(im1,1)
    r
    for i = 1:size(im1,2)
        m = zeros(length(Disparity),1);
        for j = 1:length(Disparity)
            d = Disparity(j);
            m(1 + j) = dist(cut(im1(r,:),i-w,i+w), cut(im1(r,:),i-w+d,i+w+d));
        end
        [t,D(r,i)] = min(m);
    end
end