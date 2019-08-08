from django.test import LiveServerTestCase
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
import time

def test1():
#  >>>>   Test goHome without signin  -> pass

    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:8080/loginRegister/loginLogout.jsp')

    time.sleep(1)

    elem = browser.find_element_by_id('goHome')
    elem.click()


def test2():

#  >>>>   Test goHome without signout  -> pass

    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:8080/loginRegister/loginLogout.jsp')

    time.sleep(1)

    elem = browser.find_element_by_id('signOut')
    elem.click()

    time.sleep(1)
    link = browser.find_element_by_xpath("/html/body/div[2]/a[1]")
    link.click()





# >>>>  Test  chatApp
def test3():

    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')

    browser2 = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
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

    time.sleep(3)

#    test dictionary
def test4():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')

    temp = browser.find_element_by_id('dictID')
    temp.click()

    message1 = browser.find_element_by_id('id_word')
    message1.send_keys('blind')

    submit = browser.find_element_by_id('searchLabel')
    submit.click()
    time.sleep(4)

    message1 = browser.find_element_by_id('id_word')
    message1.send_keys('asdsfa')
    submit = browser.find_element_by_id('searchLabel')
    submit.click()
    time.sleep(2)


#test news app
def test5():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')

    temp = browser.find_element_by_id('newsID')
    temp.click()
    
#    the scroll down is not written by me
    last_height = browser.execute_script("return document.body.scrollHeight")

    for i in range(12):
        browser.execute_script("window.scrollTo(0, document.body.scrollHeight);")
        time.sleep(2)
        new_height = browser.execute_script("return document.body.scrollHeight")


def test6():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')
    
    temp = browser.find_element_by_id('weatherID')
    temp.click()

    message1 = browser.find_element_by_name('changeLocation')
    message1.send_keys('paris')

    submit = browser.find_element_by_class_name('submit')
    submit.click()
