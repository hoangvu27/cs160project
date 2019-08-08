import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn import svm
import joblib


input = []
input.append(' XXXMobileMovieClub: To use your credit, click the WAP link in the next txt message or click here>> ')

model = joblib.load("/Users/Student/pyproject/contactApp/completeSvm")
model.best_params_
cv = CountVectorizer()
test = cv.transform(input)
prediction = model.predict(test)
print(prediction)
