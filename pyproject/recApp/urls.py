from django.urls import path
from . import views

urlpatterns = [
               path('', views.recommend, name='recommend'),
               path('content/', views.content, name='content'),
               path('user/', views.user, name='user'),
               ]
