import requests
import json
import csv

url = "https://api.preyproject.com/v1/devices"
headers = {'apikey': 'WQFLFwxsryAp3hd2ccIFJrXqTLBThC0d'}
response = requests.get(url, headers=headers)

data = response.json()
#print(data['devices'][0]['location']['lng'])

with open("D:/test.csv", "w", newline="") as external_device:
	csv_header_column = ["computer_name", "os_version", "windows_build_number", "logged_user", "bios_vendor", "bios_version", "mac_address", "latitude ", "longitude"]
	csv_writer = csv.writer(external_device)
	csv_writer.writerow(csv_header_column)    # write header

	for i in range(len(data['devices'])):
		print("{}. {}".format(i, data['devices'][i].get('location')))

		computer_name = data['devices'][i]['name']
		os_version = data['devices'][i]['os_details']['os'] + " " + str(data['devices'][i]['os_details']['os_version_name'])
		windows_build_number = data['devices'][i]['os_details']['os_version']
		logged_user = data['devices'][i]['logged_user']
		bios_vendor = data['devices'][i]['device_details']['hardware'][0]['data'][2]['bios_vendor']
		bios_version = data['devices'][i]['device_details']['hardware'][0]['data'][3]['bios_version']
		mac_address = data['devices'][i]['device_details']['mac_addresses'][0]['mac_address']
		if data['devices'][i].get('location') == None:
			print("Yes!")
			latitude = "None"
			longitude = "None"
		else:
			latitude = data['devices'][i]['location']['lat']
			longitude = data['devices'][i]['location']['lng']
		external_device_information = [computer_name, os_version, windows_build_number, logged_user, bios_vendor, bios_version, mac_address, latitude, longitude]
		csv_writer.writerow(external_device_information)

	external_device.close()

#print(data['devices'][0]['location']['lat'])

#test = data['devices'][14]['location']['lat']
#print(test)