clear all;
run('../vlfeat/toolbox/vl_setup')
load faces_data.mat
whos

%% NeNearest Neighbour
NN_Idx = knnsearch(train_faces', test_faces');
NN_Answers = train_labels(NN_Idx);
NearestNeighbourQuality = sum(NN_Answers == test_labels) / length(test_labels)