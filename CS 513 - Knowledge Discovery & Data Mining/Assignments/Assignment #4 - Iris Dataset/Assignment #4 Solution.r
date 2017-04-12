###### Knowledge Discovery and Data Mining (CS 513) ######
#            (Assignment 4 - Iris Dataset)

# Course      : CS 513 - A
# First Name  : PARAS 
# Last Name   : GARG
# Id          : 10414982
# Purpose     : Assignment 4 - Iris Dataset

###### ******************************************** ######

# clearing object environment
rm(list=ls());


# 4.1. Load the IRIS dataset
data();
data("iris");
View(iris);


# 4.2. Read the data and:
# 4.2.1. Store every "fifth" record in a test dataset starting with the first record.
  # calculating "every fifth record" in iris dataset for test dataset
  recordRange <- seq(from = 1, to = nrow(iris), by = 5);
  # loading iris fith range record in test dataset
  test <- iris[recordRange, ];
  
# 4.2.2 Store the rest in the training dataset
  # loading all iris record except fith range record in training dataset
  training <- iris[-recordRange, ];
  
  
# 4.3. Use knn with k=1 and classify the test dataset
  # importing "class" package
  library(class);
  # using knn model
  predict <- knn(training[ , -5], test[ , -5], training[ , 5], k = 1);


# 4.4. Measure the performance of knn
table(Predict = predict, Actual = test[ , 5]);

  
# 4.5. Repeat the above steps with k=2, k=5, k=10
  # k = 2
  predict_K2 <- knn(training[ , -5], test[ , -5], training[ , 5], k = 2);
  table(Predict = predict_K2, Actual = test[ , 5]);
  
  # k = 5
  predict_K5 <- knn(training[ , -5], test[ , -5], training[ , 5], k = 5);
  table(Predict = predict_K5, Actual = test[ , 5]);
  
  # k = 10
  predict_K10 <- knn(training[ , -5], test[ , -5], training[ , 5], k = 10);
  table(Predict = predict_K10, Actual = test[ , 5]);
