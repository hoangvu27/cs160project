import cv2,os
from sklearn.externals import joblib
import numpy as np
import csv
import glob
import os
#MOST OF THE CODE IN THIS FILE IN TAKEN FROM HEROKU, BUT THE FILE DOES NOT WORK, SO I MODIFY SOME LINES
# https://github.com/codeheroku/Introduction-to-Machine-Learning/blob/748a8c2569783bf1b5f8f138f1f5f623504e2414/Building%20a%20Digit%20Recognizer/gen_dataset.py

path = "/Users/Student/pyproject/contactApp/spam"


with open("aha.csv", 'a') as f:
    writer = csv.writer(f)
    
    arr = []
    arr.append('Label')
    arr.append('EmailText')
    writer.writerow(arr)
    
    for filename in os.listdir(path):
        full = path + '/' + filename
        read = open(full, encoding="latin-1")
        data=[]
        data.append('spam')
        data.append( read.read().replace('\n', '') )
        writer.writerow(data)

