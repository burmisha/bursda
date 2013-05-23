clear all
close all
load estimateF.mat

us2homo = @(x) [x; ones(1, size(x,2))];
homo2us = @(x) x(1:(end-1),:)./(ones(size(x,1)-1,1)*x(end,:));
norm_homo = @(m,s) [1/s(1) 0 -m(1)/s(1); 0 1/s(2) -m(2)/s(2); 0 0 1];

%% normalize
x1 = cell2mat(x(1));
N1 = norm_homo(mean(x1,2), std(x1(1:2,:)'));

x2 = cell2mat(x(2));
N2 = norm_homo(mean(x2,2), std(x2(1:2,:)'));

%% build system
a = N1 * x1;
b = N2 * x2;
A = [a(1,:)'.* b(1,:)'    ...
     a(1,:)'.* b(2,:)'    ...
     a(1,:)'              ...
     a(2,:)'.* b(1,:)'    ...
     a(2,:)'.* b(2,:)'    ...
     a(2,:)'              ...
               b(1,:)'    ...
               b(2,:)'];

%% Form F
f = -A\ones(size(x1,2),1);
F_hat = [f(1:3)'; f(4:6)'; f(7:8)' 0];
FF = N1' * F_hat * N2;

[U,S,V] = svd(FF);
d = diag(S);
F = U * diag([d(1:2); 0]) * V';
F = F./F(3,3)

%% plot epipolar lines
I2 = imread('im2.JPG');
imshow(I2)
idx = sort(randperm(size(x2,2),20));
plotEpipolars(F * x1(:,idx))
coords = homo2us(x2(:,idx));
plot(coords(1,:), coords(2,:), 'r.');

%% build P2
P1 = eye(3,4);
b = null(F');
A = -cross(b * ones(1,3),F);
P2 = [A,b]

%% plot points
close all
answer = zeros(3,size(x1,2));
for i=1:size(x1,2)
    M = [cross(N1*x1(:,i) * ones(1,4),P1); cross(N2*x2(:,i) * ones(1,4),P2)];
    [v,d] = eig(M'*M);
    answer(:,i) = homo2us(v(1,:)');
end
plot3(answer(1,:),answer(2,:),answer(3,:), '.', 'markersize', 2)
axis tight
