###### ASSIGNMENT 1 ######
###### QUESTION 1 ######

### CLEANING ENVIRONMENT AND SETTING WORK DIRECTORY
rm(list=ls())
setwd("C:/Users/Paras Garg/Documents/R/FE Assignments/")

### INSTALLING AND INCLUING PACKAGES
install.packages('gdata')
install.packages('ggplot2')
install.packages('plyr')
library('gdata')
library('ggplot2')
library('plyr')
library("doBy")

### LOADING DATASETS
bronx <- read.xls("rollingsales_bronx.xls", perl = "C:\\Perl64\\bin\\perl.exe", pattern="BOROUGH")
brooklyn <- read.xls("rollingsales_brooklyn.xls", perl = "C:\\Perl64\\bin\\perl.exe", pattern="BOROUGH")
manhattan <- read.xls("rollingsales_manhattan.xls", perl = "C:\\Perl64\\bin\\perl.exe", pattern="BOROUGH")
queens <- read.xls("rollingsales_queens.xls", perl = "C:\\Perl64\\bin\\perl.exe", pattern="BOROUGH")
staten <- read.xls("rollingsales_statenisland.xls", perl = "C:\\Perl64\\bin\\perl.exe", pattern="BOROUGH")

### DATA FORMATTING FUNCTION
format_data <- function (df) {
  df$GROSS.SQUARE.FEET.N <- as.numeric((gsub("[^[:digit:]]","", df$GROSS.SQUARE.FEET)))
  df$LAND.SQUARE.FEET.N <- as.numeric((gsub("[^[:digit:]]","", df$LAND.SQUARE.FEET)))
  df$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",df$SALE.PRICE))
  
  df$SALE.DATE <- as.Date(df$SALE.DATE)
  df$YEAR.BUILT <- as.numeric(as.character(df$YEAR.BUILT))
  
  return (df)
}

### DATA CLEANING FUNCTION
clean_data <- function (df) {
  #Removing NA values
  df <- df[!is.na(df$GROSS.SQUARE.FEET.N), ]
  df <- df[!is.na(df$LAND.SQUARE.FEET.N), ]
  df <- df[!is.na(df$SALE.PRICE.N), ]
  
  #Removing outliners
  df$SALE.PRICE.LOG <- log(df$SALE.PRICE.N)
  df <- df[df$SALE.PRICE.LOG > 5, ]
  
  #Categorize sales buildings
  family_category <- grepl("FAMILY", df$BUILDING.CLASS.CATEGORY) * 1
  condos_category <- grepl("CONDOS", df$BUILDING.CLASS.CATEGORY) * 2
  coops_category <- grepl("COOPS", df$BUILDING.CLASS.CATEGORY) * 3
  
  category <- as.character(family_category + condos_category + coops_category)
  category[category == "1"] <- "FAMILY"
  category[category == "2"] <- "CONDOS"
  category[category == "3"] <- "COOPS"
  category[category == "0"] <- "OTHERS"
  
  df$BUILDING.CLASS.CATEGORY.N <- factor(category)
  
  return (df)
}

### DATA FRAMES FORMATTING AND CLEANING
bronxDf <- clean_data(format_data(bronx))
brooklynDf <- clean_data(format_data(brooklyn))
manhattanDf <- clean_data(format_data(manhattan))
queensDf <- clean_data(format_data(queens))
statenDf <- clean_data(format_data(staten))

### ANALYSIS ACROSS BOROUGHS
  # Borough vs Sale Price for particular Building Class
  borough_sp <- function (class) {
      outliers <- bronxDf$SALE.PRICE.LOG[bronxDf$BUILDING.CLASS.CATEGORY.N == class]
      borough_1 <- data.frame(BOROUGH = rep("Bronx", length(outliers)), SALE.PRICE.LOG = outliers)

      outliers <- brooklynDf$SALE.PRICE.LOG[brooklynDf$BUILDING.CLASS.CATEGORY.N == class]
      borough_2 <- data.frame(BOROUGH = rep("Brooklyn", length(outliers)), SALE.PRICE.LOG = outliers)
      
      outliers <- manhattanDf$SALE.PRICE.LOG[manhattanDf$BUILDING.CLASS.CATEGORY.N == class]
      borough_3 <- data.frame(BOROUGH = rep("Manhattan", length(outliers)), SALE.PRICE.LOG = outliers)
      
      outliers <- queensDf$SALE.PRICE.LOG[queensDf$BUILDING.CLASS.CATEGORY.N == class]
      borough_4 <- data.frame(BOROUGH = rep("Queens", length(outliers)), SALE.PRICE.LOG = outliers)
      
      outliers <- statenDf$SALE.PRICE.LOG[statenDf$BUILDING.CLASS.CATEGORY.N == class]
      borough_5 <- data.frame(BOROUGH = rep("Staten Island", length(outliers)), SALE.PRICE.LOG = outliers)
    
      finalDf <- rbind(borough_1, borough_2, borough_3, borough_4, borough_5)
      ggplot(finalDf, aes(x=BOROUGH, y=SALE.PRICE.LOG, fill=BOROUGH, colour=BOROUGH, group=BOROUGH)) + 
        geom_boxplot() +
        ggtitle(class)
  }
  
  borough_sp("FAMILY")
  borough_sp("CONDOS")
  borough_sp("COOPS")
  borough_sp("OTHERS")
  
  
  # Building Class vs Sale Price for particular Borough
  building_sp <- function (df, borough) {
    BUILDING.CLASS <- df$BUILDING.CLASS.CATEGORY.N
    SALE.PRICE.LOG <- df$SALE.PRICE.LOG
    
    ggplot(df, aes(x=BUILDING.CLASS, y=SALE.PRICE.LOG, fill=BUILDING.CLASS, colour=BUILDING.CLASS, group=BUILDING.CLASS)) + 
      geom_boxplot() +
      ggtitle(borough)
  }
  
  building_sp(bronxDf, "BRONX")
  building_sp(brooklynDf, "BROOKLYN")
  building_sp(manhattanDf, "MANHATTAN")
  building_sp(queensDf, "QUEENS")
  building_sp(statenDf, "STATEN ISLAND")
  
  
  # Sale Price vs Gross Square feet for particular Borough
  gross_sp <- function (df, borough) {
    SALE.PRICE.LOG <- df$SALE.PRICE.LOG
    GROSS.SQFT.LOG <- log(df$GROSS.SQUARE.FEET.N)
    BUILDING.CLASS <- df$BUILDING.CLASS.CATEGORY.N
    
    ggplot(df, aes(x=SALE.PRICE.LOG, y=GROSS.SQFT.LOG, fill=BUILDING.CLASS, colour=BUILDING.CLASS)) +
      geom_point() + 
      ggtitle(borough)
  }
  
  gross_sp(bronxDf, "BRONX")
  gross_sp(brooklynDf, "BROOKLYN")
  gross_sp(manhattanDf, "MANHATTAN")
  gross_sp(queensDf, "QUEENS")
  gross_sp(statenDf, "STATEN ISLAND")
  
  
  # Sale Price vs Frequency for particular Borough
  sp_freq <- function (df, borough) {
    par(mfrow=c(2,2))
    hist(log(df[df$BUILDING.CLASS.CATEGORY.N=="FAMILY",]$SALE.PRICE.N),
         col="#8daeb4", main="Family Homes", xlab= "SALE.PRICE.LOG",
         cex.lab=0.75, cex.main=0.75, cex.axis=0.75)
    hist(log(df[df$BUILDING.CLASS.CATEGORY.N=="CONDOS",]$SALE.PRICE.N),
         col="#0d447a", main="CONDOS", xlab= "SALE.PRICE.LOG",
         cex.lab=0.75, cex.main=0.75, cex.axis=0.75)
    hist(log(df[df$BUILDING.CLASS.CATEGORY.N=="COOPS",]$SALE.PRICE.N),
         col="#ffbe4c", main="COOPS", xlab= "SALE.PRICE.LOG",
         cex.lab=0.75, cex.main=0.75, cex.axis=0.75)
    hist(log(df[df$BUILDING.CLASS.CATEGORY.N=="OTHERS",]$SALE.PRICE.N),
         col="#fddf5f", main="Others", xlab= "SALE.PRICE.LOG",
         cex.lab=0.75, cex.main=0.75, cex.axis=0.75)
    title(main = borough, outer = TRUE, cex.main=1.0, line=-1)
  }
  
  sp_freq(bronxDf, "BRONX")
  sp_freq(brooklynDf, "BROOKLYN")
  sp_freq(manhattanDf, "MANHATTAN")
  sp_freq(queensDf, "QUEENS")
  sp_freq(statenDf, "STATEN ISLAND")
  
  ## Summary
  summary_stats <- function(df, borough) {
    summaryBy(data = df, SALE.PRICE.N + GROSS.SQUARE.FEET.N ~ BUILDING.CLASS.CATEGORY.N,
              FUN = c(length, mean, median),
              fun.names = c("Total no.", "Mean", "Median"),
              var.names = c(borough))
  }
  
  summary_stats(bronxDf, "Bronx")
  summary_stats(brooklynDf, "Brooklyn")
  summary_stats(manhattanDf, "Manhattan")
  summary_stats(queensDf, "Queens")
  summary_stats(statenDf, "Staten Island")

  
### ANALYSIS ACROSS TIME
  # DAY AND MONTH FETCHER FUNCTION
  day_month <- function (df) {
    df$DAY <- format(df$SALE.DATE, "%A")
    df$DAY <- factor(df$DAY, levels = c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"))
    
    df$MONTH <- format(df$SALE.DATE, "%B")
    df$MONTH <- factor(df$MONTH, levels = c("January", "February", "March", "April", "May", "June", "July", 
                                            "August", "September", "October", "November", "December"))
    return(df)
  }
  
  bronxTime <- day_month(bronxDf)
  brooklynTime <- day_month(brooklynDf)
  manhattanTime <- day_month(manhattanDf)
  queensTime <- day_month(queensDf)
  statenTime <- day_month(statenDf)
  
  # Total sale of Building Class in Months
  monthly_sale <- function (class) {
    filter <- bronxTime$SALE.PRICE.LOG[bronxTime$BUILDING.CLASS.CATEGORY.N == class]
    month <- bronxTime$MONTH[bronxTime$BUILDING.CLASS.CATEGORY.N == class]
    borough_1 <- data.frame(BOROUGH = rep("Bronx", length(filter)), SALE.PRICE.LOG = filter, MONTH=month)
    
    filter <- brooklynTime$SALE.PRICE.LOG[brooklynTime$BUILDING.CLASS.CATEGORY.N == class]
    month <- brooklynTime$MONTH[brooklynTime$BUILDING.CLASS.CATEGORY.N == class]
    borough_2 <- data.frame(BOROUGH = rep("Brooklyn", length(filter)), SALE.PRICE.LOG = filter, MONTH=month)
    
    filter <- manhattanTime$SALE.PRICE.LOG[manhattanTime$BUILDING.CLASS.CATEGORY.N == class]
    month <- manhattanTime$MONTH[manhattanTime$BUILDING.CLASS.CATEGORY.N == class]
    borough_3 <- data.frame(BOROUGH = rep("Manhattan", length(filter)), SALE.PRICE.LOG = filter, MONTH=month)
    
    filter <- queensTime$SALE.PRICE.LOG[queensTime$BUILDING.CLASS.CATEGORY.N == class]
    month <- queensTime$MONTH[queensTime$BUILDING.CLASS.CATEGORY.N == class]
    borough_4 <- data.frame(BOROUGH = rep("Queens", length(filter)), SALE.PRICE.LOG = filter, MONTH=month)
    
    filter <- statenTime$SALE.PRICE.LOG[statenTime$BUILDING.CLASS.CATEGORY.N == class]
    month <- statenTime$MONTH[statenTime$BUILDING.CLASS.CATEGORY.N == class]
    borough_5 <- data.frame(BOROUGH = rep("Staten Island", length(filter)), SALE.PRICE.LOG = filter, MONTH=month)
    
    finalDf <- rbind(borough_1, borough_2, borough_3, borough_4, borough_5)
    ggplot(finalDf, aes(x=MONTH, y=SALE.PRICE.LOG, fill=MONTH, colour=MONTH, group=MONTH)) + 
      theme(axis.text.x=element_text(angle = 90, vjust = 0.5)) +
      geom_boxplot() +
      ggtitle(class)
  }
  
  monthly_sale("FAMILY")
  monthly_sale("CONDOS")
  monthly_sale("COOPS")
  monthly_sale("OTHERS")
  
  # Number of sale of Building Class by Month for particular Borough
  building_sale_month <- function (df, class, borough) {
    
    SALE.PRICE.LOG <- df$SALE.PRICE.LOG[df$BUILDING.CLASS.CATEGORY.N == class]
    ggplot(df, aes(x=MONTH, y=SALE.PRICE.LOG, fill=MONTH, colour=MONTH, group=MONTH)) + 
      geom_boxplot() +
      theme(axis.text.x=element_text(angle = 90, vjust = 0.5)) +
      xlab(borough) +
      ggtitle(class)
  }
  
  building_sale_month(bronxTime, "FAMILY", "Bronx")
  building_sale_month(bronxTime, "CONDOS", "Bronx")
  building_sale_month(bronxTime, "COOPS", "Bronx")
  building_sale_month(bronxTime, "OTHERS", "Bronx")
  
  building_sale_month(brooklynTime, "FAMILY", "Brooklyn")
  building_sale_month(brooklynTime, "CONDOS", "Brooklyn")
  building_sale_month(brooklynTime, "COOPS", "Brooklyn")
  building_sale_month(brooklynTime, "OTHERS", "Brooklyn")
  
  building_sale_month(manhattanTime, "FAMILY", "Manhattan")
  building_sale_month(manhattanTime, "CONDOS", "Manhattan")
  building_sale_month(manhattanTime, "COOPS", "Manhattan")
  building_sale_month(manhattanTime, "OTHERS", "Manhattan")
  
  building_sale_month(queensTime, "FAMILY", "Queens")
  building_sale_month(queensTime, "CONDOS", "Queens")
  building_sale_month(queensTime, "COOPS", "Queens")
  building_sale_month(queensTime, "OTHERS", "Queens")

  building_sale_month(statenTime, "FAMILY", "Staten Island")
  building_sale_month(statenTime, "CONDOS", "Staten Island")
  building_sale_month(statenTime, "COOPS", "Staten Island")
  building_sale_month(statenTime, "OTHERS", "Staten Island")
  
  # Sale Price vs Gross Square feet for particular Borough
  gross_sp_time <- function (df, borough) {
    SALE.PRICE.LOG <- df$SALE.PRICE.LOG
    GROSS.SQFT.LOG <- log(df$GROSS.SQUARE.FEET.N)
    MONTH <- df$MONTH
    
    ggplot(df, aes(x=SALE.PRICE.LOG, y=GROSS.SQFT.LOG, fill=MONTH, colour=MONTH, group=MONTH)) +
      geom_point() + 
      ggtitle(borough)
  }
  
  gross_sp_time(bronxTime, "Bronx")
  gross_sp_time(brooklynTime, "Brooklyn")
  gross_sp_time(manhattanTime, "Manhattan")
  gross_sp_time(queensTime, "Queens")
  gross_sp_time(statenTime, "Staten Island")
  
  # Sale Price vs Frequency for particular Borough
  sp_freq_time <- function (df, borough) {
    hist(log(df[(df$MONTH=="January" | df$MONTH=="Fabruary" | df$MONTH=="March"),]$SALE.PRICE.N),
         col="#8daeb4", main="QUATER 1", xlab= "SALE.PRICE.LOG",
         cex.lab=0.75, cex.main=0.75, cex.axis=0.75)
    hist(log(df[(df$MONTH=="April" | df$MONTH=="May" | df$MONTH=="June"),]$SALE.PRICE.N),
         col="#8daeb4", main="QUATER 2", xlab= "SALE.PRICE.LOG",
        cex.lab=0.75, cex.main=0.75, cex.axis=0.75)
    hist(log(df[(df$MONTH=="July" | df$MONTH=="August" | df$MONTH=="September"),]$SALE.PRICE.N),
         col="#8daeb4", main="QUATER 3", xlab= "SALE.PRICE.LOG",
         cex.lab=0.75, cex.main=0.75, cex.axis=0.75)
    hist(log(df[(df$MONTH=="October" | df$MONTH=="November" | df$MONTH=="December"),]$SALE.PRICE.N),
         col="#8daeb4", main="QUATER 4", xlab= "SALE.PRICE.LOG",
         cex.lab=0.75, cex.main=0.75, cex.axis=0.75)
    title(main = borough, outer = TRUE, cex.main=1.0, line=-1)
  }
  
  sp_freq_time(bronxTime, "Bronx")
  sp_freq_time(brooklynTime, "Brooklyn")
  sp_freq_time(manhattanTime, "Manhattan")
  sp_freq_time(queensTime, "Queens")
  sp_freq_time(statenTime, "Staten Island")
  
  
  ## SUMMARY
  #Summary of the sale prices & gross square feet acrross borough and time
  summary_time_stats <- function(df, borough) {
    summaryBy(data = df, SALE.PRICE.N + GROSS.SQUARE.FEET.N ~ MONTH,
              FUN = c(length, mean, median),
              fun.names = c("Total no.", "Mean", "Median"),
              var.names = c(borough))
  }
  
  summary_time_stats(bronxTime, "Bronx")
  summary_time_stats(brooklynTime, "Brooklyn")
  summary_time_stats(manhattanTime, "Manhattan")
  summary_time_stats(queensTime, "Queens")
  summary_time_stats(statenTime, "Staten Island")
  