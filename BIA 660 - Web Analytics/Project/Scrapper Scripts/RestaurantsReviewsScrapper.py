#import libraries
import fnmatch
import os
import re
from bs4 import BeautifulSoup

#function to get the name of the directory from the path
def getDirectoryName(path):
    directoryList = path.split("\\")
    return directoryList[len(directoryList) - 1]

#function to check whether the value container is empty
def isEmpty(value):
    if len(value) == 0: return True
    return False
    
#function to get list of scrapped files
def getFilesList(basePath):
    pathDictionary = {} #dictionary contains the restaurant username as key and list of page path as a value
    
    for root, directories, files in os.walk(basePath):
        directory = getDirectoryName(root) #fetching name of the current directory
        pathDictionary[directory] = [] #defining empty list to every key
        
        for filename in fnmatch.filter(files, '*.html'): #foreach file in the directory
            pathDictionary[directory].append(os.path.join(root, filename)) #adding matched file path in the dictionary
        
    return pathDictionary #returning directory
            
#function to scrap reviews from each file for each restaurant directory
def reviewScrapper(restaurantDictionary, basePath):
    path = basePath + "NYC\\" + "American\\" #path of expected output 

    globalFile = open(path + "reviews.txt", 'w') #create a main review file: contains reviews of every restaurant    

    for key,value in restaurantDictionary.items(): #foreach each key in the restaurant dictionary
        if not isEmpty(value):
            outFile = open(path + key + "\\" + key + "-reviews.txt", 'w') #create restaurant specific review file
            
            for index in range (0, len(value)): #foreach value/path in the value list
                inFile = open(value[index], 'r').read() #read all data from file
                
                htmlParser = BeautifulSoup(inFile.encode('ascii', 'ignore'), 'lxml') #parse string into beautiful soup
                reviews = htmlParser.findAll('div', {'class': re.compile('review-content')}) #extract reviews containers               
                
                for reviewText in reviews:
                    reviewText = reviewText.find('p', {'lang': 'en'}).text #fetch review text from every container 
                    outFile.write(reviewText + "\n") #write restaurant specific review in file
                    globalFile.write(reviewText + "\n") #write reviews for every restaurant 
                    
            outFile.close() #close restaurant specific review file
    globalFile.close() #close main review file

# main function
if __name__ == '__main__':
    basePath = "F:\\Github\\Context-Extraction\\Data\\" #directory path of saved scrapped data
    restaurantDictionary = getFilesList(basePath)
    reviewScrapper(restaurantDictionary, basePath)