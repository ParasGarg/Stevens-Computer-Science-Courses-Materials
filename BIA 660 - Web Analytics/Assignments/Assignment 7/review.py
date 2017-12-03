# -*- coding: utf-8 -*-
"""
Created on Tue Nov 14 14:05:37 2017
@author: Paras Garg
"""
#import libraries
from selenium import webdriver
from selenium.webdriver.common.desired_capabilities import DesiredCapabilities
from fake_useragent import UserAgent
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.common.by import By
from selenium.common.exceptions import TimeoutException

#function to login to yelp account
def login(username, userkey):
    #access website login page
    driver.get('https://www.yelp.com/login')

    #wait until login page loads
    try: myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '//*[@id="super-container"]/div[3]/div[1]/div/div/div[5]/div[2]/small/a')))
    except TimeoutException: print ("Loading took too much time to open the user login page!")

    #finding form to login into account
    form = driver.find_element_by_id("ajax-login") #form
    email = form.find_element_by_id("email") #find field to input email id
    email.send_keys(username) #entering email id
    password = form.find_element_by_id("password") #find field to input password
    password.send_keys(userkey) #entering password
    button = driver.find_element_by_xpath('//*[@id="ajax-login"]/button') #find login button
    button.click() #clicks button
    
    #wait until default page loads
    try: myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '/html/body/div[2]/div/div[2]/div[3]')))
    except TimeoutException: print ("Loading took too much time!")
 
    
#function to submit a review and rating for a restuarant
def submitReview(review, rating, restaurantID):
    #access restaurant in yelp website
    url = "https://www.yelp.com/biz/" + restaurantID   
    driver.get(url)
    
    #wait until login page loads
    try: myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '//*[@id="wrap"]/div[2]/div/div[1]/div/div[3]/div[1]/div[2]/div[2]')))
    except TimeoutException: print ("Loading took too much time to open the restuarant profile!")
        
    #find and click on the write review button
    writeReviewBtn = driver.find_element_by_xpath('//*[@id="wrap"]/div[2]/div/div[1]/div/div[3]/div[2]/div/a')
    writeReviewBtn.click()
    
    #finding form fields to post review text field with review
    reviewInp = driver.find_element_by_class_name("review_input__1o94S") #find field to input review
    reviewInp.send_keys(review) #enter review
    ratingInp = driver.find_elements_by_class_name("input__3qblJ") #find field to input rating
    ratingInp[rating-1].click() #click on star for rating
    form = driver.find_element_by_tag_name('form') #post button container
    postBtn = form.find_element_by_tag_name('button') #find button to post a review
    postBtn.click() #click to post a review
    
    #wait until default page loads
    try: myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '/html/body/div[4]/div[2]/div/div[1]')))
    except TimeoutException: print ("Loading took too much time to load logged in user profile!")
    
    
#function to search user and vote its review
def vote(userID):
    ##navigation to own profile overview
    profile = driver.find_elements_by_class_name('user-name') #find own profile link (after the review preview)    
    profileLink = profile[1].find_elements_by_tag_name('a')[0] #find clickable tag inside
    profileLink.click() #click to view profile page
    
    #wait until default page loads
    try: myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '//*[@id="wrap"]/div[2]/div[1]/div/div[2]/div[2]/div[3]/ul/li[3]/a')))
    except TimeoutException: print ("Loading took too much time for find friends link!")
    
    ##navigation to find friend option inside profile
    findFriendsLink = driver.find_element_by_xpath('//*[@id="wrap"]/div[2]/div[1]/div/div[2]/div[2]/div[3]/ul/li[3]/a')
    findFriendsLink.click() #click find friends
    
    #wait until default page loads
    try: myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '//*[@id="super-container"]/div[2]/div/div[1]/div[2]/form/div[1]/input')))
    except TimeoutException: print ("Loading took too much time for find friends searchbar!")
    
    ##search for user searchbar
    searchbar = driver.find_element_by_xpath('//*[@id="super-container"]/div[2]/div/div[1]/div[2]/form/div[1]/input')
    searchbar.send_keys(userID) #enter user email id
    driver.find_element_by_xpath('//*[@id="super-container"]/div[2]/div/div[1]/div[2]/form/div[2]/button/span/span').click() #click search button
    
    #wait until default page loads
    try: myElem = WebDriverWait(driver, 1).until(EC.presence_of_element_located((By.XPATH, '//*[@id="super-container"]/div[2]/div/div[1]/div[2]/form/div[1]/input')))
    except TimeoutException: print ("Loading took too much time to load searched user profile link!")
    
    ##navigation to user profile
    userProfile = driver.find_elements_by_class_name('user-name') #find own profile link (after the review preview)    
    userProfileLink = userProfile[1].find_elements_by_tag_name('a')[0] #find clickable tag inside
    userProfileLink.click() #click to view profile page
    
    #wait until default page loads
    try: myElem = WebDriverWait(driver, 1).until(EC.presence_of_element_located((By.XPATH, '//*[@id="super-container"]/div/div[2]/div/div[2]')))
    except TimeoutException: print ("Loading took too much time to load searched user profile link!")
    
    ##vote on user first review
    reviewsDiv = driver.find_element_by_class_name('user-details-overview_published-reviews') #find div contains all reviews
    reviewsList = reviewsDiv.find_elements_by_tag_name('li') #get all reviews
    usefulBtn = reviewsList[0].find_element_by_xpath('//*[@id="super-container"]/div/div[2]/div/div[1]/div[2]/div/ul/li/div/div[2]/div[2]/div[1]/ul/li[1]/a')
    usefulBtn.click() #click useful button
    
    #wait until default page loads
    try: myElem = WebDriverWait(driver, 1).until(EC.presence_of_element_located((By.XPATH, '//*[@id="yelp_main_body"]/div[8]')))
    except TimeoutException: print ("Loading took too much time to load confirmation popup!")
    
    ##vote confirmation
    popup = driver.find_element_by_xpath('//*[@id="yelp_main_body"]/div[8]')
    popup.find_element_by_tag_name('button').click() #click useful button

    
#function to login into yelp account, post review and rating for a restaurant and vode on any user's first review
def test(username, userkey, review, rating, restaurantID, userID):
    global driver

    #make fake browser
    ua = UserAgent()
    dcap = dict(DesiredCapabilities.PHANTOMJS)
    dcap["phantomjs.page.settings.userAgent"] = (ua.random)
    service_args = ['--ssl-protocol=any','--ignore-ssl-errors=true']
    driver = webdriver.Chrome('chromedriver.exe', desired_capabilities = dcap, service_args = service_args) #driver is a fake browser
    
    login(username, userkey) #login to a yelp account
    submitReview(review, rating, restaurantID) #submit a review and rating for a restaurant
    vote(userID) #add vote to user review
    

## main function
if __name__ == '__main__':
    username = "paul.wit@gmx.com"
    password = "Asd1!234"
    review = "Only good for Biryani... Other things are just average and below average... Just go there for biryani that's it, i won't recommend  Chef of India for any thing else"
    rating = 2
    restaurantID = "chef-of-india-jersey-city"
    userID = "worldwar2@post.com"

    test(username, password, review, rating, restaurantID, userID)