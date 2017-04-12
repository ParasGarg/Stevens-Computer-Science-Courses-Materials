###### Knowledge Discovery and Data Mining (CS 513) ######
#                       (Midterm)

# Course      : CS 513 - A
# First Name  : PARAS 
# Last Name   : GARG
# Id          : 10414982
# Purpose     : Midterm : Question 3

###### ******************************************** ######

# clearing object environment
rm(list=ls());

# Question 3. Using R perform the following 
  
  # 3.a. Load the following CSV file to your R environment: http://www.math.smith.edu/sasr/datasets/help.csv
  dataset <- read.csv("http://www.math.smith.edu/sasr/datasets/help.csv");
  attach(dataset);
  View(dataset);
  
  # 3.b. Create a dataframe of: id, age, number of days any substance used (daysanysub), substance, and race group
  dataframe <- data.frame(frame_id = id,
                          frame_age = age,
                          frame_no_days = daysanysub,
                          frame_substance = substance,
                          frame_race_group = racegrp);
  attach(dataframe);
  View(dataframe);
  
  # 3.c. Normalize number of days any substance used (daysanysub)
  noDaysMax = max(frame_no_days, na.rm = TRUE);
  noDaysMin = min(frame_no_days, na.rm = TRUE);
  
  mmNorm <- function(x, xMin, xMax) {  # normalization function
    z <- ((x - xMin)/(xMax - xMin));   # min-max normalization
    return(z);
  }
  
  mmNorm(frame_no_days, noDaysMin, noDaysMax);  # calling function
  
  # 3.d. Substitute the missing values of  daysanysub with zero
  dataframe$frame_no_days[is.na(frame_no_days)] <- 0;
  
  # 3.e. Calculate: Mean, Max, Median, STD of Age
  ageMean <- mean(frame_age, na.rm = TRUE);
  ageMax <- max(frame_age, na.rm = TRUE)
  ageMedian <- median(frame_age, na.rm = TRUE);
  ageSTD <- sd(frame_age, na.rm = TRUE);
  
  # 3.f. Create a categorical variable age_group as:
  dataframe$frame_age_group <- NA;   # adding a null column to existing dataframe
  
  for(i in seq(from=1, to=nrow(dataframe), by=1)) {
    
    # 3.f.i. From 0 up to and including 30 = Young
    if(dataframe$frame_age[i] > 0 && dataframe$frame_age[i] <= 30) {
      dataframe$frame_age_group[i] <- "young";
    } 
    # 3.f.ii. Over 30 up to and including 60 = Middle Age
    else if (dataframe$frame_age[i] > 30 && dataframe$frame_age[i] <= 60){
      dataframe$frame_age_group[i] <- "middle age";
    }
    # 3.f.iii. Older than 60 = Old
    else if (dataframe$frame_age[i] > 60) {
      dataframe$frame_age_group[i] <- "old";
    }
  }
  
  # 3.g. Create training and test datasets by: 
  #      Choosing every third record as test and the remaining records as training
  setRange <- seq(from = 1, to = nrow(dataframe), by = 3);
    
    # creating test dataset by choosing every third record starting from first
    testDataset <- dataframe[setRange, ];
  
    # creating training dataset by all remaining records those weren't used in test dataset
    trainingDataset <- dataframe[-setRange, ];
  
  
# detaching datasets from search
detach(dataset);
detach(dataframe);
rm(list=ls());

  