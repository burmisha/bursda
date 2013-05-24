clear all
cd d:\github\bursda\imaging_2\seminar_10
im1 = rgb2gray(imread('tsukuba1.png'));
im2 = rgb2gray(imread('tsukuba2.png'));

disp_window = -30:30;

h = size(im1,1);
w = size(im1,2);

cut = @(x, l, r) [zeros(1,min(max(1-l,0),r-l+1)), x(max(1,l):min(length(x),r)), zeros(1,max(r-length(x),0))];
for m=1:30
    m
    mask = ones(m,1);
    Disparity = zeros(h, w);
    for r = 1:h
        Dist = zeros(length(disp_window), w);
        for j = 1:length(disp_window)
            d = disp_window(j);
            line_2 = cut(im2(r,:), 1+d, w+d);
            delta = double(im1(r,:)) - double(line_2);
            Dist(j,:) = conv(delta.^2, mask, 'same'); % SSD
%             Dist(j,:) = conv(abs(delta), mask, 'same'); % SAD
        end
        [~,d_idx] = min(Dist);
        Disparity(r,:) = disp_window(d_idx);
    end
%     imshow(Disparity,[-30,30])
    imwrite((Disparity+30)*255/60, sprintf('SSD_m%02d.gif', m))
end