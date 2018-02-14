
# Load the data into R

setwd("C:/Users/DELL/Documents")
diabet <- read.csv("Diabetes.csv")

#Divide the dat for training and testing
set.seed(3)
id <- sample(2, nrow(diabet), prob = c(0.7, 0.3), replace = TRUE)
diabet_train <- diabet[id == 1,]
diabet_test <- diabet[id == 2,]

#Building Decision Tree

install.packages("rpart")
library(rpart)

colnames(diabet)

diabet_model <- rpart(Is_Diabetic ~ ., data = diabet_train)

diabet_model

plot(diabet_model, margin = 0.1)

#margin is used to adjust the size of the plot, For viewing labels

text(diabet_model, use.n = TRUE, pretty = TRUE, cex = 0.8)

# create subset and verify
temp <- diabet_train[diabet_train$glucose_conc < 154.5 & diabet_train$BMI < 26.35,]
table(temp$Is_Diabetic)

#Prediction of test dataset

pred_diabet <- predict(diabet_model, newdata = diabet_test, type = "class")
pred_diabet

#Now we need to compare it with actual values
table(pred_diabet, diabet_test$Is_Diabetic)

#For creating confusion matrix we can use this

install.packages("caret")
library(caret)

install.packages("e1071")
library(e1071)
confusionMatrix(table(pred_diabet,diabet_test$Is_Diabetic))

#Random Forest

install.packages("randomForest")
library(randomForest)

diabet_forest <- randomForest(Is_Diabetic ~ ., data = diabet_train)
diabet_forest

#Predicition of Test Set

pred_diabet <- predict(diabet_forest, newdata = diabet_test, type = "class")
pred_diabet

#confusion Matrix

confusionMatrix(table(pred_diabet,diabet_test$Is_Diabetic))

#Naive Bayes Classifier

diabet_naive <- naiveBayes(Is_Diabetic ~ ., data = diabet_train)
diabet_naive

#Predicition of Test Set

predic_diabet <- predict(diabet_naive, newdata = diabet_test, type = "class")
predic_diabet

#confusion Matrix

confusionMatrix(table(predic_diabet,diabet_test$Is_Diabetic))


#Support vector machine

data("iris")

#Let see how the observations of our dataset are related

plot(iris$Petal.Length, iris$Petal.Width, col = iris$Species)
plot(iris$Sepal.Length, iris$Sepal.Width, col = iris$Species)

#In plot we see that only for petal length and width we get proper plot wohtout overlapping
#so we will use only those columns

iris_data <- iris[, c(3,4,5)]

#divide the data into training and testing sets

set.seed(2)
dia <- sample(2, nrow(iris_data), prob = c(0.7, 0.3), replace = T)
train_iris <- iris_data[dia == 1,]
test_iris <- iris_data[dia == 2,]

#Building SVM model

svm_model <- svm(Species ~ ., data = train_iris, kernel = "linear", cost = 0.1, scale = F)
plot(svm_model, train_iris)
svm_model

#predicting values of test set

pred <- predict(svm_model, test_iris, type = "class")
plot(pred)
table(pred, test_iris$Species)
mean(pred == test_iris$Species)

#confusion matrix

confusionMatrix(table(pred, test_iris$species))
summary(svm_model)
svm_model$index

model <- svm(Species ~ ., data = train_iris, kernel = "linear", cost = 1, scale = F)
plot(model, train_iris)

#cross validaton using tune

tune_out <- tune(svm, Species ~ ., data = train_iris, kernel = "linear", ranges = list(cost = c(0.1, 1, 10)))
summary(tune_out)

bm <- tune_out$best.model
summary(bm)

pre <- predict(bm, test_iris, type = " class")

#confusion matrix
confusionMatrix(table(pre, test_iris$Species))

