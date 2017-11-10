# Assignment 1
# Problem 2

# CLEAR WORK DIRECTORY
rm(list=ls())
setwd("C:/Users/Paras Garg/Documents/R/FE Assignments")

# INSTALLING AND USING PACKAGES
install.packages('doBy')
install.packages('ggplot2')
install.packages('plyr')
library('doBy')
library('ggplot2')
library('plyr')

### LOADING DATASETS
day_1 <- data.frame(read.csv("nyt1.csv"))
day_2 <- data.frame(read.csv("nyt2.csv"))
day_3 <- data.frame(read.csv("nyt3.csv"))

### FUNCTIONS
  # CREATE NEW AGE_GROUP VARIABLE
  age_var <- function (df) {
    df$Age_Group[df$Age < 20] <- '<20'
    df$Age_Group[df$Age >= 20 & df$Age < 30] <- '20-29'
    df$Age_Group[df$Age >= 30 & df$Age < 40] <- '30-39'
    df$Age_Group[df$Age >= 40 & df$Age < 50] <- '40-49'
    df$Age_Group[df$Age >= 50 & df$Age < 60] <- '50-59'
    df$Age_Group[df$Age >= 60 & df$Age < 70] <- '60-69'
    df$Age_Group[df$Age >= 70] <- '70+'
    
    #df$Age_Group <- cut(df$Age, c(-Inf,0,20,30,40,50,60,70,Inf), include.lowest = FALSE)
    return (df)
  }
  
  data_prep <- function (df) {
    df$Gender[df$Gender == 1] <- "Male"
    df$Gender[df$Gender == 0] <- "Female"
    df$Signed_In[df$Signed_In == 1] <- "Signed In"
    df$Signed_In[df$Signed_In == 0] <- "Not Signed In"
    return(df)
  }
  
  imp <- function(df, day) {
    ggplot(df, aes(x=Impressions, color=Age_Group)) + geom_density() + 
      xlab("Impressions") + labs(color="Age") + ggtitle(paste(day, "Impressions", sep=": "))
  }
  
  ctr <- function(df, day, ref) {
    if (ref == "Imp") {
      ref <- "(Impressions > 0)"
    } else if (ref == "Clks") {
      ref <- "(Clicks > 0)"
    }
    
    ggplot(df, aes(x=Clicks/Impressions, color=Age_Group)) + geom_density() +
      xlab("Click-through-rate (CTR)") + labs(color="Age") +
      ggtitle(paste(day, "CTR", ref, sep=" : "))
  }
  
  click_var <- function (df) {
    df$Clicks_Cat <- cut(df$Clicks, c(-Inf,0,1,2,3,4,Inf), include.lowest = FALSE)
    return (df)
  }
  
  group_stats <- function(x) { 
    c(length(x), min(x), max(x), mean(x))
  }
  
### Data Preparation
day_1 <- data_prep(age_var(day_1))
day_2 <- data_prep(age_var(day_2))
day_3 <- data_prep(age_var(day_3))

### ANALYSIS
#Impression
imp(day_1, "Day 1")
imp(day_2, "Day 2")
imp(day_2, "Day 3")
  
# Click Through Rate
ctr(subset(day_1, Impressions > 0), "Day 1", "Imp")
ctr(subset(day_2, Impressions > 0), "Day 2", "Imp")
ctr(subset(day_3, Impressions > 0), "Day 3", "Imp")

ctr(subset(day_1, Clicks > 0), "Day 1", "Clks")
ctr(subset(day_2, Clicks > 0), "Day 2", "Clks")
ctr(subset(day_3, Clicks > 0), "Day 3", "Clks")

# Impressions across Age Group
age_imp_boxplot <- function (df, day) {
  ggplot(df, aes(x = Age_Group, y = Impressions, fill=Age_Group)) + 
    geom_boxplot() +
    xlab("Age Group") + guides(fill=FALSE) +
    ggtitle(paste(day, "Impressions Across Age Groups", sep=": "))
}

age_imp_hist <- function (df, day) {
  ggplot(df, aes(x = Impressions, fill = Age_Group)) +
    geom_histogram(bins = 15) + ggtitle(paste(day, "Impressions Across Age Groups", sep=": "))
}

age_imp_boxplot(day_1, "Day 1")
age_imp_boxplot(day_2, "Day 2")
age_imp_boxplot(day_3, "Day 3")

age_imp_hist(day_1, "Day 1")
age_imp_hist(day_2, "Day 2")
age_imp_hist(day_3, "Day 3")
  
# Click Through Rate across Age Group
age_ctr_boxplot <- function (df, day) {
  ggplot(df, aes(x = Age_Group, y = Clicks/Impressions, fill=Age_Group)) + 
    geom_boxplot() +
    xlab("Age Group") + guides(fill=FALSE) +
    theme(plot.title = element_text(size=10)) +
    ggtitle(paste(day, "CTR Across Age Groups", sep=": "))
}

age_ctr_hist <- function (df, day) {
  ggplot(df, aes(x = Clicks/Impressions, fill = Age_Group)) +
    theme(plot.title = element_text(size=10)) +
    geom_histogram(bins = 15) + ggtitle(paste(day, "CTR Across Age Groups", sep=": "))
}

age_ctr_boxplot(subset(day_1, Clicks > 0 & Impressions > 0), "Day 1")
age_ctr_boxplot(subset(day_2, Clicks > 0 & Impressions > 0), "Day 2")
age_ctr_boxplot(subset(day_3, Clicks > 0 & Impressions > 0), "Day 3")

age_ctr_hist(subset(day_1, Clicks > 0 & Impressions > 0), "Day 1")
age_ctr_hist(subset(day_2, Clicks > 0 & Impressions > 0), "Day 2")
age_ctr_hist(subset(day_3, Clicks > 0 & Impressions > 0), "Day 3")

### Comparisons across user segments/demographics
# Male v/s Female
male_vs_female <- function (df, age_grp, day) {
  df <- subset(df, Age_Group == age_grp)
  
  ggplot(df, aes(x = Gender, y = ..count..)) + 
    geom_bar(aes(colour = "black", fill = Gender)) +
    geom_text(stat='count', aes(label=..count..),vjust=2) +
    xlab("Gender") + 
    ggtitle(paste(day, "Age Group (<20 Age)", sep = " : "))
}

male_vs_female(day_1, "<20", "Day 1")
male_vs_female(day_2, "<20", "Day 2")
male_vs_female(day_3, "<20", "Day 3")

# SignedIn v/s Not SignedIn
loggedin_vs_not <- function (df, day) {
  ggplot(df, aes(x = Signed_In, y = ..count../1000)) + 
    geom_bar(aes(colour = "black", fill = Signed_In)) +
    geom_text(stat='count', aes(label=..count..), vjust=2) +
    ylab("Total (in thousands)") + 
    xlab("Day 1: Logged In Stats") +
    ggtitle(paste(day, "Signed In Status", sep = " : "))
}

loggedin_vs_not(day_1, "Day 1")
loggedin_vs_not(day_2, "Day 2")
loggedin_vs_not(day_3, "Day 3")

# Clicked v/s not clicked
clicked_vs_not <- function (df, day) {
  df$Have_Clicked[df$Clicks > 0] <- "Clicked"
  df$Have_Clicked[df$Clicks == 0] <- "Not Clicked"
  
  ggplot(df, aes(x = Have_Clicked, y = ..count../1000)) + 
    geom_bar(aes(colour = "black", fill = Have_Clicked)) +
    geom_text(stat='count', aes(label=..count..),vjust=1.5) +
    ylab("Total (in thousands)") + 
    xlab("Clicks") +
    ggtitle(paste(day, "Clicks Status", sep = " : "))
}

clicked_vs_not(day_1, "Day 1")
clicked_vs_not(day_2, "Day 2")
clicked_vs_not(day_3, "Day 3")


### METRICS AND DISTRIBUTION ANALYSIS
# Impression across age groups
ggplot(day_1,aes(x=Age_Group, y=Impressions, fill=Age_Group)) +
  geom_boxplot() + xlab("Age Grpups") + guides(fill=FALSE) +
  ggtitle("Day 1: Impressions accross Age Group")

ggplot(day_2,aes(x=Age_Group, y=Impressions, fill=Age_Group)) +
  geom_boxplot() + xlab("Age Grpups") + guides(fill=FALSE) +
  ggtitle("Day 2: Impressions accross Age Group")

ggplot(day_3,aes(x=Age_Group, y=Impressions, fill=Age_Group)) +
  geom_boxplot() + xlab("Age Grpups") + guides(fill=FALSE) +
  ggtitle("Day 3: Impressions accross Age Group")


# Number of Impressions across Age Groups 
ggplot(day_1, aes(x=Impressions, y = ..count../1000, fill=Age_Group)) +
  ylab("Total (in thousands)") + 
  geom_histogram(bins = 15) + ggtitle("Day 1: Number of Impressions")

ggplot(day_2, aes(x=Impressions, y = ..count../1000, fill=Age_Group)) +
  ylab("Total (in thousands)") + 
  geom_histogram(bins = 15) + ggtitle("Day 2: Number of Impressions")

ggplot(day_3, aes(x=Impressions, y = ..count../1000, fill=Age_Group)) +
  ylab("Total (in thousands)") + 
  geom_histogram(bins = 15) + ggtitle("Day 3: Number of Impressions")


# Number of Impressions across Gender
ggplot(day_1, aes(x=Impressions,  fill=Gender, colour=Gender)) + 
  geom_bar() +
  xlab("Impressions") + ggtitle("Day 1: Impressions across Gender")

ggplot(day_2, aes(x=Impressions,  fill=Gender, colour=Gender)) + 
  geom_bar() +
  xlab("Impressions") + ggtitle("Day 2: Impressions across Gender")

ggplot(day_3, aes(x=Impressions,  fill=Gender, colour=Gender)) + 
  geom_bar() +
  xlab("Impressions") + ggtitle("Day 3: Impressions across Gender")


# Distribution of Clicks across Gender
ggplot(subset(day_1, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Gender)) + geom_bar() +
  ggtitle("Day 1: Clicks across Gender")

ggplot(subset(day_2, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Gender)) + geom_bar() +
  ggtitle("Day 2: Clicks across Gender")

ggplot(subset(day_3, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Gender)) + geom_bar() +
  ggtitle("Day 3: Clicks across Gender")


# Distribution of Clicks across Age Groups
ggplot(subset(day_1, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Age_Group)) + geom_bar() +
  ggtitle("Day 1: Clicks across Age Groups")

ggplot(subset(day_2, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Age_Group)) + geom_bar() +
  ggtitle("Day 2: Clicks across Age Groups")

ggplot(subset(day_3, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Age_Group)) + geom_bar() +
  ggtitle("Day 3: Clicks across Age Groups")

# Distribution of Clicks across signed in status
ggplot(subset(day_1, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Signed_In)) + geom_bar() +
  ggtitle("Day 1: Clicks across User SignedIn Status")

ggplot(subset(day_3, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Signed_In)) + geom_bar() +
  ggtitle("Day 2: Clicks across User SignedIn Status")

ggplot(subset(day_3, Impressions > 0 & Clicks > 0), aes(x=Clicks, fill=Signed_In)) + geom_bar() +
  ggtitle("Day 3: Clicks across User SignedIn Status")
