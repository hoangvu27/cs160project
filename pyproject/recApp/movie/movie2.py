import json
import csv
import numpy as np
from scipy.spatial import distance
import pandas as pd
from statistics import mean
import random
import heapq

def showRec(userRating):
    with open("/Users/Student/pyproject/recApp/movie/ratings.json") as f:
        ratingdata = json.load(f)

    with open("/Users/Student/pyproject/recApp/movie/movies.json") as g:
        movieData = json.load(g)


    aList = list(movieData)
    aList = sorted(aList,key=lambda x:x['movieId'], reverse=True)
    col = aList[0]['movieId']

    aList = list(ratingdata)
    aList = sorted(aList,key=lambda x:x['userId'], reverse=True)
    row = aList[0]['userId']


    ratingMatrix =  np.zeros((row ,col))
    for aRow in ratingdata: #ratingdata is the original file of rating.json
        rowIndex = aRow['userId'] - 1  #because the matrix starts at the index 0
        colIndex = aRow[ 'movieId' ] - 1
        ratingMatrix[rowIndex][colIndex] = aRow['rating']


    userMatrix = np.zeros((1,col))
#    userRating = [ {
#              "movieId": 5000,
#              "rating": 3,
#              },
#              {
#              "movieId": 58,
#              "rating": 3,
#              },
#              {
#              "movieId": 24,
#              "rating": 3,
#              },
#              {
#              "movieId": 3000,
#              "rating": 3,
#              },{
#              "movieId": 2000,
#              "rating": 3,
#              },]
    for aRow in userRating:
        colIndex = aRow[ 'movieId' ] - 1
        userMatrix[0][colIndex] = aRow['rating']
    ratingMatrix = np.vstack([ratingMatrix, userMatrix])

    simMatrix =  np.zeros((1,row+1))

    n = 0
    while n < len(ratingMatrix):
        euclideanDistance = np.linalg.norm(ratingMatrix[len(ratingMatrix)-1] - ratingMatrix[n] )
        simMatrix[0][n] = 1 / ( 1 + euclideanDistance )
        n += 1

    aList = list(enumerate(simMatrix[0]))
    aList = sorted(aList,key=lambda x:x[1], reverse=True)

    number = random.randint(0, 6)
    userId =  aList[number][0]
    maxRating = max( ratingMatrix[ userId ] )
    targetId = list( ratingMatrix[ userId ] ).index(maxRating)
    if number % 2 == 0 :
        heapq.nlargest(2, list( ratingMatrix[ userId ] ))

    corrMatrix =  np.zeros((1,row+1))
    n = 0
    correlationPersonId = -1
    found = 0
    while n < len(ratingMatrix):
        p = np.corrcoef(ratingMatrix[ n ], ratingMatrix[610])[0][1]
        corrMatrix[0][n] = p
        if p > 0.7 and n != 610:
            correlationPersonId = n
            found = 1
        n += 1
#        t = round( np.corrcoef(ratingMatrix[ n ], ratingMatrix[610])[0][1] * 1000, 5 )
#        the round shows that the correlation is close to 0 => no correlation

    newList = list(enumerate(corrMatrix[0]))
    newList = sorted(newList,key=lambda x:x[1], reverse=True)
    correlation = newList[1][1]

    if found == 0:
        correlationPersonId = newList[1][0]

#    p = np.corrcoef(ratingMatrix[ 0 ], ratingMatrix[610])[0][1]
#    if p < -0.7 or p > 0.7:
#        correlationPersonId = userId

    return { 'targetId' : targetId, 'correlationPersonId' : correlationPersonId , 'correlation' : correlation , 'found' : found}
