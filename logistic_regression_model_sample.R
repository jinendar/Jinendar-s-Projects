
#Logisitc Regression#Load te data into R

setwd("C:/Users/DELL/Documents")
diabet <- read.csv("Diabetes.csv")

#Divide the dat for training and testing
set.seed(2)
install.packages("caTools")
library(caTools)

di <- sample.split(as.numeric(diabet$Is_Diabetic), SplitRatio = 0.7)
trainset <- subset(diabet, di == "TRUE")
testset <- subset(diabet, di == "FALSE")


colnames(diabet)
model2 <- glm(Is_Diabetic ~ ., data = trainset, family = "binomial")
summary(model2)

#Predict values
predi <- predict(model2, newdata = testset, type = "response")
predi

#confusion matrix

table(Actualvalues = testset$Is_Diabetic, predictedvalues = predi > 0.3)
table(Actualvalues = testset$Is_Diabetic, predictedvalues = predi > 0.7)

#ROC curve for predicting cut-off

install.packages("ROCR")
library(ROCR)

ROCpred <- prediction(predi, testset$Is_Diabetic)

ROCperf <- performance(ROCpred, "tpr", "fpr")
plot(ROCperf, col = "blue", print.cutoffs.at = seq(0.1, by = 0.1), text.adj = c(-0.5,1.7), cex = 0.9)

