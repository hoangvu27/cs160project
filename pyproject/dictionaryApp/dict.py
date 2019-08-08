import requests
from bs4 import BeautifulSoup as bs
import sys

word = 'blind' # depends on the input
x=1
message = ""
context = { "result" : [] , }
found = 1
headers = {"User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36"}

while found == 1:
    try:
        print(x)
        number = str(x)
        url = "https://www.oxfordlearnersdictionaries.com/us/definition/english/"
        url += word + '_' + number

        a = requests.get(url, headers=headers)
        b = bs(a.content, 'lxml')
        c = b.findAll("span", {"class": "pos"})
        print(c[0].text)
        context['result'].append( c[0].text )

        definitions = b.findAll("span", {"class": "def"})
        for i in range(len(definitions)):
            print(definitions[i].text)
            context['result'].append( definitions[i].text )
        x += 1
    except:
            found = 0
            continue

if x == 1:
    message = "Word not found"


