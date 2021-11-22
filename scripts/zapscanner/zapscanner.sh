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

export SCAN_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --zapscan --target_url=''${TARGET_URL}'' --project_id=''$PROJECT_ID'' | tail -n1 | jq '.scanid' | sed -e 's/^"//' -e 's/"$//'`

echo "scan id......" $SCAN_ID

# python /vagrant/scripts/zapscanner/archerysec_test.py --scanner=zap_scan --scan_id=$SCAN_ID --username=${ARCHERY_USER} --password=${ARCHERY_PASS} --host=${ARCHERYSEC_HOST} --high=${HIGH} --medium=${MEDIUM}

# job_status=`python /vagrant/scripts/zapscanner/archerysec_test.py  --scanner=zap_scan --scan_id=$SCAN_ID --username=${ARCHERY_USER} --password=${ARCHERY_PASS} --host=${ARCHERYSEC_HOST} --high=${HIGH} --medium=${MEDIUM} | grep SUCCESS`

# if [ -n "$job_status" ]
# then
#   Run your script commands here
#    echo "Build Sucess"
# else
#  echo "BUILD FAILURE: Other build is unsuccessful or status could not be obtained."
#  exit 100
# fi