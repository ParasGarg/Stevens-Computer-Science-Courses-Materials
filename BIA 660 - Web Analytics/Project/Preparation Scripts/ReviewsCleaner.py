#import libraries
import fnmatch
import os
import re
from nltk.corpus import stopwords

#function to save the data in a file
def saveDataInFile(data, filename, restaurant, path):
    file = path + restaurant + "\\" + restaurant + "-" + filename #file absolute path
    saveData = open(file, 'w') #create a file
    saveData.write(data) #write data to the file
    saveData.close() #close the file
    
#function to check whether the value container is empty
def isEmpty(value):
    if len(value) == 0: return True
    return False

#function to get the name of the directory from the path
def getDirectoryName(path):
    directoryList = path.split("\\")
    return directoryList[len(directoryList) - 1]

#fucntion to get list of reviews files for every restaurant
def getReviewsFiles(filePath):
    reviewDictionary = {} #dictionary contains list of restaurant isername as key and review path as value   
    for root, directories, files in os.walk(filePath):
        directory = getDirectoryName(root) #fetching name of the current directory  
        filename = fnmatch.filter(files, '*reviews.txt')[0] #get filename of the reviews file
        reviewDictionary[directory] = os.path.join(root, filename) #adding file path in the dictionary      
    return reviewDictionary #returning directory

#function to get special characters and numbers free reviews
def getSymbolFreeReviews(reviews, restaurant, path):
    reviews = re.sub("[^a-zA-Z\s'\\-]+", ' ', reviews) #remove anything that isn't a letter, space, or number
    reviews = re.sub(' +', ' ', reviews) #remove extra spaces
    saveDataInFile(reviews, "reviews-symbol-free.txt", restaurant, path) #save the data to a file    
    return reviews #returns symbol free reviews

#function to get stopwords free reviews
def getStopwordsFreeReviews(reviews, restaurant, path):
    reviewsList = reviews.split("\n") #get list of reviews
    reviews = "" #reinitailizing reviews variable
    
    for review in reviewsList: #foreach review in the reviews list
        wordsList = review.split(" ") #separating every word in the review
        filteredReview = "" #variable to store filtered review
        for word in wordsList: #foreach word in the words list
            if word == '' or word in stopLex: #ignore empty words and stopwords
                continue
            else: #add useful word
                filteredReview += word + " "
        reviews += filteredReview + '\n' #adding filtered review into main reviews
    
    saveDataInFile(reviews, "reviews-stopwords-free.txt", restaurant, path) #save the data to a file    
    return reviews #returns stopwords free reviews
        
# function to clean the review 
def reviewsClearner():
    path = dataPath + "NYC\\" + "American\\" #path of expected files
    reviewsDictionary = getReviewsFiles(path)
    
    for restaurant,restaurantReviewFile in reviewsDictionary.items(): #foreach each key in the reviews dictionary
        if not isEmpty(restaurantReviewFile):
            reviews = open(restaurantReviewFile, 'r').read() #read the data from review file            
            reviews = getSymbolFreeReviews(reviews, restaurant, path) #removing symbols from reviews
            #reviews = getStopwordsFreeReviews(reviews, restaurant, path) #removing stopwords from reviews

# main function
if __name__ == '__main__':
    global stopLex
    global dataPath
    
    stopLex = set(stopwords.words('english')) # build a set of english stopwrods
    dataPath = "F:\\Github\\Context-Extraction\\\Data\\" #directory path of saved scrapped data
        
    reviewsClearner() #clean and saves the different versions to files