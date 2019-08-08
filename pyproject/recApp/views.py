from django.shortcuts import render
import requests
import json
import csv
import pandas as pd
from recApp.movie import Mapp as contentRec
from recApp.movie import movie2 as userRec
from recApp.movie import title as helper

def recommend(request):
    context = { }
    return render(request, 'recApp.html', context)


def content(request):
    message = ''
    arr = []
    search = 0
    if request.method == 'POST':
        target = request.POST.get('movieName')
        result = contentRec.giveRec(target)

        if result == -1 :
            message = 'No such movie in the database, please enter another movie'
            search = 1
        else:
            arr = result
    context = { 'arr' : arr , 'message' : message , 'search' : search }
    return render(request, 'content.html', context)

def user(request):
    message = ''
    title = ''
    arr =  helper.getMovieList()
    id = 0
    correlation = 0
    if request.method == 'POST':
 
        if request.POST.get('movieName') != None:
            id = helper.getMovieId( request.POST.get('movieName') )
            if id == -1:
                message = 'Sorry, no such movie in database'
    
        elif request.POST.get('score1') != None:
#            try:
                score1 = int(request.POST.get('score1') )
                score2 = int(request.POST.get('score2') )
                score3 = int(request.POST.get('score3') )
                id1 = int(request.POST.get('movieId1') )
                id2 = int(request.POST.get('movieId2') )
                id3 = int(request.POST.get('movieId3') )

                userRating = []
                userRating.append( {"movieId" : id1, "rating" : score1 })
                userRating.append( {"movieId" : id2, "rating" : score2 })
                userRating.append( {"movieId" : id3, "rating" : score3 })
                
                summary = userRec.showRec(userRating)
                targetId = summary['targetId'] 
                targetPersonId =  summary['correlationPersonId']
                correlation =  summary['correlation']
                found = summary['found']
                
                if found == 1:
                    message = 'Since you have high correlation with the person with the ID ' + str(targetPersonId) + ' , the recommendation is that you should watch all of his or her favorite movie'
                elif found == 0:
                    message = 'The highest correlation is ' + str(correlation) + ' , but the movie you should watch is '
                    title =  helper.getTitle(targetId)
#            except:
#                message = 'Some input has invalid values'

    context = { 'title' : title, 'arr' : arr, 'message' : message , 'id' : id , 'correlation' : correlation}
    return render(request, 'user.html', context)
