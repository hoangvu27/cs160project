from django.shortcuts import render
from .forms import wordInput
import requests
from bs4 import BeautifulSoup as bs
import json

def dictionary(request):
    result = []
    message = ""
    if request.method == 'POST':
        form = wordInput(request.POST)
        x=1
        found = 1
        headers = {"User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36"}

        while found == 1:
            try:
                number = str(x)
                word = request.POST.get('word')
                url = "https://www.oxfordlearnersdictionaries.com/us/definition/english/"
                url += word + '_' + number
                
                a = requests.get(url, headers=headers)
                b = bs(a.content, 'lxml')
                c = b.findAll("span", {"class": "pos"})
                result.append( c[0].text )

                definitions = b.findAll("span", {"class": "def"})
                for i in range(len(definitions)):
                    result.append( definitions[i].text )
                x += 1
            except:
                found = 0
                continue
        if x-1 == 0:
            message = "Word not found"
    else:
        form = wordInput()
    context = { 'result' : result, 'form' : form , 'message' : message}
    return render(request, 'dictApp.html', context)

