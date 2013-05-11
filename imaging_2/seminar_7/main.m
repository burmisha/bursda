clear all;
cd D:\github\bursda\imaging_2\seminar_7
run('../vlfeat/toolbox/vl_setup')
load faces_data.mat
whos

%% Nearest Neighbour
NN_Idx = knnsearch(train_faces', test_faces');
NN_Answers = train_labels(NN_Idx);
NN_Quality = sum(NN_Answers == test_labels) / length(test_labels)

%% PCA http://blog.cordiner.net/2010/12/02/eigenfaces-face-recognition-matlab/
mean_face = mean(train_faces, 2);                                           % find the mean image
shifted_train = train_faces - repmat(mean_face, 1, size(train_faces,2));    % mean-shifted input images
[evectors, score, evalues] = princomp(shifted_train');                      % calculate the ordered eigenvectors and eigenvalues
features = evectors' * shifted_train;                                       % project the images into the subspace to generate the feature vectors

%% show faces
size(score)
show_eigenfaces = 20;        k = ceil(sqrt(show_eigenfaces+1)); 
subplot(k, k, 1);
imshow(vec2mat(mean_face,32)'/256)
for n = 1:show_eigenfaces
    subplot(k, k, n+1);       imshow(vec2mat(evectors(:,n),32)'*4+0.5);
end

%% Analyse images 17 and 191
close all
levels = [1,2,5,10,20,50,100];
images_idx = [17, 191];
n = 1;
for k = 1:length(images_idx)
    for i = 1:length(levels)
        subplot(2, length(levels), n); n = n + 1;
        imshow(vec2mat(mean_face + evectors(:,1:levels(i)) * (score(images_idx(k), 1:levels(i)))',32)'/255)
        % pause
    end
end

%% calculate the similarity of the input to each training image
ei = 10:100
for e = ei
    e
    num_eigenfaces = 4:e;                                                     % only retain the top 'num_eigenfaces' eigenvectors
    evectors_small = evectors(:, num_eigenfaces);
    features_small = evectors_small' * shifted_train;   
    feature_vec = evectors_small' * (test_faces - repmat(mean_face, 1, size(test_faces,2)));
    for i=1:size(test_faces,2)
        similarity_score = arrayfun(@(n) 1 / (1 + norm(features_small(:,n) - feature_vec(:,i))), 1:size(train_faces,2));
        [~, match_ix] = max(similarity_score);
        PCA_Idx(i) = match_ix;
    end
    PCA_Answers = train_labels(PCA_Idx);
    PCA_Quality(e) = sum(PCA_Answers == test_labels) / length(test_labels);
end
close all
plot(ei, PCA_Quality(ei))
max(PCA_Quality)

%% LBP
%close all
disc_hist = 100;
mask_size = 32;
LBP_Train=zeros(length(vl_lbp(im2single(ones(32)), mask_size)),size(train_faces,2));
for i=1:size(train_faces,2)
    l = vl_lbp(im2single(vec2mat(train_faces(:,i),32)), mask_size);
    LBP_Train(:,i) = l(:);
end

LBP_Test=zeros(length(vl_lbp(im2single(ones(32)), mask_size)),size(test_faces,2));
for i=1:size(test_faces,2)
    l = vl_lbp(im2single(vec2mat(test_faces(:,i),32)), mask_size);
    LBP_Test(:,i) = l(:); 
end

LBP_Idx = knnsearch(LBP_Train', LBP_Test');
LBP_Answers = train_labels(LBP_Idx);
LBP_Quality = sum(LBP_Answers == test_labels) / length(test_labels)
