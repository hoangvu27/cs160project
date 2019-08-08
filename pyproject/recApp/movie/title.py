import json
import csv

def getMovieList():
    with open("/Users/Student/pyproject/recApp/movie/movies.json") as g:
        movieData = json.load(g)
    arr = []
    i=0
    while i< len(movieData):
        arr.append( movieData[i]['title'])
        i += 1
    return arr

def getTitle(theId):
    with open("/Users/Student/pyproject/recApp/movie/movies.json") as g:
        movieData = json.load(g)
    arr = []
    i=0
    while i < len(movieData):
        arr.append( movieData[i]['title'] )
        i += 1

    return  arr[theId - 1 ]


def getMovieId(theMovie):
    with open("/Users/Student/pyproject/recApp/movie/movies.json") as g:
        movieData = json.load(g)
    d = {}
    i=0
    while i< len(movieData):
        d[ movieData[i]['title'] ] = movieData[i]['movieId']
        i += 1
    
    try:
        return d[ theMovie ]
    except:
        return -1
