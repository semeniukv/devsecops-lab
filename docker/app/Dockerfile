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
FROM tomcat:9.0-jdk11-openjdk-slim
#Commands that need to be fired using root
RUN rm -rf /usr/local/tomcat/webapps/ROOT /usr/local/tomcat/webapps/host-manager /usr/local/tomcat/webapps/examples /usr/local/tomcat/webapps/manager /usr/local/tomcat/webapps/docs
RUN addgroup tomcat
RUN useradd -ms /bin/bash tomcat -g tomcat
RUN chown -R tomcat:tomcat /usr/local/tomcat
#Commands that need to be fired using tomcat
USER tomcat
ADD ./target/ROOT.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]