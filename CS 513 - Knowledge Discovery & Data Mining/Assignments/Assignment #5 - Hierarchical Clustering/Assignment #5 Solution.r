######## Knowledge Discovery and Data Mining (CS 513) ########
# (Assignment 5 - Hierarchical Clustering and Churn Dataset)

# Course      : CS 513 - A
# First Name  : PARAS 
# Last Name   : GARG
# Id          : 10414982
# Purpose     : Assignment 5 - Hierarchical Clustering and Churn Dataset

######## ******************************************** ########

# clearing object environment
rm(list=ls());


# 5.1. Please use the "Hierarchical Clustering in R and the "average" linkage method to cluster the following 10 items
  
  # creating vectors
  x <- c(7, 10, 13, 21, 28, 28, 35, 43, 44, 50);
  y <- c(57, 62, 63, 71, 78, 88, 89, 90, 94, 98);
  # binding x & y vectors in xy vector
  xy <- cbind(x, y);
  # calculating distance between x and y
  xyDist <- dist(xy);
  # calculating hierarchical clustering
  xyHierarchical <- hclust(xyDist);
  plot(xyHierarchical);
  # calculating average linkage clustering
  xyAverage <- hclust(xyDist, method="average");
  plot(xyAverage);
  

# 5.2. In the CHURN dataset use R to classify (cluster) the customers, 
#      into 3 groups (clusters) based on :
#      international plan, voice plan, and customer service calls.

  # reading CHURN dataset
  #churn <- read.csv("https://raw.githubusercontent.com/ericchiang/churn/master/data/churn.csv");
  churn <- read.csv(file="churn.csv");
  View(churn);
  
  # internation calls vector
  inCalls <- churn[, "Intl.Calls"];
  
  # voice plan vector
  vPlan <- churn[, "VMail.Plan"];
    # factoring vPlan if 'yes' then consider it as '1' and if 'no' then '0'
    vPlan <- as.factor(vPlan);
    levels(vPlan) <- 1:length(levels(vPlan));
    vPlan <- as.numeric(vPlan)-1;
  
  # customer service calls vector
  csCalls <- churn[, "CustServ.Calls"];
  
  # matrix of vectors on which clustering is based
  vectorMatrix <- cbind(inCalls, vPlan, csCalls);
  
  # k-means clustering algorithm
  clust <- kmeans(vectorMatrix, 3);
  
  # plotting a graph
  ?plot()
  
  plot(vectorMatrix, col=clust$cluster);
  points(clust$centers, col=1:3, pch=10, cex=5)
  