TOMCAT_HOME= attribute(
    'tomcat_home',
    description: 'location of tomcat home directory',
    value: '/usr/local/tomcat'
  )

TOMCAT_SERVER_INFO= attribute(
    'tomcat_server_info',
    description: 'server.info value',
    value: 'server.info=Apache Tomcat/9.0.38'  
  )
  
  control "2.1" do
    title "2.1 Alter the Advertised server.info String (Scored)"
    desc  "The server.info attribute contains the name of the application
  service. This value is presented to Tomcat clients when clients connect to the
  tomcat server. Altering the server.info attribute may make it harder for
  attackers to determine which vulnerabilities affect the server platform. "
    impact 0.5
    tag "ref": "1. http://www.owasp.org/index.php/Securing_tomcat"
    tag "severity": "medium"
    tag "cis_id": "2.1"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": "Perform the following to determine if the server.info
  value has been changed: Extract the ServerInfo.properties file and examine the
  server.info attribute.
  $ cd $CATALINA_HOME/lib
  $ jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties
  $ grep server.info org/apache/catalina/util/ServerInfo.properties
  "
    tag "fix": "Perform the following to alter the server platform string that
  gets displayed when clients
  connect to the tomcat server. Extract the ServerInfo.properties file from the
  catalina.jar file:
  $ cd $CATALINA_HOME/lib
  $ jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties Navigate
  to the util directory that was created
  cd org/apache/catalina/util Open ServerInfo.properties in an editor Update the
  server.info attribute in the ServerInfo.properties file.
  
  server.info=<SomeWebServer> Update the catalina.jar with the modified
  ServerInfo.properties file.
  $ jar uf catalina.jar org/apache/catalina/util/ServerInfo.properties
  "
    tag "Default Value": "The default value for the server.info attribute is
  Apache Tomcat/.. For example, Apache\nTomcat/7.0.\n"
  
    describe command("jar xf #{TOMCAT_HOME}/lib/catalina.jar org/apache/catalina/util/ServerInfo.properties; 
      grep server.info org/apache/catalina/util/ServerInfo.properties") do
      its('stdout.strip') { should_not eq "#{TOMCAT_SERVER_INFO}" }
    end
  end