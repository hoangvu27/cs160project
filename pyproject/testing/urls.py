from django.urls import path
from . import views

urlpatterns = [
               path('', views.automateTest, name='automate'),
               ]
