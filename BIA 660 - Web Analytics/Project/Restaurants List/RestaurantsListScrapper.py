#import libraries
from bs4 import BeautifulSoup
import math
import re
import time
import requests 

#function to check whether the restaurant is Ad or not
def isAd(restaurantBlock):
    ad = True
    adChunk = restaurantBlock.find('span', {'class': 'yloca-tip'})
    if adChunk == None: ad = False
    return ad

#function to parse the restaurant name 
def getRestaurantName(restaurantBlock):
    name = 'NA' #initializing name
    nameChunk = restaurantBlock.find('a', {'class': 'biz-name js-analytics-click'})
    if nameChunk: name = nameChunk.text
    return name

# function to parse the restaurant href
def getRestaurantHref(restaurantBlock):
    href = 'NA' #initializing href
    hrefChunk = restaurantBlock.find('a', {'class': 'biz-name js-analytics-click'})
    if hrefChunk: href = hrefChunk['href'].split("?")[0] #remove unnecessary text
    return href

#function to fetch the restaurant username
def getRestaurantUsername(restaurantUrl):
    username = 'NA'
    if restaurantUrl: username = restaurantUrl.split("/")[4] #get last element of the split list
    return username
    
# function to parse the restaurant reviews count
# function to parse the restaurant cuisine     

#function to scrap restatuarant names and url from yelp
def restaurantsListScrapper(restaurantCount, domain, cuisine, location):
    restaurantsList = open('restaurantsList.txt', 'w') #output file
    for page in range(0, restaurantCount):
        if (page % 10 == 0):
            srcUrl = domain + "/search?find_desc=" + cuisine + "&find_loc=" + location + "&start=" + str(page);
            html = None
            
            for i in range(5):
                try: #use the browser to access the url
                    response = requests.get(srcUrl,headers = { 'User-Agent': 'Mozilla/5.0 (Windows NT 6.1) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/41.0.2228.0 Safari/537.36', })
                    html = response.content #get the html
                    break #we got the file, break the loop
                except Exception as e: #browser.open() threw an exception, the attempt to get the response failed
                    print ('failed attempt', i)
                    time.sleep(1) #wait 1 secs
            
            if not html: continue #couldn't get the page, ignore
            
            htmlParser = BeautifulSoup(html.decode('ascii', 'ignore'), 'lxml') # parse the html
            restaurantBlocks = htmlParser.findAll('div', {'class':re.compile('main-attributes')}) # get all the review divs
            
            for restaurantBlock in restaurantBlocks:
                if(isAd(restaurantBlock) == False):
                    name = getRestaurantName(restaurantBlock)
                    href = domain + getRestaurantHref(restaurantBlock)
                    username = getRestaurantUsername(href)
 
                    restaurantsList.write(name + '\t' + username + '\t' + href + '\n') # write to file
                    
    restaurantsList.close() #close file             
    
# main function
if __name__ == '__main__':
    restaurantCount = 150 #number of restuarants to scrap
    domain = "https://www.yelp.com" #website domain name
    cuisine = "Restaurants+-+American" #type of cuisine restaurant offers
    location = "New+York%2C+NY" #location of the restaurant
    
    restaurantsListScrapper(restaurantCount, domain, cuisine, location)