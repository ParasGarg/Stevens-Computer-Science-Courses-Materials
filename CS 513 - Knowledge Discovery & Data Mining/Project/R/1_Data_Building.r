###### Data Building (STEP 1st)
#setwd("F:/Stevens/CS 513 - Knowledge Discovery & Data Mining/Project/Flight Delay Prediction/")

### cleaning environment
rm(list = ls())

### read database of month - June 2013, June 2014, and June 2015
database_2013 <- read.csv("Databases/Database_NY_June_2013.csv");
database_2014 <- read.csv("Databases/Database_NY_June_2014.csv");
database_2015 <- read.csv("Databases/Database_NY_June_2015.csv");
database_2016 <- read.csv("Databases/Database_NY_June_2016.csv");

database <- rbind(database_2013, database_2014, database_2015)
View(database);

### saving database in directory
write.csv(database, file = "Databases/Database_NY_June_2013_2014_2015.csv", row.names = FALSE)
write.csv(database_2016, file = "Databases/Database_NY_June_2016.csv", row.names = FALSE)

### removing unnecessary variables
rm(database_2013);
rm(database_2014);
rm(database_2015);
rm(database_2016)