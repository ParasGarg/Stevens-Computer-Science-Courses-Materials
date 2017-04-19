###### Data Sorting (STEP 2nd)
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
dataset_original_13_14_15 <- data.frame(DAY_OF_MONTH, DAY_OF_WEEK, CARRIER, 
                                        ORIGIN, DEST, ARR_DELAY, ARR_DEL15,
                                        CARRIER_DELAY, WEATHER_DELAY, NAS_DELAY, SECURITY_DELAY, LATE_AIRCRAFT_DELAY,
                                        DIV_AIRPORT_LANDINGS)
View(dataset_original_13_14_15)
write.csv(dataset_original_13_14_15, file = "Dataframes/Dataset_Original_NY_June_2013_2014_2015.csv", row.names = FALSE); # saving dataset_original dataframe
detach(database_13_14_15);                                      # detaching database dataframe
attach(dataset_original_13_14_15);                              # attaching dataset_original dataframe


### factorizing dataset (assigning every character value as numeric value)
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
dataset_factorized_13_14_15 <- data.frame(DAY_OF_MONTH, DAY_OF_WEEK, CARRIER, 
                                          ORIGIN, DEST, ARR_DELAY, ARR_DEL15,
                                          CARRIER_DELAY, WEATHER_DELAY, NAS_DELAY, SECURITY_DELAY, LATE_AIRCRAFT_DELAY,
                                          DIV_AIRPORT_LANDINGS);
View(dataset_factorized_13_14_15);
write.csv(dataset_factorized_13_14_15, file = "Dataframes/Dataset_Factorized_NY_June_2013_2014_2015.csv", row.names = FALSE);             
# saving dataset_original dataframe
detach(dataset_original_13_14_15);                                  # detaching database dataframe

### removing unnecessary variables
rm(database_13_14_15);
rm(dataset_original_13_14_15);
rm(dataset_factorized_13_14_15);
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
dataset_original_16 <- data.frame(DAY_OF_MONTH, DAY_OF_WEEK, CARRIER, 
                                  ORIGIN, DEST, ARR_DELAY, ARR_DEL15,
                                  CARRIER_DELAY, WEATHER_DELAY, NAS_DELAY, SECURITY_DELAY, LATE_AIRCRAFT_DELAY,
                                  DIV_AIRPORT_LANDINGS)
View(dataset_original_16)
write.csv(dataset_original_16, file = "Dataframes/Dataset_Original_NY_June_2016.csv", row.names = FALSE); # saving dataset_original dataframe
detach(database_16);                                      # detaching database dataframe
attach(dataset_original_16);                              # attaching dataset_original dataframe


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
dataset_factorized_16 <- data.frame(DAY_OF_MONTH, DAY_OF_WEEK, CARRIER, 
                                    ORIGIN, DEST, ARR_DELAY, ARR_DEL15,
                                    CARRIER_DELAY, WEATHER_DELAY, NAS_DELAY, SECURITY_DELAY, LATE_AIRCRAFT_DELAY,
                                    DIV_AIRPORT_LANDINGS);
View(dataset_factorized_16);
write.csv(dataset_factorized_16, file = "Dataframes/Dataset_Factorized_NY_June_2016.csv", row.names = FALSE);             
# saving dataset_original dataframe
detach(dataset_original_16);                                  # detaching database dataframe

### removing unnecessary variables
rm(database_16);
rm(dataset_original_16);
rm(dataset_factorized_16);
rm(CARRIER);
rm(DEST);
rm(ORIGIN)












