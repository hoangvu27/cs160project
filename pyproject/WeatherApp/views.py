from django.shortcuts import render
import requests
import datetime
import calendar
from django.utils.datastructures import MultiValueDictKeyError
from .result import Result
import personal_portfolio.urls

# Create your views here.
def WeatherForecast(request):
    url = 'http://api.openweathermap.org/data/2.5/forecast?q={}&units=imperial&APPID=18490a55870dc1297c925d039f2df17f'
    city = 'san jose'
    if request.method == 'POST':
        city = request.POST.get('changeLocation')

    data = requests.get(url.format(city)).json()
    message = ""
    WeatherInfo = {}
    shot = Result[1]

    if data['cod'] == "200":
        a = data['list'][0]['dt_txt']
        year = int(a[:4])
        month = int(a[6:7])
        date = int(a[8:10])
        b = datetime.date(year, month, date).weekday()
        lat = data['city']['coord']['lat']
        lon = data['city']['coord']['lon']
        url2 = 'http://api.openweathermap.org/data/2.5/uvi?appid=18490a55870dc1297c925d039f2df17f&lat=' + str(lat) + '&lon='+ str(lon)
        uvData = requests.get(url2).json()

        url3 = 'https://api.darksky.net/forecast/08799c68381328c799ed741daf78f08e/' + str(lat) + ',' + str(lon)
        darkskyData = requests.get(url3).json()
        precipType = darkskyData['daily']['data'][0]['precipType']
#   precipType must be used in this way. Otherwise, python cannot convert string to property 

        WeatherInfo = {
            'city' : city,
            'temperature' : data['list'][0]['main']['temp'],
            'description' : data['list'][0]['weather'][0]['description'],
            'icon' : data['list'][0]['weather'][0]['icon'],
            'nation' : data['city']['country'],
            'highest' : data['list'][0]['main']['temp_max'],
            'lowest' : data['list'][0]['main']['temp_min'],
            'today' :  calendar.day_name[ b] ,
            'humid' : data['list'][0]['main']['humidity'],
            'UV' : uvData['value'],
            'wind' : {
                'speed' : data['list'][0]['wind']['speed'] * 2.237,
                'direction' : degToCompass(data['list'][0]['wind']['deg'] ),
            },
            'pressure' : data['list'][0]['main']['pressure'],
            'precipitation' : {
                'probability' : darkskyData['daily']['data'][0]['precipProbability'],
                'precipType' : precipType,
                'precipClassify' : precipitationClassify( darkskyData['daily']['data'][0]['precipIntensity'] ) ,
                'precipIntensity' : darkskyData['daily']['data'][0]['precipIntensity'],
            },
            'cloud' : data['list'][0]['clouds'],
            'visibility' : darkskyData['daily']['data'][0]['visibility'],

            'day2' : {
                'icon' : data['list'][1]['weather'][0]['icon'],
                'highest' : data['list'][1]['main']['temp_max'],
                'lowest' : data['list'][1]['main']['temp_min'],
                'date' :  calendar.day_name[ ( b + 1 ) % 7 ] ,
                'humid' : data['list'][1]['main']['humidity'],
                'probRain' : darkskyData['daily']['data'][1]['precipProbability'],
            },
            'day3' : {
                'icon' : data['list'][2]['weather'][0]['icon'],
                'highest' : data['list'][2]['main']['temp_max'],
                'lowest' : data['list'][2]['main']['temp_min'],
                'date' : calendar.day_name[ ( b + 2 ) % 7 ] ,
                'humid' : data['list'][2]['main']['humidity'],
                'probRain' : darkskyData['daily']['data'][2]['precipProbability'],
            },
            'day4': {
                'icon' : data['list'][3]['weather'][0]['icon'],
                'highest' : data['list'][3]['main']['temp_max'],
                'lowest' : data['list'][3]['main']['temp_min'],
                'date' : calendar.day_name[ ( b + 3 ) % 7 ] ,
                'humid' : data['list'][3]['main']['humidity'],
                'probRain' : darkskyData['daily']['data'][3]['precipProbability'],
            },
            'day5': {
                'icon' : data['list'][4]['weather'][0]['icon'],
                'highest' : data['list'][4]['main']['temp_max'],
                'lowest' : data['list'][4]['main']['temp_min'],
                'date' : calendar.day_name[ ( b + 4 ) % 7 ] ,
                'humid' : data['list'][4]['main']['humidity'],
                'probRain' : darkskyData['daily']['data'][4]['precipProbability'],
            }
        }
        Result[0] = WeatherInfo
        shot = (Result[1] + 1 ) % 6
        Result[1] = shot
    else:
        message = "Empty String or No City found "
        WeatherInfo = Result[0]
        shot = Result[1]
    
    context = { 'WeatherInfo' : WeatherInfo , 'message' : message, 'shot' : shot }
    return render(request, 'WeatherApp.html',context)

def precipitationClassify(num):
    temp = num / 25.4
    if temp > 0.31:
        return 'Heavy '
    elif temp > 0.11:
        return 'moderate'
    elif temp > 0 :
        return 'light'
    else:
        return 'no precipitation'

# the function method degToCompass(num): below is taken from https://stackoverflow.com/questions/7490660/converting-wind-direction-in-angles-to-text-words
def degToCompass(num):
    val=int((num/22.5)+.5)
    arr=["N","NNE","NE","ENE","E","ESE", "SE", "SSE","S","SSW","SW","WSW","W","WNW","NW","NNW"]
    return arr[(val % 16)]

#   to convert JSON from Python, first convert JSON object to JSON string
#   x = JSON.dump(data)
#   then covert JSON string to Python
#   y = JSON.load(x)
#   for key, value in y.items()
#       print key, value 
