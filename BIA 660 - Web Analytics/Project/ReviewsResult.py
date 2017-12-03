import re

#function to sort dictionary based on the size of the word
def sortDictionary(dictionary):
    dictionary.sort(key = len, reverse = True)
    return dictionary
    

#function to get dictionary of any context
def getDictionary(context):
    path = "F:\\Projects\\BIA Scrapper\\Dictionary\\Dictionary - " + context + ".txt" #dictionary path
    dictionary = [] #list to store words

    file = open(path, 'r') #open the dictionary file
    for line in file: dictionary.append(line.strip()) #add word to the dictionary
    file.close() #close the dictionary file

    return sortDictionary(dictionary) #returns sorted dictionary


#function to get indexes of all similar or matched words
def getSimilarWordIndex(review, contextWord):
    return [m.start() for m in re.finditer(contextWord, review)] #find all index for matching word


#function to parse the matched or similar word from string
def parseSimilarWord(review, frontIndex, contextWord):
    word = "" #
    front = frontIndex #front index of the word
    last = frontIndex + len(contextWord) #last index of the word

    while(front < last): #loop until front and last index matched
        word += review[front]
        front += 1
    while(review[front] != " "): #loop if word in not completely added
        word += review[front]
        front += 1
        
    return word #returns full word


#function to replace all matched or similar word in the review with empty character
def replaceSimilarWord(review, contextWord):
    return review.replace(contextWord, '') #return the replaced word review
    

#function to find a similar word and replace it
def findAndReplace(review, contextWord, similarWordsIndexes):
    words = set() #set of all similar or matched words
    
    #find and store all the similar or matched words in a set
    for i in range(0, len(similarWordsIndexes)): #foreach index
        index = similarWordsIndexes[i] #front index of each match
        words.add(parseMatchedWord(review, index, contextWord)) #add similar or matched word to the set
        
    review = replaceSimilarWord(review, contextWord) #remove context words from the review
        
    return review, words

# read review
def findContext(review, context):
    dictionary = contextDictionary[context] #dictipnary of context
    observation = set() #observed result
    
    for contextWord in dictionary: 
        similarWords = set() #store all possible similar words
        
        if contextWord in review:
            contextWordCount = review.count(contextWord)
            for count in range(0, contextWordCount): #loop for each occurance of context word in review   
                similarWordsIndexes = getSimilarWordIndex(review, contextWord) #get all indexes of similar words
                review, similarWords = findAndReplace(review, contextWord, similarWordsIndexes) #update review and similar words set
            
                for word in similarWords: #foreach similar words
                    if contextWord == word: #if similar word matched with context word
                        observation.add(word)
         
    #print result
    print("\n" + context, end = ': ')
    for word in observation:
        print(word, end = ', ')


## main function
if __name__ == '__main__':
    global dataPath #directory path of saved scrapped data
    global contextDictionary #dictionry to hold contexts dictionary
    
    dataPath = "F:\\Github\\Context-Extraction\\Data\\" 
    contextDictionary= {
        "Occasion": getDictionary("Occasion"), #get dictionary for "occasion" context
        "Where": getDictionary("Where"), #get dictionary for "where" context
        "When": getDictionary("When"), #get dictionary for "when" context
        "Whom": getDictionary("Whom") #get dictionary for "whom" context
    }

    review = "Come here while you can, brunch's lunch before. The food is brunch lunchl on engagement friend out-of-town, the scallops. And the pappardelle with veal to share. Then the crispy duck and the braised pork. H.O.L.Y.S.M.O.K.E.S. I can't wait to come back here for dinner again.The dessert- we had something with sesame merengue and something with caramel cookie base with ice cream. I wanted to order a 2nd round of desserts- that's how good they were!The bar looks great and the cocktails are solid as well!"

    findContext(review, "Whom")
    findContext(review, "When")
    findContext(review, "Where")
    findContext(review, "Occasion")