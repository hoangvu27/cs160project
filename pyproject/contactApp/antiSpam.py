import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn import svm
import joblib

def go(message):
    data = pd.read_csv("/Users/Student/pyproject/contactApp/aha.csv")
    text = data["EmailText"]
    label = data["Label"]

    xTrain , yTrain = text[0: 7000] , label[0 : 7000]
    xTest , yTest = text[7000:] , label[7000:]

    countVector = CountVectorizer()
    model = svm.SVC(kernel="linear", C=2, probability=True)
    model.fit( countVector.fit_transform(xTrain) , yTrain )

    input = []
    input.append(message)
    test = countVector.transform(input)
    prediction = model.predict(test)
#    print(prediction)
#    print("Score:", model.score( countVector.transform(xTest), yTest) )
    
    type = 0;
    if prediction == 'spam':
        print('aha')
        type = 1
    if prediction == 'ham':
         print('okay')

    return type


