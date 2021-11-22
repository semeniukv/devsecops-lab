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

FROM tomcat:9
ADD ./target/ROOT.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD ["catalina.sh", "run"]