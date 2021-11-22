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
#!/bin/bash

DATE=`date +%Y-%m-%d`

export PROJECT_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --createproject --project_name=DevSecOps --project_disc=PROJECT_DISC --project_start=${DATE}  --project_end=${DATE} --project_owner=NotSoSecure | tail -n1 | jq '.project_id' | sed -e 's/^"//' -e 's/"$//'`

export SCAN_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --openvasscan --target_ip=''${TARGET_IP}'' --project_id=''$PROJECT_ID'' | tail -n1 | jq '.scanid' | sed -e 's/^"//' -e 's/"$//'`

echo "OpenVAS Scan started in ArcherySec"