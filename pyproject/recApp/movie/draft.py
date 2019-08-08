import numpy as np
import csv
import pandas as pd
import sklearn
from sklearn.feature_extraction.text import CountVectorizer
import math
#from sklearn.metrics.pairwise import cosine_similarity


text = ["London London London London Paris Paris", "London Paris Tokyo", "Tokyo Tokyo"]
cv = CountVectorizer()
matrix = cv.fit_transform(text)
arr = matrix.toarray()
print(arr)
# here, the movie 1 is text[0] and the movie 2 is text[1]
# the criteria/the feature is "London London London London Paris Paris", "London Paris Tokyo" => the text is convert to the number  [4 2 0] [1 1 1]

#A = arr[0]
#B = arr[1]
#dotAB = A @ B
#
#sumA = 0
#sumB = 0
#for i in range(len(A)):
#    sumA += A[i] * A[i]
#    sumB += B[i] * B[i]
#temp = dotAB / math.sqrt(sumA * sumB)
#print(len(arr))

def cosine_similarity(matrix):
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

similarityMatrix = cosine_similarity(matrix)
print(similarityMatrix)
