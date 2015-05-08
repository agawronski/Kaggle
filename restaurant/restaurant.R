library(caret)
library(lubridate)
setwd("C:/Users/aidan/Desktop/Kaggle/restaurant")
set.seed(1111)
train <- read.csv("train.csv")
train[,c("Open.Date")] <- mdy(train[,c("Open.Date")])
summary(train)
#featurePlot(x=train[,-43], y=train$revenue, plot="pairs")

modelFit <- train(revenue ~ ., data=train, method="glm")
modelFit

modelFit2 <- train(revenue ~ ., data=train, method="lm")
modelFit2
