import joblib,cv2
import numpy as np
from .result import Result
import os.path
def run():
    model = joblib.load("/Users/Student/pyproject/rateApp/model/svm")
    directory = '/Users/Student/pyproject/rateApp/img/'
    filename = str(Result[0]) + '.png'
    fullPath = os.path.join(directory , filename)
    testImg = cv2.imread(fullPath)
    #    code line 6 & 10 is taken from heroku, can understand the concept, but do not know how
    #    to use parameters
    grayColor = cv2.cvtColor(testImg, cv2.COLOR_BGR2GRAY)
    igrayColor = cv2.GaussianBlur(grayColor, (15, 15), 0)
    ret, im_th = cv2.threshold(grayColor, 100, 255, cv2.THRESH_BINARY)
    resizedImg = cv2.resize(im_th, (28, 28), interpolation=cv2.INTER_AREA)

    rows,cols = resizedImg.shape
    testInput = []

    for i in range(rows):
        for j in range(cols):
            pixelValue = resizedImg[i,j]
            if pixelValue > 100:
                pixelValue = 1
            else:
                pixelValue = 0
            testInput.append(pixelValue)

    predictions = model.predict([testInput])

    return predictions[0]



