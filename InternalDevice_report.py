import csv
import json

def save_as_json(obj):
    return json.dumps(obj, sort_keys=True, indent=2)

with open("D:/InternalDevice_report.csv", "w", newline="") as internal_device:
    csv_header_column = ["computer_name", "os_version", "windows_build_number", "logged_user", "bios_vendor", "bios_version", "mac_address"]
    csv_writer = csv.writer(internal_device)
    csv_writer.writerow(csv_header_column)  # write header

    with open("D:/testfile", "r") as info_from_ansible:
        for row in info_from_ansible:
            d = json.loads(row)
            computer_name = d['ansible_facts']['ansible_env']['COMPUTERNAME']
            os_version = d['ansible_facts']['ansible_distribution'].split(" ")[1] + " " + d['ansible_facts']['ansible_distribution'].split(" ")[2]
            windows_build_number = d['ansible_facts']['ansible_distribution_version']
            logged_user = d['ansible_facts']['ansible_env']['USERNAME']
            bios_vendor = d['ansible_facts']['ansible_system_vendor']
            bios_version = d['ansible_facts']['ansible_bios_version']
            mac_address = d['ansible_facts']['ansible_interfaces'][0]['macaddress']
            internal_device_information = [computer_name, os_version, windows_build_number, logged_user, bios_vendor,
                                           bios_version, mac_address]
            csv_writer.writerow(internal_device_information)
    info_from_ansible.close()
internal_device.close()

