###### Knowledge Discovery and Data Mining (CS 513) ######
#                       (Final Exam)

# Course      : CS 513 - A
# First Name  : PARAS 
# Last Name   : GARG
# Id          : 10414982
# Purpose     : Final Exam - IRIS Dataset

###### ******************************************** ######

### Develop the following program in R
# a. Load the IRIS dataset into memory
iris_dataset <- data.frame(iris);
View(iris_dataset);

# b. Create a test dataset by extracting every third (3rd) row of the data, starting with the second row.
extract_range <- seq(from = 2, to = nrow(iris_dataset), by = 3);
test_dataset <- iris_dataset[extract_range, ];
View(test_dataset);

# c. Create a training dataset by excluding the test data from the IRIS dataset
train_dataset <- iris_dataset[-extract_range, ];
View(train_dataset);

### clearing environment
rm(list = ls())