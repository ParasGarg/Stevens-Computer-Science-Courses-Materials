###### Knowledge Discovery and Data Mining (CS 513) ######
#         (Assignment 3 - Explore and Clean)

# Course      : CS 513 - A
# First Name  : PARAS 
# Last Name   : GARG
# Id          : 10414982
# Purpose     : Assignment 3 - Explore and Clean

###### ******************************************** ######

# clearing object environment
rm(list=ls());


# 3.1. Load the following CSV file to your R environment : http://www.math.smith.edu/sasr/datasets/help.csv
loadCSVFile <- read.csv("http://www.math.smith.edu/sasr/datasets/help.csv");  # reading file 
View(loadCSVFile);                                                            # viewing file


# 3.2. Using the above file perform the following,
# 3.2.1. Create a dataframe of: id, pcs1, mcs1, substance, and race group
newDataFrame = data.frame( id        = loadCSVFile$id, 
                           pcs1      = loadCSVFile$pcs1, 
                           mcs1      = loadCSVFile$mcs1, 
                           substance = loadCSVFile$substance, 
                           racegroup = loadCSVFile$racegrp );
View(newDataFrame);


# 3.2.2. Calculate: Mean, Max, STD, Max, Min of mcs1
  # mean
  mean(newDataFrame$mcs1, na.rm = TRUE);
  #median
  median(newDataFrame$mcs1, na.rm = TRUE)
  # standard deviation
  sd(newDataFrame$mcs1, na.rm = TRUE);
  # maximum
  max(newDataFrame$mcs1, na.rm = TRUE);
  # minimum
  min(newDataFrame$mcs1, na.rm = TRUE);

  # summary excute all the functions
  summary(newDataFrame$mcs1);

 
# 3.2.3. Create a frequency table of substance vs. racegroup
table(substance = newDataFrame$substance, racegroup = newDataFrame$racegroup)


# 3.2.4. Substitute the missing values of mcs1 by the overall average
for(i in seq(from=1, to=length(newDataFrame$mcs1), by=1)){
  if(is.na(newDataFrame$mcs1[i]))
    newDataFrame$mcs1[i] <- mean(newDataFrame$mcs1, na.rm = TRUE);
}
# the other way to repace all the values of mcs1 by the overall average is
  newDataFrame$mcs1[is.na(newDataFrame$mcs1)] <- mean(newDataFrame$mcs1, na.rm = TRUE);
  
View(newDataFrame);
