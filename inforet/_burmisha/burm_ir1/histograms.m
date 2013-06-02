clear all
A = dlmread('statistics.txt', '\t',0,1);
A = A(((A(:,5) ~= 0) .* (A(:,4) ~= 10000))==1,:);
%% Documents size
hist(A(:,5),100)
%% «In» degrees
hist(A(A(:,2) < 100,2),100)
%% «Out» degrees
hist(A(A(:,3) < 200,3),100)
%% Distance
hist(A(:,4),10)
