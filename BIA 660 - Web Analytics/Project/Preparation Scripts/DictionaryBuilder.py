# -*- coding: utf-8 -*-
import re
import nltk
from nltk.corpus import wordnet

#function to save the dictionary in a file
def saveDictionaryInFile(dictionary, filename):
    filename = "Dictionary - " + filename + ".txt" #file name
    path = dictionaryPath + filename #file path
    saveData = open(path, 'w') #create a file
    for word in dictionary:
        saveData.write(word + "\n") #write data to the file
    saveData.close() #close the file

#function to read and save unique words in the file
def uniqueWords(files):
    for file in files:
        filename = "Sample Dictionary - " + file + ".txt" #file name
        path = dictionaryPath + filename #file path
        infile = open(path, 'r') #open and read a file
        
        dictionary = set() #dictionary for each file
        for line in infile: dictionary.add(line.lower().strip()) #read and add unique word 
        
        infile.close() #close a file
        saveDictionaryInFile(dictionary, file) #save dictionry to a file
        
#functions to add synonyms to the dictionary
def addSynonyms(files):
    for file in files:
        filename = "Dictionary - " + file + ".txt" #file name
        path = dictionaryPath + filename #file path
        infile = open(path, 'r') #open and read a file
        
        synonyms = set() #set to add unique synonyms
        for line in infile: #adding synonyms
            word = line.lower().strip()
            for syn in wordnet.synsets(word):
                for l in syn.lemmas():
                    synonyms.add(re.sub("[^a-zA-Z//-]+", ' ', l.name().lower().strip())) #add synonyms
                    synonyms.add(word) #add actual word
                        
        infile.close() #close a file
        saveDictionaryInFile(synonyms, file) #save dictionry to a file
            
# main function
if __name__ == '__main__':
    global dictionaryPath
        
    dictionaryPath = "F:\\Github\\Context-Extraction\\Data\\Dictionary\\" #directory path of saved scrapped data
    files = ["When", "Where", "Whom", "Occasion"] #list of events
    
    uniqueWords(files)
    addSynonyms(files)