# encoding=utf8
import csv
import sys



def read_csv_file(filename):
    data = []
    with open(filename, 'r') as csvfile:
        reader = csv.reader(csvfile)
        next(reader)
        for row in reader:
            print(row)
            data.append(row)
    return data



