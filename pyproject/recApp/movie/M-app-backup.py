import numpy as np
import csv
import pandas as pd
import sklearn
from sklearn.feature_extraction.text import CountVectorizer
import math
from sklearn.metrics.pairwise import cosine_similarity

# this function below works well if the matrix is not too large
def cosineSimilarity(matrix):
    arr = matrix.toarray()
    similarityMatrix = [ [ 0 for i in range(len(arr)) ] for j in range(len(arr)) ]
    for m in range(len(arr)):
        n = m
        while n < len(arr):
            A = arr[m]
            B = arr[n]
            dotAB = A @ B
            sumA = 0
            sumB = 0
            for i in range(len(A)):
                sumA += A[i] * A[i]
                sumB += B[i] * B[i]
            if (sumA == 0 or sumB == 0):
                similarityMatrix[m][n] = 0
                similarityMatrix[n][m] = similarityMatrix[m][n]
                # this condition can almost never happen, just add it because of terminal warning
            else:
                similarityMatrix[m][n] = dotAB / math.sqrt(sumA * sumB)
                similarityMatrix[n][m] = similarityMatrix[m][n]
            n += 1
    return similarityMatrix



data = pd.read_csv("movie_dataset.csv")


criteria = ['genres', 'spoken_languages', 'popularity', 'keywords', 'release_date', 'cast']
for criterium in criteria:
    data[criterium] = data[criterium].fillna('')
def theCriteria(row):
        return row['cast'] + " " + str(row['popularity']) + " " + row['spoken_languages'] + " "  + str(row['release_date']) + " " + row['genres'] + " " + row['keywords']

data['criteria'] = data.apply(theCriteria, axis=1)

vector = CountVectorizer()
matrix = vector.fit_transform(data['criteria'])
#print(matrix.toarray())
similarityMatrix = cosine_similarity(matrix)
#print(similarityMatrix)
movieInput = "Avatar"



# these 2 functions below copy from https://medium.com/code-heroku/building-a-movie-recommendation-engine-in-python-using-scikit-learn-c7489d7cb145
def getIndex(title):
    try:
        return data[data.title == title]["index"].values[0]
    except:
        return -1
def getTitle(index):
    return data[data.index == index]["title"].values[0]

targetIndex = getIndex(movieInput)
recommendations = list(enumerate(similarityMatrix[targetIndex]))
sortedRecommendations = sorted(recommendations, key=lambda matrix:matrix[1], reverse=True)

x=0
for film in sortedRecommendations:
    if x>0:
        print(getTitle(film[0]))
    x += 1
    if x == 6:
        break

print(getIndex("suck"))






