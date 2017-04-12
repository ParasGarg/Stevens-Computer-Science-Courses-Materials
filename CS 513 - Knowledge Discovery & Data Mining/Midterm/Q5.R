###### Knowledge Discovery and Data Mining (CS 513) ######
#                       (Midterm)

# Course      : CS 513 - A
# First Name  : PARAS 
# Last Name   : GARG
# Id          : 10414982
# Purpose     : Midterm : Question 5

###### ******************************************** ######

# clearing object environment
rm(list=ls());

# loading knn for use
library(class)

# Question 5.1. A telecommunications company is analyzing its customers’ data  
#     for those customers that had between 0 and 175 “Day”, “Eve” and “Night” calls.  
#     To estimate the missing “Night Calls”  field, the company is using k-nearest 
#     neighbors. 

  # creating vector list for given data
  dayCalls <- c(110, 123, 71, 113, 98, 114);
  eveCalls <- c(99, 103, 88, 122, 101, 110);
  nightCalls <- c(91, 103, 89, 121, 118);

  # min-max normalization
  mmNorm <- function(x, xMin, xMax) {
    z <- ((x - xMin)/(xMax - xMin));
    return(z);
  }

  # getting normalize value
  dayCallsNorm <- mmNorm(dayCalls, 0, 175);
  eveCallsNorm <- mmNorm(eveCalls, 0, 175);
  # combining call normalize lists
  normMatrix <- cbind(dayCallsNorm, eveCallsNorm);
  
  # setting train and test data 
  trainSet <- normMatrix[1:5, ] 
  testSet <- normMatrix[-(1:5), ]

# What would be the value of “Night Calls” for customer x in the table below if:
# 5.1.1. K = 1 and method = ”unweighted vote” is used
  k1 <- knn(trainSet, testSet, nightCalls, k=1);
  k1;

# 5.1.2. K = 2 and method = ”unweighted vote” is used
  k2 <- knn(trainSet, testSet, nightCalls, k=2);
  k2;
  
# 5.1.3. K = 3 and method = ”distance weighted vote” is used?
    # calculating distance
    distance <- dist(normMatrix);
    
    # calculating weighted vote
    start <- length(normMatrix)/2-1;
    through <- length(distance)/1;
    increase <- start-1;  
    wieghtedVote <- NULL;
  
    while(start <= through && increase >= 0) {
      
      wieghtedVote <- c(wieghtedVote, 1/(distance[start]^2));
  
      start <- start + increase;
      increase <- increase - 1;
    }
    
    # removing useless vectors
    rm(increase);
    rm(start);
    rm(through);
  
    weightMatrix <- cbind(Night_Calls = nightCalls, Wieghted_Vote = wieghtedVote);
    
k3 <- weightMatrix[length(weightMatrix) - match(max(wieghtedVote), weightMatrix) - 1]
k3;    


# clearing object environment
rm(list=ls());
    
# Question 5.2. The company has decided to classify “Night Calls” by category instead of 
#     estimating a number.  Furthermore, it has obtained additional customer information 
#     with the exact profile of customer X.
# What would be the “Night Call” category for X if K=3 and distance weighted vote is used? Why? 
  
  # creating vector list for given data
  dayCalls <- c(110, 123, 71, 113, 98, 114, 114, 114, 114);
  eveCalls <- c(99, 103, 88, 122, 101, 110, 110, 110, 110);
  nightCalls <- c("Low", "Medium", "Low", "High", "Medium", "High", "Medium", "Medium");

  # min-max normalization
  mmNorm <- function(x, xMin, xMax) {
    z <- ((x - xMin)/(xMax - xMin));
    return(z);
  }
  
  # getting normalize value
  dayCallsNorm <- mmNorm(dayCalls, 0, 175);
  eveCallsNorm <- mmNorm(eveCalls, 0, 175);
  # combining call normalize lists
  normMatrix <- cbind(dayCallsNorm, eveCallsNorm);
  
  # calculating distance
  distance <- dist(normMatrix);
  
  # calculating weighted vote
  start <- length(normMatrix)/2-1;
  through <- length(distance)/1;
  increase <- start-1;
  wieghtedVote <- NULL;
  
  while(start <= through && increase >= 0) {
    
    wieghtedVote <- c(wieghtedVote, 1/(distance[start]^2));
   
    start <- start + increase;
    increase <- increase - 1;
  }
  
  # removing useless vectors
  rm(increase);
  rm(start);
  rm(through)

  weightMatrix <- cbind(Night_Calls = nightCalls, Wieghted_Vote = wieghtedVote)
