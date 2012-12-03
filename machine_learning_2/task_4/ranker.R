library('e1071')   # package for svm
data = read.csv('learn.txt');
model <- svm(label~.-qid-docid, data)

# model = lm(label~.-qid-docid, data);

# getting score-values of test documents
test_data = read.csv('test_raw.txt');
scores = predict(model, test_data);

test_data = test_data[,1:3];
test_data$label = scores;

# sorting docs for each query
qids = unique(test_data$qid);
for (doc_qid in qids) {
  qid_docs = test_data[which(test_data$qid == doc_qid),];
  qid_docs = qid_docs[order(qid_docs$label, decreasing=TRUE),];
  test_data[which(test_data$qid == doc_qid),] = qid_docs;
}
test_data = test_data[,2:3];

write.csv(test_data, "result.txt", row.names=FALSE, quote=FALSE);
