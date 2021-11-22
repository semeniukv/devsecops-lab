# -*- coding: utf-8 -*-
#  _   _       _   ____       ____
# | \ | | ___ | |_/ ___|  ___/ ___|  ___  ___ _   _ _ __ ___
# |  \| |/ _ \| __\___ \ / _ \___ \ / _ \/ __| | | | '__/ _ \
# | |\  | (_) | |_ ___) | (_) |__) |  __/ (__| |_| | | |  __/
# |_| \_|\___/ \__|____/ \___/____/ \___|\___|\__,_|_|  \___|
#
# Copyright (C) 2020 NotSoSecure
#
# Email:   contact@notsosecure.com
# Twitter: @notsosecure
#
# This file is part of DevSecOps Training.

from openvas_lib import VulnscanManager, VulnscanException
from optparse import OptionParser, OptionGroup
import time
try:
	from xml.etree import cElementTree as etree
except ImportError:
	from xml.etree import ElementTree as etree

parser = OptionParser()

group = OptionGroup(parser, "",
                    "")

parser.add_option_group(group)

group = OptionGroup(parser, "OpenVAS Scan status",
                    "Upload multiple scanners reports"
                    )

group.add_option("--user",
                 help="Input OpenVAS Username",
                 action="store")

group.add_option("--password",
                 help="Input OpenVAS Password",
                 action="store")

group.add_option("--host",
                 help="Input OpenVAS Host",
                 action="store")

group.add_option("--port",
                 help="Input OpenVAS port",
                 action="store")

group.add_option("--target",
                 help="Input target",
                 action="store")

group.add_option("--path",
                 help="Input report path",
                 action="store")             

(args, _) = parser.parse_args()


def openvas():
    # Setup openvas connection
    try:
        scanner = VulnscanManager(args.host, args.user, args.password)
        print(scanner)
    except VulnscanException as e:
        print("Error:")
        print(e)

    return scanner


def openvas_launch():
    scanner = openvas()
    scan_id, target_id = scanner.launch_scan(target=args.target, profile="Full and fast")
    # print(scan_id)
    return scan_id


def scan_status(scanner, scan_id):
    previous = ''
    while float(scanner.get_progress(str(scan_id))) < 100.0:
        current = str(scanner.get_scan_status(str(scan_id))) + str(scanner.get_progress(str(scan_id)))
        if current != previous:
            print('[Scan ID ' + str(scan_id) + '](' + str(
                scanner.get_scan_status(str(scan_id))) + ') Scan progress: ' + str(
                scanner.get_progress(str(scan_id))) + ' %')
            status = float(scanner.get_progress(str(scan_id)))
            previous = current
        time.sleep(5)
        # print(status)
    return status

scanner = openvas()
scan_id = openvas_launch()
scan_status(scanner, scan_id)
openvas_results = scanner.get_raw_xml(str(scan_id))

m_response = etree.tostring(openvas_results,encoding='unicode')

with open(args.path, "w") as f:
    f.write(m_response)
    f.close()

