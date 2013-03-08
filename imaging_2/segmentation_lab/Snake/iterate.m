%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% interate.m implements the core of the snakes (active contours) algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [SegImage] = interate(image, xs, ys, alpha, beta, gamma, kappa, wl, we, wt, iterations);
% image: This is the image data
% xs, ys: The initial snake coordinates
% alpha: Controls tension
% beta: Controls rigidity
% gamma: Step size
% kappa: Controls enegry term
% wl, we, wt: Weights for line, edge and terminal enegy components
% iterations: Number of iterations for which snake is to be moved

%parameters
N = iterations; 
smth = image;
% Calculating size of image
[row col] = size(image);


%Computing external forces
eline = double(smth); %eline is simply the image intensities

[grady,gradx] = gradient(double(smth));
eedge = -1 * sqrt ((gradx .* gradx + grady .* grady)); %eedge is measured by gradient in the image

%masks for taking various derivatives
m1 = [-1 1];
m2 = [-1;1];
m3 = [1 -2 1];
m4 = [1;-2;1];
m5 = [1 -1;-1 1];

cx = conv2(smth,m1,'same');
cy = conv2(smth,m2,'same');
cxx = conv2(smth,m3,'same');
cyy = conv2(smth,m4,'same');
cxy = conv2(smth,m5,'same');

for i = 1:row
    for j= 1:col
        eterm(i,j) = (cyy(i,j)*cx(i,j)*cx(i,j) -2 *cxy(i,j)*cx(i,j)*cy(i,j) + cxx(i,j)*cy(i,j)*cy(i,j))/((1+cx(i,j)*cx(i,j) + cy(i,j)*cy(i,j))^1.5);
    end
end

eext = (wl*eline + we*eedge -wt*eterm); %eext as a weighted sum of eline, eedge and eterm

[fx, fy] = gradient(eext); %computing the gradient

%initializing the snake
xs=xs';
ys=ys';
[m n] = size(xs);
[mm nn] = size(fx);
    
%populating the penta diagonal matrix
A = zeros(m,m);
b = [(2*alpha + 6 *beta) -(alpha + 4*beta) beta];
brow = zeros(1,m);
brow(1,1:3) = brow(1,1:3) + b;
brow(1,m-1:m) = brow(1,m-1:m) + [beta -(alpha + 4*beta)]; % populating a template row
for i=1:m
    A(i,:) = brow;
    brow = circshift(brow',1)'; % Template row being rotated to egenrate different rows in pentadiagonal matrix
end

[L U] = lu(A + gamma .* eye(m,m));
Ainv = inv(U) * inv(L); % Computing Ainv using LU factorization
 
%moving the snake in each iteration
for i=1:N;
    
    % you should calculate new snake position here
	...
    
    
    %Displaying the snake in its new position
    imshow(image,[]); 
    hold on;
    
    plot([xs; xs(1)], [ys; ys(1)], 'r-');
    hold off;
    pause(0.001)    
end;

X=1:size(image,2);
X=repmat(X,size(image,1),1);
Y=1:size(image,1);
Y=repmat(Y',1,size(image,2));

IN = inpolygon(X, Y, xs, ys);
SegImage = zeros(size(image));
for i=1:size(IN,1)
    for j=1:size(IN,2)
        if(IN(i,j) == 1)
            SegImage(i,j) = 0;
        else
            SegImage(i,j) = 255;
        end
    end
end


