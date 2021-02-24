#!/usr/bin/python3

import csv
import os

def create_app_list(csv_file, mylist):
    for row in csv_file:
        app_name, version = row
        mylist.append(app_name)
    return mylist

app_white_list = csv.reader(open("./diff_app_sample/white_list.csv"))

white_list = []
result = {}
create_app_list(app_white_list, white_list)


path = "./diff_app_sample/Client_File"
files = os.listdir(path)

for file in files:
    computer_name = file.split('.')[0]
    app_client = csv.reader(open(path+"/"+file))
    client_list = []
    diff_list = []

    create_app_list(app_client, client_list)

    for app_client in client_list:
        if app_client not in white_list:
            diff_list.append(app_client)
    result[computer_name] = diff_list

f = open("./diff_app_sample/diff_result.txt","w")
for key,val in result.items():
    f.write("{} : {}\n".format(key,val))

f.close()

