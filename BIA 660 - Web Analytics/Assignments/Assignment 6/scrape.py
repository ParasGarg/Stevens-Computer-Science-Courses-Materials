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

#make fake browser
ua = UserAgent()
dcap = dict(DesiredCapabilities.PHANTOMJS)
dcap["phantomjs.page.settings.userAgent"] = (ua.random)
service_args = ['--ssl-protocol=any','--ignore-ssl-errors=true']
driver = webdriver.Chrome('chromedriver.exe',desired_capabilities=dcap,service_args=service_args) #driver is a fake browser

#access website
driver.get('https://www.yelp.com/login')


'''

#find and click login icon
loginIcon = driver.find_element_by_xpath('//*[@id="header-log-in"]//a')
loginIcon.click()
'''

#wait until login page loads
try:
    myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '//*[@id="super-container"]/div[3]/div[1]/div/div/div[5]/div[2]/small/a')))
except TimeoutException:
    print ("Loading took too much time!")

#finding the login form
form = driver.find_element_by_id("ajax-login")
#find and fill the email field
email = form.find_element_by_id("email")
email.send_keys('worldwar2@post.com')
#find and fill the password field
password = form.find_element_by_id("password")
password.send_keys("LetsFight@1939")
#find and click the search button
loginBtn = driver.find_element_by_xpath('//*[@id="ajax-login"]/button')
loginBtn.click()

#wait until search page loads
try:
    myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.XPATH, '//*[@id="header-search-submit"]')))
except TimeoutException:
    print ("Loading took too much time!")
#find and fill the seach and city field
search = driver.find_element_by_id("find_desc")
search.send_keys('Restaurants')

city = driver.find_element_by_id("dropperText_Mast")
city.send_keys("Hoboken, NJ")
#find and click the search button
searchBtn = driver.find_element_by_id("header-search-submit")
searchBtn.click()

#wait until the search page loads
try:
    myElem = WebDriverWait(driver, 3).until(EC.presence_of_element_located((By.CLASS_NAME,'search-pagination')))
except TimeoutException:
    print ("Loading took too much time!")

#find all the restaurants in the first page and print their names
restaurantsList = driver.find_elements_by_class_name('indexed-biz-name')
for restaurant in restaurantsList:
    print (restaurant.text)


