clear all
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

f = -A\ones(size(x1,2),1);
F_hat = [f(1:3)'; f(4:6)'; f(7:8)' 0];
FF = N1' * F_hat * N2;

[U,S,V] = svd(FF);
d = diag(S);
F = U * diag([d(1:2); 0]) * V';
F = F./F(3,3)
