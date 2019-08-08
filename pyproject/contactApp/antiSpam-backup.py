import pandas as pd
from sklearn.feature_extraction.text import CountVectorizer
from sklearn import svm
import joblib

data = pd.read_csv("/Users/Student/pyproject/contactApp/aha.csv")
text = data["EmailText"]
label = data["Label"]

xTrain , yTrain = text[0: 6000] , label[0 : 6000]
xTest , yTest = text[6000:] , label[6000:]

countVector = CountVectorizer()
model = svm.SVC(kernel="linear", C=2, probability=True)
model.fit( countVector.fit_transform(xTrain) , yTrain )
#joblib.dump(model, "/Users/Student/pyproject/contactApp/svm")

#input = []
#input.append(' wow look at all these adult dvds movies . . .over880 gigs of movies in our archivesporndvddirectfull - length dvds added daily !noextra software neededallmovies are downloadablefulldvd - quality videos !over880 gigs and growing !high - resbroadband versionsmirroreddownload serversworkswith 56 k aol !oneweek on uscheck us out here- - - - - begin pgp message - - - - -version : ctc 2 . 3comment : signs the ctcjlib . dll inside the ctclib 2 . 3 . 1 dll release ( version1 . 2 . 1044 . 27931 ) gfqlbnxadsfdfw + zwu == fcnq- - - - - end pgp message - - - - -the student said . " you see professor i have a brother , he  s 22 and he  s half nuts . "nobody is perfect . . . . holmes said , " watson , look up . what do you see ? the real problem concerning your leisure is how to keep other people from using it .he now works for microsoft , writing error messages . there is no future in spending the present worrying about the past . seven sins of life : count your joys instead of your woes ,suburbia is where the bulldozers have knocked down all the trees and the planners rename the roads after them . ( anon , us tv )maybe not for me but thank you anywayhere .')
#test = countVector.transform(input)
#prediction = model.predict(test)
#print(prediction)
print("Score:", model.score( countVector.transform(xTest), yTest) )


