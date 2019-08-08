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


#test weather app
def test6():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')
    
    temp = browser.find_element_by_id('weatherID')
    temp.click()

    message1 = browser.find_element_by_name('changeLocation')
    message1.send_keys('paris')

    submit = browser.find_element_by_class_name('submit')
    submit.click()


#test movie recommendation content-based
def test7():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')
    time.sleep(1)
    
    temp = browser.find_element_by_id('movieID')
    temp.click()
    time.sleep(1)
    
    temp = browser.find_element_by_id('2')
    temp.click()
    time.sleep(1)
    
    message1 = browser.find_element_by_name('movieName')
    message1.send_keys('Skyfall')
    
    temp = browser.find_element_by_tag_name('button')
    temp.click()
    time.sleep(2)
    
    
    message1 = browser.find_element_by_name('movieName')
    message1.send_keys('Interstellar')
    
    temp = browser.find_element_by_tag_name('button')
    temp.click()
    time.sleep(2)


    message1 = browser.find_element_by_name('movieName')
    message1.send_keys('sleepfood')
    
    temp = browser.find_element_by_tag_name('button')
    temp.click()
    time.sleep(3)

#test movie recommendation user-based
def test8():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')
    time.sleep(1)
    
    temp = browser.find_element_by_id('movieID')
    temp.click()
    time.sleep(1)
    
    temp = browser.find_element_by_id('1')
    temp.click()
    time.sleep(1)

    input = browser.find_element_by_id('movieName')
    input.send_keys('Heat (1995)')
    time.sleep(1)


    temp = browser.find_element_by_tag_name('button')
    temp.click()
    time.sleep(2)


    input = browser.find_element_by_id('movieName')
    input.send_keys('theENd')
    time.sleep(1)

    temp = browser.find_element_by_tag_name('button')
    temp.click()
    time.sleep(2)

    
    message1 = browser.find_element_by_name('movieId1')
    message1.send_keys('2000')
    select1 = browser.find_element_by_xpath("/html/body/form[2]/select[1]/option[5]")
    select1.click()
    time.sleep(1)
    
    message2 = browser.find_element_by_name('movieId2')
    message2.send_keys('100')
    select2 = browser.find_element_by_xpath("/html/body/form[2]/select[2]/option[6]")
    select2.click()
    time.sleep(1)
    
    message3 = browser.find_element_by_name('movieId3')
    message3.send_keys('500')
    select3 = browser.find_element_by_xpath("/html/body/form[2]/select[3]/option[6]")
    select3.click()
    
    
    submit2 = browser.find_element_by_xpath("/html/body/form[2]/button[1]")
    submit2.click()

#test calculator
def test9():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')
    time.sleep(1)
    
    temp = browser.find_element_by_id('calculatorID')
    temp.click()
    time.sleep(1)

    input1 = browser.find_element_by_xpath("/html/body/form[1]/input[1]")
    input1.send_keys('1')
    input2 = browser.find_element_by_xpath("/html/body/form[1]/input[2]")
    input2.send_keys('7')
    time.sleep(1)
    input3 = browser.find_element_by_xpath("/html/body/form[1]/input[3]")
    input3.send_keys('1000')
    select = browser.find_element_by_xpath("/html/body/form[1]/select[1]/option[1]")
    select.click()
    time.sleep(1)
    submit = browser.find_element_by_xpath("/html/body/form[1]/input[8]")
    submit.click()

    time.sleep(3)
    
    input1 = browser.find_element_by_xpath("/html/body/form[2]/input[1]")
    input1.send_keys('5')
    input2 = browser.find_element_by_xpath("/html/body/form[2]/input[2]")
    input2.send_keys('12')
    time.sleep(1)
    submit = browser.find_element_by_xpath("/html/body/form[2]/input[3]")
    submit.click()

    time.sleep(3)

    input1 = browser.find_element_by_xpath("/html/body/form[3]/input[1]")
    input1.send_keys('60000')
    input2 = browser.find_element_by_xpath("/html/body/form[3]/input[2]")
    input2.send_keys('1')
    time.sleep(1)
    input3 = browser.find_element_by_xpath("/html/body/form[3]/input[4]")
    input3.send_keys('4')
    input4 = browser.find_element_by_xpath("/html/body/form[3]/input[5]")
    input4.send_keys('6')
    time.sleep(1)
    submit = browser.find_element_by_xpath("/html/body/form[3]/input[7]")
    submit.click()

#test finance
def test10():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')
    time.sleep(1)
    
    temp = browser.find_element_by_id('financeID')
    temp.click()
    time.sleep(1)

    link = browser.find_element_by_xpath("/html/body/a[2]")
    link.click()
    time.sleep(1)

    input1 = browser.find_element_by_xpath("/html/body/form[2]/input[1]")
    input1.send_keys('08/09/2019')
    addExpenses = browser.find_element_by_xpath("/html/body/button[1]")
    addExpenses.click()
    addExpenses.click()
    time.sleep(1)
    input2 = browser.find_element_by_xpath("/html/body/form[2]/div[1]/div[1]/input[1]")
    input2.send_keys('20')
    input4 = browser.find_element_by_xpath("/html/body/form[2]/div[1]/div[1]/select[1]/option[6]")
    input4.click()

    input3 = browser.find_element_by_xpath("/html/body/form[2]/div[1]/div[2]/input[1]")
    input3.send_keys('4')
    input4 = browser.find_element_by_xpath("/html/body/form[2]/div[1]/div[2]/select[1]/option[3]")
    input4.click()

    submit = browser.find_element_by_xpath("/html/body/form[2]/input[2]")
    submit.click()
    time.sleep(2)

    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')


    temp = browser.find_element_by_id('financeID')
    temp.click()
    time.sleep(1)

    link = browser.find_element_by_xpath("/html/body/a[3]")
    link.click()
    time.sleep(3)

#test statement
def test11():
    browser = webdriver.Chrome('/Users/Student/pyproject/chromedriver')
    browser.get('http://localhost:4000/?serialNumber=MTA1OTg4MjExMjk5ODAwNzA1Nzc1LEhvYW5nIFZ1LGhvYW5ndnUyNzE5NEBnbWFpbC5jb20')
    time.sleep(1)
    
    temp = browser.find_element_by_id('accountingID')
    temp.click()
    time.sleep(1)
    link = browser.find_element_by_xpath("/html/body/div[1]/a[5]")
    link.click()

