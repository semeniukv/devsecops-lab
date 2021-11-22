// -*- coding: utf-8 -*-
//  _   _       _   ____       ____
// | \ | | ___ | |_/ ___|  ___/ ___|  ___  ___ _   _ _ __ ___
// |  \| |/ _ \| __\___ \ / _ \___ \ / _ \/ __| | | | '__/ _ \
// | |\  | (_) | |_ ___) | (_) |__) |  __/ (__| |_| | | |  __/
// |_| \_|\___/ \__|____/ \___/____/ \___|\___|\__,_|_|  \___|
//
// Copyright (C) 2021 NotSoSecure
//
// Email:   contact@notsosecure.com
// Twitter: @notsosecure
//
// This file is part of DevSecOps Training.

pipeline {
   agent any
   environment {
     DOCKER_REGISTRY = "localhost:6000"  // Docker registry
     VAULT_PATH_MYSQL="kv/mysql/db"
     MYSQL_STAGING_URL="stgmysqldb:3306"
     MYSQL_PRODUCTION_URL="prodmysqldb:3306"
     MYSQL_DB_NAME="test"
     MYSQL_DB_PASSWORD="test"
     MYSQL_DB_USER="test"
     MYSQL_DB_ROOT="tooor"
     ARCHERYSEC_HOST ="http://localhost:8000" // ArcherySec URL
     TARGET_URL="http://localhost:8050" //Staging applicaiton URL
     TARGET_IP="http://localhost:8050"
     OPENVAS_HOST="localhost"
     OPENVAS_USER="admin"
     OPENVAS_PASS="admin"
     OPENVAS_PORT="9390"
   }
   stages {
      stage('Build') {
         steps {
            sh '''
               docker images -f dangling=true -q | xargs docker rmi || true
               mvn clean package
               '''
         }
      }
      stage('Archive') {
         steps {
                  sh '''
                        mv ${WORKSPACE}/target/*.war ${WORKSPACE}/target/${GIT_COMMIT}.war
                     '''
         }
      }
      stage('Static Analysis') {
         steps {
          parallel (
            SCA: {
               echo  'Dependency Check'
            },
            SAST: {
                 sh '''
                    semgrep -f $WORKSPACE/scripts/semgrep/ $WORKSPACE/src/ --json | tee $WORKSPACE/reports/semgrep.json
                    '''
                    withCredentials([usernamePassword(credentialsId: 'archerysec', passwordVariable: 'ARCHERY_PASS', usernameVariable: 'ARCHERY_USER')]) {

                     sh '''
                        export COMMIT_ID=`cat .git/HEAD`
                        export SHIGH=3
                        export SMEDIUM=20
                        bash $WORKSPACE/scripts/semgrep/semgrep.sh

                  '''
                }
               }
          )
        }
      }
      stage('Staging Setup') {
         steps {
            parallel(
                  app:  {
                        sh '''

                              mv ${WORKSPACE}/target/${GIT_COMMIT}.war ${WORKSPACE}/target/ROOT.war
                              docker build --no-cache -t "devsecops/app:staging" -f docker/app/Dockerfile .
                              docker tag "devsecops/app:staging" "${DOCKER_REGISTRY}/devsecops/app:staging"
                              docker push "${DOCKER_REGISTRY}/devsecops/app:staging"
                              docker rmi "${DOCKER_REGISTRY}/devsecops/app:staging"

                           '''
                        },
                  db:   { // Parallely start the MySQL Daemon in the staging server first stop if already running then start
                        sh '''
                              docker build --no-cache -t "devsecops/db:staging" -f docker/db/Dockerfile .
                              docker tag "devsecops/db:staging" "${DOCKER_REGISTRY}/devsecops/db:staging"
                              docker push "${DOCKER_REGISTRY}/devsecops/db:staging"
                              docker rmi "${DOCKER_REGISTRY}/devsecops/db:staging" || true
                              docker rmi "devsecops/db:staging" || true

                              docker stop stgmysqldb stgapp || true
                              docker rm stgmysqldb stgapp || true
                              docker rmi ${DOCKER_REGISTRY}/devsecops/app:staging ${DOCKER_REGISTRY}/devsecops/db:staging || true

                              docker run -d -p 3305:3306 \
                              -e MYSQL_DATABASE=${MYSQL_DB_NAME} -e MYSQL_ROOT_PASSWORD=${MYSQL_DB_ROOT} -e MYSQL_USER=${MYSQL_DB_USER} -e MYSQL_PASSWORD=${MYSQL_DB_PASSWORD} \
                              -v /home/vagrant/stgmysql:/var/lib/mysql --name stgmysqldb  ${DOCKER_REGISTRY}/devsecops/db:staging \
                              --table_definition_cache=100 --performance_schema=0 --default-authentication-plugin=mysql_native_password
                           '''
                        }
                     )
               }
      }
      stage('Staging Deploy') {//providing delay for mysql to start
         steps {
            sh '''
		            sleep 15
                docker run -d -p 8050:8080 --link stgmysqldb -e MYSQL_DB_USER=${MYSQL_DB_USER} \
                -e MYSQL_DB_PASSWORD=${MYSQL_DB_PASSWORD} -e MYSQL_JDBC_URL=${MYSQL_STAGING_URL} -e MYSQL_DB_NAME=${MYSQL_DB_NAME} \
                -v /home/vagrant/stglogs:/usr/local/tomcat/logs --name stgapp ${DOCKER_REGISTRY}/devsecops/app:staging
               '''
            // Check and wait until the staging application is up and running
            sh '''
                until [ $(curl --head -s -o /dev/null --fail "http://127.0.0.1:8050/login.action" -w "%{http_code}") -eq 200 ]; do sleep 3; done
                echo "** Staging.local up and running **"
               '''
         }
      }
      stage('Dynamic Analysis') {
         steps{
               parallel(
                  UAT:  {
                     sh '''
                        pip install mechanize
                        export COMMIT_ID=`cat .git/HEAD`
                        sleep 5
                        export job_status=`python ${WORKSPACE}/scripts/uat/uat_testing.py --email ${COMMIT_ID}@eshoppe.com --password test@123 --url http://localhost:8050/view.action | grep SUCCESS`
                        if [ -n "$job_status" ]
                        then
                           # Run your script commands here
                           echo "Build Sucess"
                        else
                           echo "BUILD FAILURE: Other build is unsuccessful or status could not be obtained"
                           exit 100
                        fi
                     '''
                  },
               )
         }
      }
      stage('Production Setup') {
         steps {
            parallel(
                  app:  {
                        sh '''
                              docker build --no-cache -t "devsecops/app:production" -f docker/app/Dockerfile .
                              docker tag "devsecops/app:production" "${DOCKER_REGISTRY}/devsecops/app:production"
                              docker push "${DOCKER_REGISTRY}/devsecops/app:production"
                              docker rmi "${DOCKER_REGISTRY}/devsecops/app:production" || true
                              docker rmi "devsecops/app:production" || true
                           '''
                        },
                  db:   { // Parallely start the MySQL Daemon in the staging server first stop if already running then start
                        sh '''
                              docker build --no-cache -t "devsecops/db:production" -f docker/db/Dockerfile .
                              docker tag "devsecops/db:production" "${DOCKER_REGISTRY}/devsecops/db:production"
                              docker push "${DOCKER_REGISTRY}/devsecops/db:production"
                              docker rmi "${DOCKER_REGISTRY}/devsecops/db:production" || true
                              docker rmi "devsecops/db:production" || true
                           '''
                           withCredentials([string(credentialsId: 'mysqlroot', variable: 'mysqlroot'),
                                          string(credentialsId: 'mysqldbpw', variable: 'mysqldbpw')]){
                            sh '''
                                docker stop prodmysqldb prodapp || true
                                docker rm prodmysqldb prodapp || true
                                docker rmi ${DOCKER_REGISTRY}/devsecops/app:production ${DOCKER_REGISTRY}/devsecops/db:production || true
                                docker run -d -p 3306:3306 \
                                 -e MYSQL_DATABASE=${MYSQL_DB_NAME} -e MYSQL_ROOT_PASSWORD=${mysqlroot} -e MYSQL_USER=${MYSQL_DB_USER} -e MYSQL_PASSWORD=${mysqldbpw} \
                                 -v /home/vagrant/prodmysql:/var/lib/mysql --name prodmysqldb  ${DOCKER_REGISTRY}/devsecops/db:production \
                                 --table_definition_cache=100 --performance_schema=0 --default-authentication-plugin=mysql_native_password
                            '''

                           }
                        }
                     )
               }
      }
      stage ('Production Deploy Approval') {
         steps {
         script {
            input message: 'Do you approve Deployment ?', ok: 'OK'
            }
         }
      }
      stage('Production Deploy') {
         steps {
         withCredentials([string(credentialsId: 'mysqlvault', variable: 'mysqlvault')]){
             sh '''
             export VAULT_ADDR="http://`hostname -I | awk '{print $1}'`:8200"
             docker run -d -p 8060:8080 --link prodmysqldb -e MYSQL_DB_USER=${MYSQL_DB_USER} \
                 -e VAULT_TOKEN_MYSQL=${mysqlvault} -e VAULT_ADDR=${VAULT_ADDR} -e MYSQL_JDBC_URL=${MYSQL_PRODUCTION_URL} \
                 -e MYSQL_DB_NAME=${MYSQL_DB_NAME}  -e VAULT_PATH_MYSQL=${VAULT_PATH_MYSQL} \
                -v /home/vagrant/logs:/usr/local/tomcat/logs --name prodapp ${DOCKER_REGISTRY}/devsecops/app:production
             '''
            }
         }
      }
   }
    post {
    failure {
      script {
        currentBuild.result = 'FAILURE'
      }
    }
    always {
           step([$class: 'Mailer', notifyEveryUnstableBuild: true,recipients: "build-failed@devops.local",sendToIndividuals: true])
           step([$class: 'WsCleanup'])
     }
  }
}