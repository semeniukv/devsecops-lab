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

import mechanize
from optparse import OptionParser, OptionGroup

parser = OptionParser()
group = OptionGroup(parser,"","")
parser.add_option_group(group)
group = OptionGroup(parser, "UAT Testing", "testing")
group.add_option("--email", help="username", action="store")
group.add_option("--password", help="password", action="store")
group.add_option("--url", help="url", action="store")

(args, _) = parser.parse_args()

br = mechanize.Browser()
br.set_handle_robots(False)
br.addheaders = [("User-agent","Mozilla/5.0")]
try:
    gitbot = br.open(args.url)
    br.select_form(nr=1)
except Exception as e:
    print(e)
print("Creating User:")
print("Email", args.email)

try:
    br["name"] = "test"
    br["email"] = args.email
    br["password"] = args.password
    sign_up = br.submit()
except Exception as e:
    print(e)

print( "Created User", args.email)

print( "Login User:")
print( "Email", args.email)

try:
    br.select_form(nr=0)
    br["email"] = args.email
    br["password"] = args.password
    sign_in = br.submit()
except Exception as e:
    print(e)
print( "Logged User", args.email)

out = "FAILURE"
for link in br.links():
    if link.url == 'logout.action':
        out = "SUCCESS"
print( out)