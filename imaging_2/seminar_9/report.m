clear all
load estimateF.mat

us2homo = @(x) [x; ones(1, size(x,2))];
homo2us = @(x) x(1:(end-1),:)./(ones(size(x,1)-1,1)*x(end,:));

x1 = cell2mat(x(1));
meaned_x1 = x1 - mean(x1,2)*ones(1,size(x1,2));
t = meaned_x1(1:2,:)';
N1 = diag([1./std(t) 1]);
n1 = N1 * meaned_x1;

x2 = cell2mat(x(2));
meaned_x2 = x2 - mean(x2,2)*ones(1,size(x2,2));
t = meaned_x2(1:2,:)';
N2 = diag([1./std(t) 1]);
n2 = N2 * meaned_x2;
