from django.test import LiveServerTestCase
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time




#  >>>>   Test goHome without signin  -> pass

#browser = webdriver.Chrome()
browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
browser.get('http://localhost:8080/loginRegister/loginLogoutjsp.jsp')

time.sleep(1)

elem = browser.find_element_by_id('goHome')
elem.click()




#  >>>>   Test goHome without signout  -> pass

browser = webdriver.Chrome()
browser.get('http://localhost:8080/loginRegister/loginLogoutjsp.jsp')

time.sleep(1)

elem = browser.find_element_by_id('signOut')
elem.click()

link = browser.find_element_by_xpath("/html/body/div[2]/a[1]")
link.click()





# >>>>  Test  chatApp


browser = webdriver.Chrome()
browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')

browser2 = webdriver.Chrome()
browser2.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')


temp = browser.find_element_by_id('chatID')
temp.click()

temp = browser2.find_element_by_id('chatID')
temp.click()


time.sleep(1)
username1 = browser.find_element_by_id('username')
username1.send_keys('Bob')

changeName1 =  browser.find_element_by_id('newUsername')
changeName1.click()

message1 = browser.find_element_by_id('message')
message1.send_keys('fuck you')

send1 = browser.find_element_by_id('sendMessage')
send1.click()

time.sleep(3)


message2 = browser2.find_element_by_id('message')
message2.send_keys('thank you')

send2 = browser2.find_element_by_id('sendMessage')
send2.click()



