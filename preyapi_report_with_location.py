import requests
import json
import csv
from geopy.geocoders import Nominatim

geolocator = Nominatim(user_agent="geoapiExercises")

url = "https://api.preyproject.com/v1/devices"
headers = {'apikey': 'WQFLFwxsryAp3hd2ccIFJrXqTLBThC0d'}
response = requests.get(url, headers=headers)

data = response.json()

#Remember to change the path to correct path in your producation or testing environment

with open("/home/ansible/MobileDeviceReport.csv", "w", newline="") as external_device:
    csv_header_column = ["computer_name", "os_version", "windows_build_number", "logged_user", "bios_vendor",
                         "bios_version", "mac_address", "city", "state", "country", "latitude", "longitude"]
    csv_writer = csv.writer(external_device)
    csv_writer.writerow(csv_header_column)  # write header

    for i in range(len(data['devices'])):
        # print("{}. {}".format(i, data['devices'][i].get('location')))
        computer_name = data['devices'][i]['name']
        os_version = data['devices'][i]['os_details']['os'] + " " + str(
            data['devices'][i]['os_details']['os_version_name'])
        windows_build_number = data['devices'][i]['os_details']['os_version']
        logged_user = data['devices'][i]['logged_user']
        bios_vendor = data['devices'][i]['device_details']['hardware'][0]['data'][2]['bios_vendor']
        bios_version = data['devices'][i]['device_details']['hardware'][0]['data'][3]['bios_version']
        mac_address = data['devices'][i]['device_details']['mac_addresses'][0]['mac_address']
        try:
            latitude = str(data['devices'][i]['location']['lat'])
            longitude = str(data['devices'][i]['location']['lng'])
            location = geolocator.reverse(latitude + "," + longitude)
            try:
                city = location.raw['address']['city']
            except KeyError:
                city = "None"
            try:
                state = location.raw['address']['state']
            except KeyError:
                state = "None"
            try:
                country = location.raw['address']['country']
            except KeyError:
                country = "None"
        except KeyError:
            latitude = "None"
            longitude = "None"
            city = "None"
            state = "None"
            country = "None"

        external_device_information = [computer_name, os_version, windows_build_number, logged_user, bios_vendor,
                                       bios_version, mac_address, city, state, country, latitude, longitude]
        csv_writer.writerow(external_device_information)
    external_device.close()

"""
        if data['devices'][i].get('location') is None:
            city = "None"
            state = "None"
            country = "None"
        else:
            latitude = str(data['devices'][i]['location']['lat'])
            longitude = str(data['devices'][i]['location']['lng'])
            location = geolocator.reverse(latitude + "," + longitude)
            if 'city' in location.raw['address']:
                city = location.raw['address']['city']
            else:
                city = "None"
            if 'state' in location.raw['address']:
                state = location.raw['address']['state']
            else:
                state = "None"
            if 'country' in location.raw['address']:
                country = location.raw['address']['country']
            else:
                country = "None"

        external_device_information = [computer_name, os_version, windows_build_number, logged_user, bios_vendor, 
									   bios_version, mac_address, city, state, country]
        csv_writer.writerow(external_device_information)
    external_device.close()
"""
# print(data['devices'][0]['location']['lat'])

# test = data['devices'][14]['location']['lat']
# print(test)
