# -*- coding: utf-8 -*-
"""
Created on Tue Sep 26 14:12:10 2017
@author: Paras Garg
"""

from bs4 import BeautifulSoup
import re
import time
import requests

# function to find and get the name of the critic
def getCritic(review):
    critic = 'NA' # initialize critic 
    criticChunk = review.find('a', {'href': re.compile('/critic/')})
    if criticChunk: critic = criticChunk.text #.encode('ascii','ignore')
    return critic

# function to find and get the rating
def getRating(review):
    rating = 'NA' # initialize rating
    if review.find('div', {'class': 'review_icon icon small rotten'}): rating = "rotten"
    elif review.find('div', {'class': 'review_icon icon small fresh'}): rating = "fresh"
    return rating

# function to find and get the source
def getSource(review):
    source = 'NA' # initializing source
    sourceChunk = review.find('em', {'class': 'subtle'})
    if sourceChunk: source = sourceChunk.text # fetching actual text inside html tag
    return source

# function to find and get the date of review
def getDate(review):
    date = 'NA' # initializing date
    dateChunk = review.find('div', {'class': re.compile('review_date')})
    if dateChunk: date = dateChunk.text # fetching actual text inside html tag
    return date

# function to find the length of the review text
def getTextLen(review):
    length = 0 # initializing length
    text = 'NA' # initializing text
    textChunk = review.find('div',{'class':'the_review'})
    if textChunk: text = textChunk.text#.encode('ascii','ignore')
    if not text == 'NA': length = len(text)
    return length

# function to execute the program
def run(url):
    pageNum = 1 # number of pages to collect

    fw=open('reviews.txt', 'w') # output file
    for p in range(1, pageNum+1): # for each page 
        print ('page', 2)
        html = None

        if p == 1: pageLink = url # url for page 1
        else: pageLink = url+'?page='+str(p)+'&sort=' # make the page url
		
        for i in range(5): # try 5 times
            try:
                #use the browser to access the url
                response = requests.get(pageLink,headers = { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', })
                html = response.content # get the html
                break # we got the file, break the loop
            except Exception as e:# browser.open() threw an exception, the attempt to get the response failed
                print ('failed attempt', i)
                time.sleep(2) # wait 2 secs
				
		
        if not html: continue # couldnt get the page, ignore

        soup = BeautifulSoup(html.decode('ascii', 'ignore'), 'lxml') # parse the html 
        reviews = soup.findAll('div', {'class':re.compile('review_table_row')}) # get all the review divs

        for review in reviews:
            critic = getCritic(review)
            rating = getRating(review)
            source = getSource(review)
            date = getDate(review)
            length = str(getTextLen(review))          
            
            fw.write(critic + '\t' + rating + '\t' + source + '\t' + date + '\t' + length + '\n') # write to file 
            time.sleep(2)	# wait 2 secs 

    fw.close()

# main function
if __name__=='__main__':
    url='https://www.rottentomatoes.com/m/space_jam/reviews/'
    run(url)


