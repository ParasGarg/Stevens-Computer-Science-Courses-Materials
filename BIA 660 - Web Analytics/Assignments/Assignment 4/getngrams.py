# -*- coding: utf-8 -*-
"""
Created on Tue Oct  3 13:40:39 2017
@author: Paras Garg
"""

import nltk
from nltk.util import ngrams
from nltk.tokenize import sent_tokenize
from nltk import load
from collections import Counter


#function that loads a lexicon of words to a set and returns the set
def loadLexicon(fname):
    newLex = set()
    lexConn = open(fname)
    #add every word in the file to the set
    for line in lexConn:
        newLex.add(line.strip())# remember to strip to remove the lin-change character
    lexConn.close()
    # return new lexicon list
    return newLex


# return all the terms that belong to a specific POS type
def getPOSterms(terms, POStags, tagger):
    tagged_terms = tagger.tag(terms) #do POS tagging on the tokenized sentence

    POSterms = {}
    for tag in POStags: POSterms[tag] = set()

    #for each tagged term
    for pair in tagged_terms:
        for tag in POStags: # for each POS tag 
            if pair[1].startswith(tag): POSterms[tag].add(pair[0])

    return POSterms

# return all combinations of given sentence structure
def processSentence(sentence, posLex, negLex, tagger):
    #tokenize the sentence
    terms = nltk.word_tokenize(sentence.lower())
     
    POStags = ['NN'] #POS tags of interest ie noun
    POSterms = getPOSterms(terms, POStags, tagger)
    nouns = POSterms['NN']
     
    result = []
    fourGrams = ngrams(terms, 4) #compute 4-grams
    for tag in fourGrams: #for each 4gram
        if tag[0] == 'not' and (tag[2] in posLex or tag[2] in negLex) and tag[3] in nouns:
            result.append(tag)
    
    return result

# return a keys list having 3 largest values in dictionary
def getTop3(D):
    topKeys = []
    
    dCounter = Counter(D)
    dCounter.most_common()
    for key, value in dCounter.most_common(3):
        topKeys.append(key)
    
    return topKeys


def run(fpath):
    
    #load the positive and negative lexicons
    posLex = loadLexicon('positive-words.txt')
    negLex = loadLexicon('negative-words.txt')
    
    #make a new tagger
    _POS_TAGGER = 'taggers/maxent_treebank_pos_tagger/english.pickle'
    tagger = load(_POS_TAGGER)

    #read the input
    f = open(fpath)
    text = f.read().strip()
    f.close()

    #split sentences
    sentences = sent_tokenize(text)

    structList = [] 
    for sentence in sentences: #for each sentence
        
        #get the results for this sentence 
        structList += processSentence(sentence, posLex, negLex, tagger) 
 		
    return structList

if __name__=='__main__':
    print (run('input.txt'))
    D = {'paras': 1, 'boy': 5, 'girl':8, 'daaku':10, 'pop':3, 'cgk':100 }
    print (getTop3(D))