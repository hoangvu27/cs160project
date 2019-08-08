import pandas
from sklearn import svm
from sklearn import metrics
import joblib


data = pandas.read_csv('/Users/Student/pyproject/rateApp/csv/dataRating.csv')
data = data.sample(frac=1).reset_index(drop=True)

horizontal = data.drop(['label'], axis=1)
vertical = data['label']

xTrain, yTrain =  horizontal[200:354], vertical[200:354]
xTest, yTest = horizontal[:200], vertical[0:200]

model = svm.SVC(kernel="linear", C=2, probability=True)
model.fit(xTrain, yTrain)
joblib.dump(model, "/Users/Student/pyproject/rateApp/model/svm")


predictions = model.predict(xTest)
print("Score", metrics.accuracy_score(yTest, predictions) )
