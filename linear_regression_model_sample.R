install.packages("MASS")

library(MASS)
data("Boston")

#To view the correlation of the variables
plot(Boston$crim, Boston$medv, cex = 0.5, xlab = "Crime rate", ylab = "Price")

cr <- cor(Boston)

#we can use corrplot to visualize
install.packages("corrplot")
library(corrplot)

corrplot(cr, type = "lower")

#we will split the data into training and testing sets
set.seed(2)

install.packages("caTools") #sample.split function is present in this package
library(caTools)

split <- sample.split(Boston$medv, SplitRatio = 0.7)
??sample.split
# we divided the data with the ratio = 0.7
split

training_data <- subset(Boston, split == "TRUE")
testing_data <- subset(Boston, split == "FALSE")

#Linear Regression Model

colnames(training_data)

#Now to create the model we will use all columns

model <- lm(medv ~ ., data = training_data)

# for description of the model
summary(model)
#Now we can use this model to predict the output of test set
predic <- predict(model, testing_data)
predic

#To compare predicted values and actual values, we can use plots
plot(testing_data$medv, type = "l", lty = 1.8, col = "green")
lines(predic, type = "l", col = "blue")

#Diagnostics

install.packages("car")
library(car)
outlierTest(model)
qqPlot(model, main = "QQ plot")
leveragePlots(model)


