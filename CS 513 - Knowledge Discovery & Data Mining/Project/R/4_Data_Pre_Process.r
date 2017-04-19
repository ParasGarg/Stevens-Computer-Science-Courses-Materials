###### Data Pre Processing (STEP 4th)
#setwd("F:/Stevens/CS 513 - Knowledge Discovery & Data Mining/Project/Flight Delay Prediction/")

### cleaning environment
rm(list = ls())

######
###### 2013, 2014 and 2015
######

### creating datasheet
# readung work dataset dataframe
dataset_factorized_13_14_15 <- read.csv("Dataframes/Dataset_Factorized_NY_June_2013_2014_2015.csv");  
attach(dataset_factorized_13_14_15);

# fetching unique values from data frame
carries_set <- unique(as.character(CARRIER));
origin_set <- unique(as.character(ORIGIN));
dest_set <- unique(as.character(DEST));
detach(dataset_work_13_14_15);

# combining and fetching unique values for new data frame columns
column_set <- unique(c(carries_set, origin_set, dest_set));

# creating new null data frame of 'column_set' columns
datasheet_13_14_15 <- data.frame(matrix(nrow = 0, ncol = length(column_set) + 2));
colnames(datasheet_13_14_15) <- c("DAY_OF_MONTH", "ARR_DEL15", column_set);
View(datasheet_13_14_15);

### filling data in the model
for (i in seq(from = 1, to = nrow(dataset_work_13_14_15), by = 1)) {
  
  datasheet_13_14_15[i, 1] <- dataset_work_13_14_15[i, 1]
  datasheet_13_14_15[i, 2] <- dataset_work_13_14_15[i, 6]
  
  # checking carriers
  for (j in seq(from = 3, to = length(carries_set), by = 1)) {
    if (colnames(datasheet_13_14_15)[j] == dataset_work_13_14_15[i, 2]) {
      datasheet_13_14_15[i, j] <- dataset_work_13_14_15[i, 2]
    } else {
      datasheet_13_14_15[i, j] <- 0
    }
  }
  
  # checking origin and destination
  for (j in seq(from = (2 + length(carries_set)), to = ncol(datasheet_13_14_15), by = 1)) {
    if (colnames(datasheet_13_14_15)[j] == dataset_work_13_14_15[i, 4]) {
      datasheet_13_14_15[i, j] <- 1
    } else if (colnames(datasheet_13_14_15)[j] == dataset_work_13_14_15[i, 5]) {
      datasheet_13_14_15[i, j] <- 2
    } else {
      datasheet_13_14_15[i, j] <- 0
    }
  }
}
View(datasheet_13_14_15);
# saving pre processed dataset
write.csv(datasheet_13_14_15, file = "Datasets/Datasheet_Original_NY_June_2013_2014_2015.csv", row.names = FALSE);

### removing NA data rows and columns
# removing rows from datasheet which have NA values in ArrDel15
for (i in seq(from = 1, to = nrow(datasheet_13_14_15), by = 1)){
  if(is.na(datasheet_13_14_15$ARR_DEL15[i])){
    datasheet_13_14_15 <- datasheet_13_14_15[-i, ]
  }
}

# removing NA value column in datasheet
datasheet_13_14_15 <- datasheet_13_14_15[, -17];

# saving datasheet
write.csv(datasheet_13_14_15, file = "Datasets/Datasheet_Original_Non_NA_NY_June_2013_2014_2015.csv", row.names = FALSE);


### compressing original sheet for easy process by selecting random 5000 records and removing remaining
datasheet_13_14_15 <- datasheet_13_14_15[sample(nrow(datasheet_13_14_15), size=5000, replace=TRUE), ];
View(datasheet_13_14_15);
write.csv(datasheet_13_14_15, file = "Datasets/Datasheet_NY_June_2013_2014_2015.csv", row.names = FALSE);

### removing unnecessary variables
rm(dataset_work_13_14_15)
rm(carries_set)
rm(column_set)
rm(dest_set)
rm(origin_set)


######
###### 2016
######

### creating datasheet
# readung work dataset dataframe
dataset_work_16 <- read.csv("Dataframes/Dataset_Work_NY_June_2016.csv");  
attach(dataset_work_16);

# fetching unique values from data frame
carries_set <- unique(as.character(CARRIER));
origin_set <- unique(as.character(ORIGIN));
dest_set <- unique(as.character(DEST));
detach(dataset_work_16);

# combining and fetching unique values for new data frame columns
column_set <- unique(c(carries_set, origin_set, dest_set));

# creating new null data frame of 'column_set' columns
datasheet_16 <- data.frame(matrix(nrow = 0, ncol = length(column_set) + 2));
colnames(datasheet_16) <- c("DAY_OF_MONTH", "ARR_DEL15", column_set);
View(datasheet_16);

### filling data in the model
for (i in seq(from = 1, to = nrow(dataset_work_16), by = 1)) {
  
  datasheet_16[i, 1] <- dataset_work_16[i, 1]
  datasheet_16[i, 2] <- dataset_work_16[i, 6]
  
  # checking carriers
  for (j in seq(from = 3, to = length(carries_set), by = 1)) {
    if (colnames(datasheet_16)[j] == dataset_work_16[i, 2]) {
      datasheet_16[i, j] <- dataset_work_16[i, 2]
    } else {
      datasheet_16[i, j] <- 0
    }
  }
  
  # checking origin and destination
  for (j in seq(from = (2 + length(carries_set)), to = ncol(datasheet_16), by = 1)) {
    if (colnames(datasheet_16)[j] == dataset_work_16[i, 4]) {
      datasheet_16[i, j] <- 1
    } else if (colnames(datasheet_16)[j] == dataset_work_16[i, 5]) {
      datasheet_16[i, j] <- 2
    } else {
      datasheet_16[i, j] <- 0
    }
  }
}
View(datasheet_16);
# saving pre processed dataset
write.csv(datasheet_16, file = "Datasets/Datasheet_Original_NY_June_2016.csv", row.names = FALSE);


### removing NA data rows and columns
# removing rows from datasheet which have NA values in ArrDel15
for (i in seq(from = 1, to = nrow(datasheet_16), by = 1)){
  if(is.na(datasheet_16$ARR_DEL15[i])){
    datasheet_16 <- datasheet_16[-i, ]
  }
}

# removing NA value column in datasheet
datasheet_16 <- datasheet_16[, -13];

# saving datasheet
write.csv(datasheet_16, file = "Datasets/Datasheet_Original_Non_NA_NY_June_2016.csv", row.names = FALSE);

### compressing original sheet for easy process by selecting random 5000 records and removing remaining
datasheet_16 <- datasheet_16[sample(nrow(datasheet_16), size=5000, replace=TRUE), ];
View(datasheet_16);
write.csv(datasheet_16, file = "Datasets/Datasheet_NY_June_2016.csv", row.names = FALSE);

### removing unnecessary variables
rm(dataset_work_16)
rm(carries_set)
rm(column_set)
rm(dest_set)
rm(origin_set)
rm(i)
rm(j)