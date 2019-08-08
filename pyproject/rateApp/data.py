import cv2,os
from sklearn.externals import joblib
import numpy as np
import csv
import glob

#MOST OF THE CODE IN THIS FILE IN TAKEN FROM HEROKU, BUT THE FILE DOES NOT WORK, SO I MODIFY SOME LINES
# https://github.com/codeheroku/Introduction-to-Machine-Learning/blob/748a8c2569783bf1b5f8f138f1f5f623504e2414/Building%20a%20Digit%20Recognizer/gen_dataset.py


a=0
with open('/Users/Student/pyproject/rateApp/csv/dataRating.csv', 'w') as f:
    writer = csv.writer(f)
    
    arr = []
    arr.append('label')
    b = 0
    while b < 784:
        temp = 'pixel' + str(b)
        arr.append(temp)
        b = b + 1
    writer.writerow(arr)


    while a < 6:
        label = str(a)
        dirList = glob.glob("/Users/Student/pyproject/rateApp/img/"+label+"/*.png")
        for imgPath in dirList:
    
            im = cv2.imread(imgPath)
            im_gray = cv2.cvtColor(im, cv2.COLOR_BGR2GRAY)
            im_gray = cv2.GaussianBlur(im_gray, (15, 15), 0)
            roi = cv2.resize(im_gray, (28, 28), interpolation=cv2.INTER_AREA)


            data=[]
            data.append(label)
            rows,cols = roi.shape

            for i in range(rows):
                for j in range(cols):
                    k = roi[i,j]
                    if k>100:
                        k=1
                    else:
                        k=0
                    data.append(k)

            writer.writerow(data)
        a = a+1



