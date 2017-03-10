###### Knowledge Discovery and Data Mining (CS 513) ######
#         (Assignment 2 - Intro to R)

# Course      : CS 513 - A
# First Name  : PARAS 
# Last Name   : GARG
# Id          : 10414982
# Purpose     : Assignment 2 - Intro to R

###### ******************************************** ######

# 2.1. Create the following x and y vectors: x= 1,2,3 and y= 11,12,13,14,15,16.
x <- c(1,2,3);
y <- 11:16;

# 2.2. Calculate and display z=x+y.
z <- x + y;
z;

# 2.3. Explain the results.
# Ans. Length of "x" is 3 and length of "y" is 6. 
#      Each element of x is added to its corresponding y element, 
#      but the length of x is lesser than the length of y so as elements  of x ends, 
#      it starts picking x elements from the beginning.

# 2.4. Create a vector of your last name.
lastname <- "Garg";

# 2.5. Create a vector of your first name.
firstname <- "Paras";

# 2.6. Create a vector of your student ID.
studentID <- 10414982;

# 2.7. What are the length and data type of the "last name" vector? Why?
# Ans. The length of "last name" vector is  1 because only one element is present in the vector,
#      and data type of "last name" vector is "character" because character string is assigned to the vector.
length(lastname);
mode(lastname);

# 2.8. Combine your first name, last name and student id into a single vector ("myinfo").
myinfo <- c(firstname, lastname, studentID);

# 2.9. Display "myinfo" in the Console.
myinfo;

# 2.10. What are the length and data type of "myinfo"?
# Ans. The length of "myinfo" vector is 3 because three elements are present in the vector,
#      and data type of "myinfo" vector is "character" because in R, vector could be of only 
#      one data type. In this vector character string is assigned so the whole list became of 
#      similar data type ie of character.
length(myinfo);
mode(myinfo);

# 2.11. Remove the "first_name" object.
rm(firstname);

# 2.12. Display "myinfo" in the Console again.
# Ans. "myinfo" remains same because the "firstname" object is removed after assigning myinfo vector.
myinfo;

# 2.13. Create a dataframe "roster" using the following table:
#                      First     Last    ID
#                      fname1   lname1  1111
#                      fname2   lname2  2222
roster = data.frame(First = c("fname1", "fname2"), Last = c("lname1", "lname2"), ID = c(1111, 2222));

# 2.14. View the "roster".
View(roster);

# 2.15. Export the data frame "roster" to a csv file.
# Ans. setwd("~/R");        // setting work directory
write.csv(roster, file = "rosterData.csv", row.names=FALSE);

# 2.16. Import and view the following csv file: http://www.math.smith.edu/sasr/datasets/help.csv
readFile <- read.csv("http://www.math.smith.edu/sasr/datasets/help.csv");   # reading file 
View(readFile);                                                             # viewing file

# 2.17. Remove all the objects in your session.
rm(list=ls())