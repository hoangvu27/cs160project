from django.urls import path
from WeatherApp import views

urlpatterns = [
               path('', views.WeatherForecast, name='WeatherMainPath'),
               ]
