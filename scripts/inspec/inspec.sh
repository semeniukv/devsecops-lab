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

#!/bin/bash

DATE=`date +%Y-%m-%d`
# export COMMIT_ID=`cat .git/HEAD`
export PROJECT_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --createproject --project_name=DevSecOps --project_disc=PROJECT_DISC --project_start=${DATE}  --project_end=${DATE} --project_owner=NotSoSecure | tail -n1 | jq -r ".project_id"`
echo $PROJECT_ID

SCAN_ID=`archerysec-cli -s ${ARCHERYSEC_HOST} -u ${ARCHERY_USER} -p ${ARCHERY_PASS} --upload --file_type=JSON --file=${WORKSPACE}/reports/tomcatproduction.json --TARGET=''$COMMIT_ID'' --scanner=inspec --project_id=''$PROJECT_ID'' | tail -n1 | jq -r ".scan_id"`
                     
echo $SCAN_ID

job_status=`python3 ${WORKSPACE}/scripts/inspec/inspec_test.py --failed 100 -f ${WORKSPACE}/reports/tomcatproduction.json | grep SUCCESS`

if [ -n "$job_status" ]
then
# Run your script commands here
echo "Build Sucess"
else
echo "BUILD FAILURE: Other build is unsuccessful or status could not be obtained."
exit 100
fi

exit 0