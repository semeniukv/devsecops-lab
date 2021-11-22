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

python3 ${WORKSPACE}/scripts/openvas/openvas-cli.py --host ${OPENVAS_HOST} --user ${OPENVAS_USER} --password ${OPENVAS_PASS} --port ${OPENVAS_PORT} --target ${TARGET_IP} --path ${WORKSPACE}/reports/${GIT_COMMIT}-openvas_report.xml

export PROJECT_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --createproject --project_name=DevSecOps --project_disc=PROJECT_DISC --project_start=${DATE}  --project_end=${DATE} --project_owner=NotSoSecure | tail -n1 | jq '.project_id' | sed -e 's/^"//' -e 's/"$//'`

export SCAN_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --upload --file_type=XML --file=${WORKSPACE}/reports/${GIT_COMMIT}-openvas_report.xml --TARGET=''$GIT_COMMIT'' --scanner=openvas --project_id=''$PROJECT_ID'' | tail -n1 | jq '.scan_id' | sed -e 's/^"//' -e 's/"$//'`

echo "scan id: " $SCAN_ID