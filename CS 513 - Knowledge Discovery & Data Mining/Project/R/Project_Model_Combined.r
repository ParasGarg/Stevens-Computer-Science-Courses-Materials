###### Data Cleaning
#setwd("F:/Stevens/CS 513 - Knowledge Discovery & Data Mining/Project/Flight Delay Prediction/")

### cleaning environment
rm(list = ls())

######
###### 2013, 2014 and 2015
######

### read whole database of month june and year 2013, 2014, & 2015
database_13_14_15 <- read.csv("Databases/Database_NY_June_2013_2014_2015.csv");
View(database_13_14_15);
attach(database_13_14_15);

### fetched important fields of whole database of month june and year 2013, 2014, & 2015
dataset_original_13_14_15 <- data.frame(DAY_OF_MONTH, CARRIER, 
                                        ORIGIN_AIRPORT_ID, ORIGIN_AIRPORT_SEQ_ID, ORIGIN_CITY_MARKET_ID, ORIGIN,
                                        DEST_AIRPORT_ID, DEST_AIRPORT_SEQ_ID, DEST_CITY_MARKET_ID, DEST,
                                        ARR_DELAY, ARR_DEL15,
                                        CANCELLED, DIVERTED, FLIGHTS, FL_NUM,
                                        CARRIER_DELAY, WEATHER_DELAY, NAS_DELAY, SECURITY_DELAY, LATE_AIRCRAFT_DELAY,
                                        DIV_AIRPORT_LANDINGS)
View(dataset_original_13_14_15)
write.csv(dataset_original_13_14_15, file = "Dataframes/Dataset_Original_NY_June_2013_2014_2015.csv", row.names = FALSE); # saving dataset_original dataframe
detach(database_13_14_15);                                      # detaching database dataframe
attach(dataset_original_13_14_15);                              # attaching dataset_original dataframe


### fetching work fields of whole database of month june and year 2013, 2014, & 2015
dataset_work_13_14_15 <- data.frame(DAY_OF_MONTH, CARRIER, FL_NUM, ORIGIN, DEST, ARR_DEL15);
View(dataset_work_13_14_15);
write.csv(dataset_work_13_14_15, file = "Dataframes/Dataset_Work_NY_June_2013_2014_2015.csv", row.names = FALSE);  # saving work dataset dataframe
detach(dataset_original_13_14_15);                              # detaching database dataframe
attach(dataset_work_13_14_15);                                  # attaching dataset_work dataframe

### factorizing work dataset
# numbering CARRIER using level factor
CARRIER <- as.factor(CARRIER)
levels(CARRIER) <- 1:length(levels(CARRIER))
# numbering ORIGIN using level factor
ORIGIN <- as.factor(ORIGIN)
levels(ORIGIN) <- 1:length(levels(ORIGIN))
# numbering DEST using level factor
DEST <- as.factor(DEST)
levels(DEST) <- 1:length(levels(DEST))

# refreshing work dataframe
dataset_work_factor_13_14_15 <- data.frame(DAY_OF_MONTH, CARRIER, FL_NUM, ORIGIN, DEST, ARR_DEL15);
View(dataset_work_factor_13_14_15);
write.csv(dataset_work_factor_13_14_15, file = "Dataframes/Dataset_Work_Factorized_NY_June_2013_2014_2015.csv", row.names = FALSE);             
# saving dataset_original dataframe
detach(dataset_work_13_14_15);                                  # detaching database dataframe

### removing unnecessary variables
rm(database_13_14_15);
rm(dataset_original_13_14_15);
rm(dataset_work_factor_13_14_15);
rm(CARRIER);
rm(DEST);
rm(ORIGIN);


######
###### 2016
######

### read whole database of month june and year 2016
database_16 <- read.csv("Databases/Database_NY_June_2016.csv");
View(database_16);
attach(database_16);

### fetched important fields of whole database of month june and year 2016
dataset_original_16 <- data.frame(DAY_OF_MONTH, CARRIER, 
                                  ORIGIN_AIRPORT_ID, ORIGIN_AIRPORT_SEQ_ID, ORIGIN_CITY_MARKET_ID, ORIGIN,
                                  DEST_AIRPORT_ID, DEST_AIRPORT_SEQ_ID, DEST_CITY_MARKET_ID, DEST,
                                  ARR_DELAY, ARR_DEL15,
                                  CANCELLED, DIVERTED, FLIGHTS, FL_NUM,
                                  CARRIER_DELAY, WEATHER_DELAY, NAS_DELAY, SECURITY_DELAY, LATE_AIRCRAFT_DELAY,
                                  DIV_AIRPORT_LANDINGS)
View(dataset_original_16)
write.csv(dataset_original_16, file = "Dataframes/Dataset_Original_NY_June_2016.csv", row.names = FALSE); # saving dataset_original dataframe
detach(database_16);                                      # detaching database dataframe
attach(dataset_original_16);                              # attaching dataset_original dataframe


### fetching work fields of whole database of month june and year 2016
dataset_work_16 <- data.frame(DAY_OF_MONTH, CARRIER, FL_NUM, ORIGIN, DEST, ARR_DEL15);
View(dataset_work_16);
write.csv(dataset_work_16, file = "Dataframes/Dataset_Work_NY_June_2016.csv", row.names = FALSE);  # saving work dataset dataframe
detach(dataset_original_16);                              # detaching database dataframe
attach(dataset_work_16);                                  # attaching dataset_work dataframe

### factorizing work dataset
# numbering CARRIER using level factor
CARRIER <- as.factor(CARRIER)
levels(CARRIER) <- 1:length(levels(CARRIER))
# numbering ORIGIN using level factor
ORIGIN <- as.factor(ORIGIN)
levels(ORIGIN) <- 1:length(levels(ORIGIN))
# numbering DEST using level factor
DEST <- as.factor(DEST)
levels(DEST) <- 1:length(levels(DEST))

# refreshing work dataframe
dataset_work_factor_16 <- data.frame(DAY_OF_MONTH, CARRIER, FL_NUM, ORIGIN, DEST, ARR_DEL15);
View(dataset_work_factor_16);
write.csv(dataset_work_factor_16, file = "Dataframes/Dataset_Work_Factorized_NY_June_2016.csv", row.names = FALSE);             
# saving dataset_original dataframe
detach(dataset_work_16);                                  # detaching database dataframe

### removing unnecessary variables
rm(database_16);
rm(dataset_original_16);
rm(dataset_work_factor_16);
rm(CARRIER);
rm(DEST);
rm(ORIGIN);






###### Data Pre Processing
######
###### 2013, 2014 and 2015
######

### creating datasheet
# readung work dataset dataframe
dataset_work_13_14_15 <- read.csv("Dataframes/Dataset_Work_NY_June_2013_2014_2015.csv");  
attach(dataset_work_13_14_15)

# fetching unique values from data frame
carries_set <- unique(as.character(CARRIER));
origin_set <- unique(as.character(ORIGIN));
dest_set <- unique(as.character(DEST));
detach(dataset_work_13_14_15)

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
datasheet_16 <- datasheet_16[, -17];

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






###### Data Classification

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






###### installing packages
install.packages("class");
install.packages("kknn");
install.packages("tree");






###### including libraries
library(class)
library(kknn)
library(tree)
