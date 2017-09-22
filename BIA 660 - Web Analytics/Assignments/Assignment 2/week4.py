"""
A scrip that reads a file from the web and returns the three most frequent words in the file
"""

import re
from nltk.corpus import stopwords
import requests
from operator import itemgetter



def run(url): 

    freq={} # keep the freq of each word in the file 

    stopLex=set(stopwords.words('english')) # build a set of english stopwrods 

    success=False# become True when we get the file

    for i in range(5): # try 5 times
        try:
            #use the browser to access the url 
            response=requests.get(url,headers = { 'User-Agent':'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', })    
            success=True # success
            break # we got the file, break the loop
        except:# browser.open() threw an exception, the attempt to get the response failed
            print ('failed attempt',i)
     
    # all five attempts failed, return  None
    if not success: return None
    
    text=response.text# read in the text from the file
 
    sentences=text.split('.') # split the text into sentences 
	
    for sentence in sentences: # for each sentence 

        sentence=sentence.lower().strip() # loewr case and strip	
        sentence=re.sub('[^a-z]',' ',sentence) # replace all non-letter characters  with a space
		
        words=sentence.split(' ') # split to get the words in the sentence 

        for word in words: # for each word in the sentence 
            if word=='' or word in stopLex:continue # ignore empty words and stopwords 
            else: freq[word]=freq.get(word,0)+1 # update the frequency of the word 
            
    # sort the dictionary by value, in descending order 
    sortedByValue=sorted(freq.items(),key=itemgetter(1),reverse=True)
    
    return sortedByValue[0:3] # return the top 3 terms and their frequencies 


if __name__=='__main__':
    print(run('http://tedlappas.com/wp-content/uploads/2016/09/textfile.txt'))
	

	
