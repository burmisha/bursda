# see http://en.wikibooks.org/wiki/Data_Mining_Algorithms_In_R/Classification/adaboost
library('ada')
data <- read.csv('learn.txt')
#input_data$Label <- factor(input_data$Label)
data$label=round(data$label/4)
iteration <- 20

test_data <- read.csv('test.txt')
model <- ada(label~.-qid-docid, data = data, loss = "logistic", type = "real", iter = iteration)
prediction <- predict(model, test_data))
write(prediction, "Burmistrov_ml_lr.txt", sep="\n")