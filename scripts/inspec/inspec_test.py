# -*- coding: utf-8 -*-
#  _   _       _   ____       ____                            
# | \ | | ___ | |_/ ___|  ___/ ___|  ___  ___ _   _ _ __ ___  
# |  \| |/ _ \| __\___ \ / _ \___ \ / _ \/ __| | | | '__/ _ \ 
# | |\  | (_) | |_ ___) | (_) |__) |  __/ (__| |_| | | |  __/ 
# |_| \_|\___/ \__|____/ \___/____/ \___|\___|\__,_|_|  \___| 
#                                                             
# Copyright (C) 2019 NotSoSecure
#
# Email:   contact@notsosecure.com
# Twitter: @notsosecure
#
# This file is part of DevSecOps Training.

import json
from optparse import OptionParser, OptionGroup

failed = None
skipped = None
passed = None

parser = OptionParser()

group = OptionGroup(parser, "",
                        "")

parser.add_option_group(group)

group = OptionGroup(parser, "Upload Scanner Reports",
                    "Upload multiple scanners reports"
                    )

group.add_option("-f", "--file",
                 help="Input JSON or XML file",
                 action="store")

group.add_option("--failed",
                 help="Numbers of issue",
                 action="store")


(args, _) = parser.parse_args()

if args.file:

    with open(args.file) as f:
        data = json.load(f)

    passed = []
    skipped = []
    failed = []

    for key, value1 in data.items():
        if key == 'profiles':
            for res in value1:
                for key, value2 in res.items():
                    if key == 'controls':
                        for res2 in value2:
                            re = res2['results']
                            for r in re:
                                current_status = r['status']
                                issue_text = r['code_desc']

                                if current_status == 'passed':
                                    passed.append(current_status)
                                    print( "Passed test case :", issue_text)

                                if current_status == 'skipped':
                                    skipped.append(current_status)
                                    print( "Skipped test case :", issue_text)

                                if current_status == 'failed':
                                    failed.append(current_status)
                                    print( "Failed test case :", issue_text)

    print( "Passed:", passed.count('passed'))
    print( "Skipped", skipped.count('skipped'))
    print( "Failed:", failed.count('failed'))

    if int(failed.count('failed')) >= int(args.failed):
        fail = "FAILURE"
        print("Coz total %s Failed" % failed.count('failed'))
    else:
        fail = "SUCCESS"

        print("Test Passed")

    print(fail)