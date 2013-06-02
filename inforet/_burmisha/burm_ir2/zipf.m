clear all
%% 2-grams
A = dlmread('freq_2.txt', ',',0,1);
plot(log(1:size(A,1)),log(A/sum(A)),'.', 'markersize', 1);
coeff = regress(log(A/sum(A)), [ones(size(A,1),1) log(1:size(A,1))'],0.95);
coeff(2)
%% 3-grams
A = dlmread('freq_3.txt', ',',0,1);
plot(log(1:size(A,1)),log(A/sum(A)),'.', 'markersize', 1);
coeff = regress(log(A/sum(A)), [ones(size(A,1),1) log(1:size(A,1))'],0.95);
coeff(2)
%% 3-grams
A = dlmread('freq_4.txt', ',',0,1);
plot(log(1:size(A,1)),log(A/sum(A)),'.', 'markersize', 1);
coeff = regress(log(A/sum(A)), [ones(size(A,1),1) log(1:size(A,1))'],0.95);
coeff(2)
%% 4-grams
A = dlmread('freq_5.txt', ',',0,1);
plot(log(1:size(A,1)),log(A/sum(A)),'.', 'markersize', 1);
coeff = regress(log(A/sum(A)), [ones(size(A,1),1) log(1:size(A,1))'],0.95);
coeff(2)
