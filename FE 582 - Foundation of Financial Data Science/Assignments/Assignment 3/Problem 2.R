# Environment Setup#
rm(list = ls())
setwd("E:/FE Assignment/") 

# Import data from the csv file
defaultData <- read.csv("Default.csv")
defaultPredictData <- read.csv("DefaultPredict.csv")
# Removing the index column
defaultData <- defaultData[,!names(defaultData)%in%"index"]
defaultPredictData <- defaultPredictData[,!names(defaultPredictData)%in%"index"]

# Logistic Regression
logRegFit <- glm(default ~ student + balance + income, data = defaultData,family = binomial)
logRegPredict <- predict(logRegFit, defaultPredictData, type = "response") > 0.5
logRegPredictedDefault <- rep("No", length(logRegPredict))
logRegPredictedDefault[logRegPredict] <- "Yes"
logRegPredict <- cbind(logRegPredictedDefault, defaultPredictData)
logRegPredict

# Linear discriminant Analysis
library("MASS")
ldaFit <- lda(default ~ student + balance + income, data = defaultData)
ldaPredictedDefault <- predict(ldaFit, defaultPredictData)$class
ldaPredicted <- cbind(ldaPredictedDefault, defaultPredictData)
ldaPredicted

# Quadratic discriminent Analysis
qdaFit <- qda(default ~ student + balance + income, data = defaultData)
qdaPredictedDefault <- predict(qdaFit, defaultPredictData)$class
qdaPredicted <- cbind(qdaPredictedDefault, defaultPredictData)
qdaPredicted

# K nearest neighbor
library(class)
defaultData$student <- as.character(defaultData$student)
defaultData$student[defaultData$student == "Yes"] <- 1
defaultData$student[defaultData$student == "No"] <- 0
defaultData$student <- as.numeric(defaultData$student)
alpha <- defaultData[2:4]
defaultData_class <- defaultData[, 1]
student <- defaultPredictData$student
defaultPredictData$student <- as.character(defaultPredictData$student)
defaultPredictData$student[defaultPredictData$student == "Yes"] <- 1
defaultPredictData$student[defaultPredictData$student == "No"] <- 0
defaultPredictData$student <- as.numeric(defaultPredictData$student)

# For 3 nearnest neighbour, k = 3
knnPredictedDefault <- knn(alpha, defaultPredictData, defaultData_class,k = 3)
knnPredictedDefault <- cbind(knnPredictedDefault, student,defaultPredictData[2:3])
knnPredictedDefault

