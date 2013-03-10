%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% interate.m implements the core of the snakes (active contours) algorithm
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [SegImage] = iterate(image, xs, ys, alpha, beta, Gamma, kappa, wl, we, wt, iterations)
% image: This is the image data
% xs, ys: The initial snake coordinates
% alpha: Controls tension
% beta: Controls rigidity
% gamma: Step size
% kappa: Controls enegry term
% wl, we, wt: Weights for line, edge and terminal energy components
% iterations: Number of iterations for which snake is to be moved

%Computing external forces
eline = double(image); %eline is simply the image intensities
[grady, gradx] = gradient(double(image));
eedge = -1 * sqrt ((gradx .* gradx + grady .* grady)); %eedge is measured by gradient in the image

%masks for taking various derivatives
cx  = conv2(image,[-1 1],'same');
cy  = conv2(image,[-1; 1],'same');
cxx = conv2(image,[1 -2 1],'same');
cyy = conv2(image,[1; -2; 1],'same');
cxy = conv2(image,[1 -1; -1 1],'same');
eterm = (cyy.*cx.*cx - 2*cxy.*cx.*cy + cxx.*cy.*cy)./((1+cx.*cx + cy.*cy).^1.5);

eext = wl*eline + we*eedge - wt*eterm; %eext as a weighted sum of eline, eedge and eterm
[fx, fy] = gradient(eext); %computing the gradient

%initializing the snake
xs=xs';
ys=ys';
m = length(xs);
    
%populating the penta diagonal matrix
A = zeros(m,m);
b = [(2*alpha + 6 *beta), -(alpha + 4*beta), beta];
brow = zeros(1,m);
brow(1,1:3) = b;
brow(1,m-1:m) = [beta, -(alpha + 4*beta)]; % populating a template row
for i=1:m
    A(i,:) = brow;
    brow = circshift(brow',1)'; % Template row being rotated to egenrate different rows in pentadiagonal matrix
end

[L U] = lu(A + Gamma .* eye(m,m));
Ainv = inv(U) * inv(L); % Computing Ainv using LU factorization

for i=1:iterations;
    xs = Ainv * (Gamma*xs - kappa*interp2(fx,xs,ys));
    ys = Ainv * (Gamma*ys - kappa*interp2(fy,xs,ys));
    imshow(image); %Displaying the snake in its new position
    hold on;
    plot([xs; xs(1)], [ys; ys(1)], 'r-');
    hold off;
    pause(0.001)    
end;

X=repmat((1:size(image,2)),size(image,1),1);
Y=repmat((1:size(image,1))',1,size(image,2));
IN = inpolygon(X, Y, xs, ys);
SegImage = 255*(IN == 0);
