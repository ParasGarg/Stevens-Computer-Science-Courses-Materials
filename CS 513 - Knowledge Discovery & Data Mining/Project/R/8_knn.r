###### knn algorithm
#setwd("F:/Stevens/CS 513 - Knowledge Discovery & Data Mining/Project/Flight Delay Prediction/")

######
###### 2013, 2014 and 2015
######
rm(list = ls());

# reading test dataset
test_dataset_13_14_15 <- read.csv("Datasets/Test_Dataset_NY_June_2013_2014_2015.csv");
View(test_dataset_13_14_15);

# reading train dataset
train_dataset_13_14_15 <- read.csv("Datasets/Train_Dataset_NY_June_2013_2014_2015.csv");
View(train_dataset_13_14_15);

# preparing datasets for knn
test_set <- test_dataset_13_14_15[, -2];
train_set <- train_dataset_13_14_15[, -2];
classified_set <- train_dataset_13_14_15[, 2];

### knn
# output for k = 1
output_k1 <- knn(train_set, test_set, classified_set, k=1);
prediction_k1 <- table(output_k1, test_set[, 2])

# output for k = 2
output_k2 <- knn(train_set, test_set, classified_set, k=2);
prediction_k2 <- table(output_k2, test_set[, 2]);

# output for k = 5
output_k5 <- knn(train_set, test_set, classified_set, k=5);
prediction_k5 <- table(output_k5, test_set[, 2]);

# output for k = 10
output_k10 <- knn(train_set, test_set, classified_set, k=10);
prediction_k10 <- table(output_k10, test_set[, 2]);

# output for k = 15
output_k15 <- knn(train_set, test_set, classified_set, k=15);
prediction_k15 <- table(output_k15, test_set[, 2]);

# output for k = 20
output_k20 <- knn(train_set, test_set, classified_set, k=20);
prediction_k20 <- table(output_k20, test_set[, 2]);

# output for k = 25
output_k25 <- knn(train_set, test_set, classified_set, k=25);
prediction_k25 <- table(output_k25, test_set[, 2])

### predictions
prediction_k1
prediction_k2
prediction_k5
prediction_k10
prediction_k15
prediction_k20
prediction_k25




######
###### 2016
######

# reading test dataset
test_dataset_16 <- read.csv("Datasets/Test_Dataset_NY_June_2016.csv");
View(test_dataset_16);

# reading train dataset
train_dataset_16 <- read.csv("Datasets/Train_Dataset_NY_June_2016.csv");
View(train_dataset_16);

# preparing datasets for knn
test_set_16 <- test_dataset_16[, -2];
train_set_16 <- train_dataset_16[, -2];
classified_set_16 <- train_dataset_16[, 2];


### knn
# output for k = 1
output_16_k1 <- knn(train_set_16, test_set_16, classified_set_16, k=1);
prediction_16_k1 <- table(output_16_k1, test_set_16[, 2])

# output for k = 2
output_16_k2 <- knn(train_set_16, test_set_16, classified_set_16, k=2);
prediction_16_k2 <- table(output_16_k2, test_set_16[, 2])

# output for k = 5
output_16_k5 <- knn(train_set_16, test_set_16, classified_set_16, k=5);
prediction_16_k5 <- table(output_16_k5, test_set_16[, 2])

# output for k = 10
output_16_k10 <- knn(train_set_16, test_set_16, classified_set_16, k=10);
prediction_16_k10 <- table(output_16_k10, test_set_16[, 2])

# output for k = 15
output_16_k15 <- knn(train_set_16, test_set_16, classified_set_16, k=15);
prediction_16_k15 <- table(output_16_k15, test_set_16[, 2])

# output for k = 20
output_16_k20 <- knn(train_set_16, test_set_16, classified_set_16, k=20);
prediction_16_k20 <- table(output_16_k20, test_set_16[, 2])

# output for k = 25
output_16_k25 <- knn(train_set_16, test_set_16, classified_set_16, k=25);
prediction_16_k25 <- table(output_16_k25, test_set_16[, 2])

### predictions
prediction_16_k1
prediction_16_k2
prediction_16_k5
prediction_16_k10
prediction_16_k15
prediction_16_k20
prediction_16_k25

