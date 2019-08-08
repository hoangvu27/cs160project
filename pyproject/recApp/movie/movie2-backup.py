import json
import csv
import numpy as np
from scipy.spatial import distance
import pandas as pd
from statistics import mean

with open('ratings.json') as f:
    ratingdata = json.load(f)

with open('movies.json') as g:
    movieData = json.load(g)

print(ratingdata[0])
aList = list(movieData)
aList = sorted(aList,key=lambda x:x['movieId'], reverse=True)
col = aList[0]['movieId']

aList = list(ratingdata)
aList = sorted(aList,key=lambda x:x['userId'], reverse=True)
row = aList[0]['userId']
# have checked the reference in python, this approach works

ratingMatrix =  np.zeros((row,col))
for aRow in ratingdata: #ratingdata is the original file of rating.json
    rowIndex = aRow['userId'] - 1  #because the matrix starts at the index 0
    colIndex = aRow[ 'movieId' ] - 1
    ratingMatrix[rowIndex][colIndex] = aRow['rating']

euclideanMatrix =  np.zeros((1,row))
userMatrix = np.zeros((1,col))
userRating = [ {
              "movieId": 5000,
              "rating": 3,
              },
              {
              "movieId": 58,
              "rating": 3,
              },
              {
              "movieId": 24,
              "rating": 3,
              },
              {
              "movieId": 3000,
              "rating": 3,
              },{
              "movieId": 2000,
              "rating": 3,
              },]
for aRow in userRating:
    colIndex = aRow[ 'movieId' ] - 1
    userMatrix[0][colIndex] = aRow['rating']
ratingMatrix = np.vstack([ratingMatrix, userMatrix])


n = 0
while n < len(ratingMatrix):
    euclideanMatrix[0][n] = np.linalg.norm(ratingMatrix[len(ratingMatrix)-1] - ratingMatrix[n] )
    if n == 609:
        print(n)
    n += 1
# the matrix only has the euclid distance => need to change to similarity score
# simScoreMatrix = ...  -> simScore = 1 / ( 1 + euclideanDistance ) 
aList = list(enumerate(euclideanMatrix[0]))
aList = sorted(aList,key=lambda x:x[1], reverse=False)
#print(aList)
# after sort the list, then use the loop to go from

# for simply, find the first coefficient correlation that is smaller than 0.05 ( NOT the one of the userIndex 0 ) => used to predict rate
print(np.corrcoef(ratingMatrix[0], ratingMatrix[610]))
if np.corrcoef(ratingMatrix[0], ratingMatrix[610])[0,1] < 0.05:
    average1 = mean(ratingMatrix[0]) # => need to fix this, since some movies have not been rated
    # first way is find the sum, not the mean
    # second way : there is a library function to calculate mean of rated movies
    average2 = mean(ratingMatrix[610])
#   targetColumnIndex = ratingdata[0][targetMovieId ] - 1  # => similar to line 27, aRow[ 'movieId' ] - 1
#   result = (average1 / average2 ) * ratingMatrix[0][targetColumnIndex]
