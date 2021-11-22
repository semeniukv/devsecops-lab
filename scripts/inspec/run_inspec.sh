#!/bin/bash
# containerid=`docker ps -aqf name=mysqldb`
# inspec exec mysql.rb -t docker://$containerid  --reporter cli json:mysqlproduction.json --no-distinct-exit
tomcat_containerid=`docker ps -aqf name=prodapp`
inspec exec ${WORKSPACE}/scripts/inspec/inspec-tomcat-9 -t docker://$tomcat_containerid --chef-license=accept --reporter cli json:tomcatproduction.json --no-distinct-exit
mv tomcatproduction.json ${WORKSPACE}/reports/tomcatproduction.json