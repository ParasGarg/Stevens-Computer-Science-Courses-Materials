###### Data Cleaning (STEP 3rd)
#setwd("F:/Stevens/CS 513 - Knowledge Discovery & Data Mining/Project/Flight Delay Prediction/")

### cleaning environment
rm(list = ls())

######
###### 2013, 2014 and 2015
######

### read factorized dataset of month june and year 2013, 2014, & 2015
dataset_factorized_13_14_15 <- read.csv("Dataframes/Dataset_Factorized_NY_June_2013_2014_2015.csv");
View(dataset_factorized_13_14_15);
attach(dataset_factorized_13_14_15);

### removing rows from datasheet which have NA values in ArrDelay or ArrDel15
# creating new null data frame having same columns
dataset_cleaned_13_14_15 <- data.frame(matrix(nrow = 0, ncol = length(dataset_factorized_13_14_15)));
colnames(dataset_cleaned_13_14_15) <- c(colnames(dataset_factorized_13_14_15));
View(dataset_cleaned_13_14_15);

# filling the dataframe
null_count <- 0;
for (i in seq(from = 1, to = nrow(dataset_factorized_13_14_15), by = 1)){
  if (!is.na(ARR_DELAY[i]) && !is.na(ARR_DEL15[i])) {
    dataset_cleaned_13_14_15[i - null_count, ] <- dataset_factorized_13_14_15[i, ]
  } else {
    null_count <- null_count + 1;
  }
}
    # number of records before removing were 135980
    # number of records after removing are 131393
    # total time lapsed was 1 hour 7 minutes and 51 seconds (approx 68 minutes)

View(dataset_cleaned_13_14_15);
write.csv(dataset_cleaned_13_14_15, file = "Dataframes/Dataset_Clean_(Arrival_Column)_NY_June_2013_2014_2015.csv", row.names = FALSE); # saving dataset_cleaned dataframe
detach(dataset_factorized_13_14_15);

######
###### 2016
######

### read factorized dataset of month june and year 2013, 2014, & 2015
dataset_factorized_16 <- read.csv("Dataframes/Dataset_Factorized_NY_June_2016.csv");
View(dataset_factorized_16);
attach(dataset_factorized_16)

### removing rows from datasheet which have NA values in ArrDelay or ArrDel15
# creating new null data frame having same columns
dataset_cleaned_16 <- data.frame(matrix(nrow = 0, ncol = length(dataset_factorized_16)));
colnames(dataset_cleaned_16) <- c(colnames(dataset_factorized_16));
View(dataset_cleaned_16);

# filling the dataframe
null_count <- 0;
Sys.time()
for (i in seq(from = 1, to = nrow(dataset_factorized_16), by = 1)){
  if (!is.na(ARR_DELAY[i]) && !is.na(ARR_DEL15[i])) {
    dataset_cleaned_16[i - null_count, ] <- dataset_factorized_16[i, ]
  } else {
    null_count <- null_count + 1;
  }
}
Sys.time()
    # number of records before removing were 42511
    # number of records after removing are 41871
    # total time lapsed was 4 minutes and 12 seconds (approx 4 minutes)

View(dataset_cleaned_16);
write.csv(dataset_cleaned_16, file = "Dataframes/Dataset_Clean_(Arrival_Column)_NY_June_2016.csv", row.names = FALSE); # saving dataset_cleaned dataframe
detach(dataset_factorized_16)