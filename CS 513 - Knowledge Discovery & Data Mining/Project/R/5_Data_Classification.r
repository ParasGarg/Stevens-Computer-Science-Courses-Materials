###### Data Classification (STEP 4th)
#setwd("F:/Stevens/CS 513 - Knowledge Discovery & Data Mining/Project/Flight Delay Prediction/")

######
###### 2013, 2014 and 2015
######

### read work dataset of month june and year 2013, 2014, and 2015
datasheet_13_14_15 <- read.csv("Datasets/Datasheet_NY_June_2013_2014_2015.csv");
View(datasheet_13_14_15);

### storing every fifth record in a "test" dataset starting with the first record.
dataset_range <- seq(from = 1, to = nrow(datasheet_13_14_15), by = 5);    # calculating dataset sequence
test_dataset_13_14_15 <- datasheet_13_14_15[dataset_range, ];

for (i in seq(from = 1, to = nrow(test_dataset_13_14_15), by = 1)){       # checking and removing NULL values
  if(is.na(test_dataset_13_14_15$ARR_DEL15[i])){
    test_dataset_13_14_15 <- test_dataset_13_14_15[-i, ]
  }
}

View(test_dataset_13_14_15);
write.csv(test_dataset_13_14_15, file = "Datasets/Test_Dataset_NY_June_2013_2014_2015.csv", row.names = FALSE);  # saving test_dataset dataframe

### storing the rest in the "training" dataset
train_dataset_13_14_15 <- datasheet_13_14_15[-dataset_range, ];

for (i in seq(from = 1, to = nrow(train_dataset_13_14_15), by = 1)){          # checking and removing NULL values
  if(is.na(train_dataset_13_14_15$ARR_DEL15[i])){
    train_dataset_13_14_15 <- train_dataset_13_14_15[-i, ]
  }
}

View(train_dataset_13_14_15);
write.csv(train_dataset_13_14_15, file = "Datasets/Train_Dataset_NY_June_2013_2014_2015.csv", row.names = FALSE);# saving train_dataset dataframe

### removing unnecessary variables
rm(dataset_range)                                                # removing dataset sequence


######
###### 2016
######

### read work dataset of month june and year 2016
datasheet_16 <- read.csv("Datasets/Datasheet_NY_June_2016.csv");
View(datasheet_16);

### storing every fifth record in a "test" dataset starting with the first record.
dataset_range <- seq(from = 1, to = nrow(datasheet_16), by = 5);    # calculating dataset sequence
test_dataset_16 <- datasheet_16[dataset_range, ];

for (i in seq(from = 1, to = nrow(test_dataset_16), by = 1)){       # checking and removing NULL values
  if(is.na(test_dataset_16$ARR_DEL15[i])){
    test_dataset_16 <- test_dataset_16[-i, ]
  }
}

View(test_dataset_16);
write.csv(test_dataset_16, file = "Datasets/Test_Dataset_NY_June_2016.csv", row.names = FALSE);  # saving test_dataset dataframe

### storing the rest in the "training" dataset
train_dataset_16 <- datasheet_16[-dataset_range, ];

for (i in seq(from = 1, to = nrow(train_dataset_16), by = 1)){          # checking and removing NULL values
  if(is.na(train_dataset_16$ARR_DEL15[i])){
    train_dataset_16 <- train_dataset_16[-i, ]
  }
}

View(train_dataset_16);
write.csv(train_dataset_16, file = "Datasets/Train_Dataset_NY_June_2016.csv", row.names = FALSE);# saving train_dataset dataframe

### removing unnecessary variables
rm(dataset_range)                                                # removing dataset sequence
