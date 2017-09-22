# -*- coding: utf-8 -*-
"""
Created on Tue Sep 12 13:38:06 2017
@author: Paras Garg
"""

#function that loads a lexicon of positive words to a set and returns the set
def loadLexicon(fname):
    newLexList = set()
    lexConn = open(fname)
    #add every word in the file to the set
    for line in lexConn:
        newLexList.add(line.strip()) #remember to strip to remove the lin-change character
    lexConn.close() #closing file connection
    return newLexList #return new lexicon list


#function that reads in a file
#the function will return a dictionary that contains frequency of positive words
def run(path):
    posFreq = {} #dictionary to score positive words frequency
    posLex = loadLexicon('positive-words.txt') #load the positive lexicons
    fin = open(path) #load the reviews file
    
    for line in fin:
        posWords = set() #set to contain all unique positive words in a line

        line = line.lower().strip() #converting line to lower case and removing extra spaces
        words = line.split(' ') #slit on the space to get list of words
        
        for word in words: #for every word in the review file
            if word in posLex: #if the word is in the positive lexicon
                posWords.add(word) #adding unique word in the positive words set
                
        for word in posWords: #for every word in the positive words set
            if word in posFreq: #if the word already exists as a key is in the dictionary
                posFreq[word] = posFreq[word] + 1 #incrementing value by 1
            else: #if the word does not exists as a key in the disctionary
                posFreq[word] = 1 #initializing new key with value 1
    
    fin.close() #closing connection with file
    return posFreq

# main function
if __name__ == "__main__": 
    dictionary = run('textfile') #get dictionary as return value
    print(dictionary) #printing dictionary