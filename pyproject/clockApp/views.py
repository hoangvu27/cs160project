from django.shortcuts import render
import requests
from bs4 import BeautifulSoup as bs
import datetime


# Create your views here.
def clock(request):
    city = request.POST.get('city')
    headers = {"User-Agent": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/72.0.3626.119 Safari/537.36"}
    x = datetime.datetime.now()
    hour = x.hour + 5
    weekday = x.strftime("%A")
    targetHour = hour
    if city != None:
        url = 'https://www.timeanddate.com/worldclock/?query=' + city
        a = requests.get(url, headers=headers)
        b = bs(a.content, 'lxml')
        c = b.findAll("td", {"class": "rbi"})
        temp = c[0].text
        pos = temp.find(':')
        weekday = temp[0:3]
        targetHour =  int(temp[4: pos])
    hourGap = targetHour - hour
    context = { 'weekday' : weekday, 'hourGap' : hourGap }
#    need to pass RequestContext in render_to_response for csrf_token
    return render(request, 'clockApp.html', context)
