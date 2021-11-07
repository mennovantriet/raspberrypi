#importing the cs file
import csv as csv
import numpy

with open('/home/pi/Desktop/userReviews.csv', newline='') as rev:
    reader = csv.reader(rev, )
    reviews_df = list(reader)
    
    
# defining x
x = list()
for row in reviews_df:
    x.append(row['Author'])
# defining y
y = list()
for row in reviews_df:
    if row['movieName'] =='inception':
        y.append(row['Author'])
    print(y)
# Defining z
z = list()
for row in reviews_df:
    if row['Author'] == row['movieName']:
        z.append(row['movieName'])
    print(z)
    
numpy.savetxt("pythonrecom.csv", z, delimiter=",", fmt='% s')