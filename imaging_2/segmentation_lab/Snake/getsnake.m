%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% getsnake.m is a helper function for iterate.m

function [xs, ys] = getsnake(image)
% image: The image on which snake is to be initialized
% xs, xy: Initial position of the snake
imshow(image);
hold on; %Hold the image steady       
xs = [];
ys = [];

but = 1;
hold on
% Initially, the list of points is empty.
xy = [];
n = 0;
% Loop, picking up the points.
% disp('Left mouse button picks points.')
% disp('Right mouse button picks last point.')
% but = 1;
% while but == 1
%     [xi,yi,but] = ginput(1); %pick a new input
%     plot(xi,yi,'ro')
%     n = n+1;
%     xy(:,n) = [xi;yi];
% end
% 
% n = n+1;
% xy(:,n) = [xy(1,1);xy(2,1)];

xy = [122.1332  173.7092  211.5315  222.7063  171.9900  114.3968   58.5229   60.2421   92.9069  110.0989  122.1332;
      99.2464  101.8252  121.5960  137.9284  161.9971  149.1032  119.8768  106.1232  103.5444   99.2464   99.2464];
n = size(xy,2);
% Interpolate with a spline curve and finer spacing.
t = 1:n;
ts = 1: 0.1: n;
xys = spline(t,xy,ts);

xs = xys(1,:);
ys = xys(2,:);