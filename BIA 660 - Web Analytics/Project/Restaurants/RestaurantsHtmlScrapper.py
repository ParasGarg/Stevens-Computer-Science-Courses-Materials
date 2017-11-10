#import libraries
from bs4 import BeautifulSoup
import math
import re
import time
import requests 

#function to add every url in the file to a set
def getRestaurantsUrl(filename):
    file = open(filename) #read data from file 
    urlList = [] #url list
    for line in file: #foreach line in the file
        urlList.append(line.split('\t')[2].strip())    
    file.close()
    return urlList

#function to add every username in the file to a set
def getRestaurantUsername(filename):
    file = open(filename) #read data from file 
    usernameList = [] #username list
    for line in file: #foreach line in the file
        usernameList.append(line.split('\t')[1].strip())
    file.close()
    return usernameList

#function to fetch the number of review pages
def getReviewPageCount(url):
    response=requests.get(url, headers = { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', })
    html = response.content #get the html              
    
    soup = BeautifulSoup(html.decode('ascii', 'ignore'),'lxml') #parse the html 
    page = soup.find('div', {'class':re.compile('page-of-pages arrange_unit arrange_unit--fill')}) #get maximum pages
    
    page = str(page.text)
    page = page.strip().split()
    page = int(page[-1])
        
    return page

#function to scrap restatuarant names and url from yelp
def restaurantsHtmlScrapper(restaurantsListFile):
    urlList = getRestaurantsUrl(restaurantsListFile) #get list of restaurants urls
    usernameList = getRestaurantUsername(restaurantsListFile) #get list of restaurants usernames
    restaurantsCount = len(usernameList)
    
    path = "F:\\Github\\Context-Extraction\\Restaurants\\Scrapped Data\\NYC\\American\\"  
    index = 0
    while index < restaurantsCount: #foreach restaurant
        html = None
        url = urlList[index] #url of a restaurant
        username = usernameList[index] #username of a restaurant
        reviewPageCount = getReviewPageCount(url) #number of review pages
        
        if not os.path.exists(path + username): #create a directory for the restaurant
            os.mkdir(path + username)
        
        for page in range(0, reviewPageCount): #foreach review page
            reviewUrl = url + "?start=" + str(page * 20)
            filename = path + username + "\\" + username + "-page-" + str(page) + ".html"
            
            restaurantsHtml = open(filename, 'w')
            for i in range(5):
                try: #use the browser to access the url
                    response = requests.get(reviewUrl, headers = { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', })
                    html = response.content #get the html
                    break #we got the file, break the loop
                except Exception as e: #browser.open() threw an exception, the attempt to get the response failed
                    print ('failed attempt', i)
                    time.sleep(2) #wait 2 secs
    
            if not html: continue #couldn't get the page, ignore
            
            htmlParser = BeautifulSoup(html.decode('ascii', 'ignore'), 'lxml') # parse the html
            restaurantsHtml.write(str(htmlParser)) #htmlParser.prettify() for prettiness
            restaurantsHtml.close() #close the file
        
        index += 1

# main function
if __name__ == '__main__':
    restaurantsListFile = "restaurantsList.txt"
    restaurantsHtmlScrapper(restaurantsListFile)