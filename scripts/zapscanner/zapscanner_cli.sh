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

# Start ZAP Scanner
zap-cli start --start-options '-config api.key=12345'
# Importing context file
zap-cli --api-key 12345 context import ${WORKSPACE}/scripts/zapscanner/context/devsecops.context
# Spider target url ZAP Scanner
zap-cli --api-key 12345 spider ${TARGET_URL} --context-name devsecops
# Do Active Scan using ZAP Scanner 
zap-cli --api-key 12345 active-scan ${TARGET_URL} --context-name devsecops

# Export Report 
zap-cli --api-key 12345 report --output-format=xml -o ${WORKSPACE}/reports/${GIT_COMMIT}-zap_scanner.xml 

# Shutdown ZAP scanner 
zap-cli --api-key 12345 shutdown

DATE=`date +%Y-%m-%d`

export PROJECT_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --createproject --project_name=DevSecOps --project_disc=PROJECT_DISC --project_start=${DATE}  --project_end=${DATE} --project_owner=NotSoSecure | tail -n1 | jq '.project_id' | sed -e 's/^"//' -e 's/"$//'`

export SCAN_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --upload --file_type=XML --file=${WORKSPACE}/reports/${GIT_COMMIT}-zap_scanner.xml --TARGET=''$GIT_COMMIT'' --scanner=zap_scan --project_id=''$PROJECT_ID'' | tail -n1 | jq '.scan_id' | sed -e 's/^"//' -e 's/"$//'`

echo "scan id: " $SCAN_ID