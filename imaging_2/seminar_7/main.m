clear all;
run('../vlfeat/toolbox/vl_setup')
load faces_data.mat
whos

%% Nearest Neighbour
NN_Idx = knnsearch(train_faces', test_faces');
NN_Answers = train_labels(NN_Idx);
NN_Quality = sum(NN_Answers == test_labels) / length(test_labels)

%% PCA

[coeff, score, latent] = princomp(1*(train_faces));

size(coeff)
num_eigenfaces = 20;        k = ceil(sqrt(num_eigenfaces+1)); 
subplot(k, k, 1);
m = mean(train_faces,2)
imshow(vec2mat(m,32)'/256)
for n = 1:num_eigenfaces
    subplot(k, k, n+1);       imshow(vec2mat(score(:,n),32)'/512+0.5);
end

proj = score' * test_faces;
PA_Idx = knnsearch(coeff(:,4:end), proj(4:end,:)');
PCA_Answers = train_labels(PA_Idx);
PCA_Quality = sum(PCA_Answers == test_labels) / length(test_labels)

%% Analyse image 17

for i=[1,2,5,10,50,100]
    imshow()
end