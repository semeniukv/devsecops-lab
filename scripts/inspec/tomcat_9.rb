TOMCAT_HOME= attribute(
    'tomcat_home',
    description: 'location of tomcat home directory',
    value: '/usr/local/tomcat'
  )
  
  TOMCAT_SERVICE_NAME= attribute(
    'tomcat_service_name',
    description: 'Name of Tomcat service',
    value: 'tomcat'
  )
  
  TOMCAT_EXTRANEOUS_RESOURCE_LIST= attribute(
    'tomcat_extraneous_resource_list',
    description: 'List of extraneous resources that should not exist',
    value: ["webapps/docs",
              "webapps/examples",
              "webapps/host-manager",
              "webapps/manager"]
  )
  
  TOMCAT_BASE= attribute(
    'tomcat_base',
    description: 'location of tomcat home directory',
    value: '/usr/local/tomcat'
  )
  
  TOMCAT_GROUP= attribute(
    'tomcat_group',
    description: 'group owner of files/directories',
    value: 'tomcat'
  )
  
  TOMCAT_OWNER= attribute(
    'tomcat_owner',
    description: 'user owner of files/directories',
    value: 'tomcat_admin'
  )
  
  TOMCAT_SERVER_BUILT= attribute(
    'tomcat_server_built',
    description: 'server.built value',
    value: 'server.built=Sep 10 2020 08:20:30 UTC'
  )
  
  TOMCAT_SERVER_INFO= attribute(
    'tomcat_server_info',
    description: 'server.info value',
    value: 'server.info=Apache Tomcat/9.0.38'  
  )
  
  TOMCAT_SERVER_NUMBER= attribute(
    'tomcat_server_number',
    description: 'server.number value',
    value: 'server.number=9.0.38.0'  
  )
    
  TOMCAT_REALMS_LIST= attribute(
    'tomcat_realms_list',
    description: 'A list of Realms that should not be enabled',
    value: ['org.apache.catalina.realm.MemoryRealm',
              'org.apache.catalina.realm.JDBCRealm',
              'org.apache.catalina.realm.UserDatabaseRealm',
              'org.apache.catalina.realm.JAASRealm']
  )
  
  lockoutRealm = "org.apache.catalina.realm.LockOutRealm"
  
  #only_if do
  #  service(TOMCAT_SERVICE_NAME).installed?
  #end
  
  control "M-1.1" do
    title "1.1 Remove extraneous files and directories (Scored)"
    desc  "The installation may provide example applications, documentation, and
  other directories which may not serve a production use. Removing sample
  resources is a defense in depth measure that reduces potential exposures
  introduced by these resources. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "1.1"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": "Perform the following to determine the existence of
  extraneous resources:
  List all files extraneous files. The following should yield no output:
  $ ls -l $CATALINA_HOME/webapps/docs \\
  $CATALINA_HOME/webapps/examples
  "
    tag "fix": "Perform the following to remove extraneous resources:
  The following should yield no output:
  $ rm -rf $CATALINA_HOME/webapps/docs \\
  $CATALINA_HOME/webapps/examples
  If the Manager application is not utilized, also remove the following
  resources:
  $ rm rf $CATALINA_HOME/webapps/host-manager \\
  $CATALINA_HOME/webapps/manager \\
  $CATALINA_HOME/conf/Catalina/localhost/manager.xml
  
  "
    tag "Default Value": "\"docs\", \"examples\", \"manager\" and
  \"host-manager\" are default web applications shipped\nwith Tomcat."
  
    TOMCAT_EXTRANEOUS_RESOURCE_LIST.each do |app|
      describe command("ls -l #{TOMCAT_HOME}/#{app}") do
        its('stdout.strip') { should eq '' }
      end
    end
  end
  
  
  control "M-1.2" do
    title "1.2 Disable Unused Connectors (Not Scored)"
    desc  "The default installation of Tomcat includes connectors with default
  settings. These are traditionally set up for convenience. It is best to remove
  these connectors and enable only what is needed. Improperly configured or
  unnecessarily installed Connectors may lead to a security exposure. "
    impact 0.5
    tag "ref": "1.
  http://tomcat.apache.org/tomcat-8.0-doc/config/http.html#Connector_Comparison"
    tag "severity": "medium"
    tag "cis_id": "1.2"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": "Perform the following to identify configured Connectors:
  Execute the following command to find configured Connectors. Ensure only those
  required
  are present and not commented out:
  $ grep Connector $CATALINA_HOME/conf/server.xml
  "
    tag "fix": "Perform the following to disable unused Connectors: Within
  $CATALINA_HOME/conf/server.xml, remove or comment each unused Connector.
  For example, to disable an instance of the HTTPConnector, remove the following:
  
  <Connector className='org.apache.catalina.connector.http.HttpConnector'
  ...
  connectionTimeout='60000'/>
  "
    tag "Default Value": "$CATALINA_HOME/conf/server.xml, has the following
  connectors defined by default:\nA non-SSL Connector bound to port 8080\nAn AJP
  1.3 Connector bound to port 8009\n\n"
  
  #   @TODO a resource needs to be created to be able to query more than just the
  #   port but also the full connector's information
  #   ports = ["8084", "8009"]
  
  #   tomcat_conf = xml("#{TOMCAT_HOME}/conf/server.xml")
  
  #   iter = 1
  #   if tomcat_conf['Server/Service/Connector/@port'].is_a?(Array)
  #     numConnectors = tomcat_conf['Server/Service/Connector'].count
  #     until iter > numConnectors do
  #        puts("Inside the loop i = #{iter}" )
  #        describe tomcat_conf["Server/Service/Connector[#{iter}]/@port"] do
  #          it { should be_in ports }
  #        end
  #        iter +=1;
  #     end
  #   end
  # end
  
    describe command("sed -n '/Connector/{N;N;N;p}' #{TOMCAT_HOME}/conf/server.xml | grep -c '8084\\|8009'") do
      its('stdout.strip') { should cmp >= 1 }
    end
  end
  
  
  
  
  
  
  
  control "M-2.1" do
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
      its('stdout.strip') { should eq "#{TOMCAT_SERVER_INFO}" }
    end
  end
  
  
  
  
  
  
  control "M-2.2" do
    title "2.2 Alter the Advertised server.number String (Scored)"
    desc  "The server.number attribute represents the specific version of Tomcat
  that is executing. This value is presented to Tomcat clients when connect.
  Advertising a valid server version may provide attackers with information
  useful for locating vulnerabilities that affect the server platform. Altering
  the server version string may make it harder for attackers to determine which
  vulnerabilities affect the server platform. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "2.2"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": "Perform the following to determine if the server.number
  value has been changed: Extract the ServerInfo.properties file and examine the
  server.number attribute.
  $ cd $CATALINA_HOME/lib
  $ jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties
  $ grep server.number org/apache/catalina/util/ServerInfo.properties
  "
    tag "fix": "Perform the following to alter the server version string that
  gets displayed when clients
  connect to the server. Extract the ServerInfo.properties file from the
  catalina.jar file:
  $ cd $CATALINA_HOME/lib
  $ jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties Navigate
  to the util directory that was created
  $ cd org/apache/Catalina/util Open ServerInfo.properties in an editor Update
  the server.number attribute
  server.number=<someversion> Update the catalina.jar with the modified
  ServerInfo.properties file.
  
  $ jar uf catalina.jar org/apache/catalina/util/ServerInfo.properties
  "
    tag "Default Value": "The default value for the server.number attribute is a
  four part version number, such as\n5.5.20.0."
  
    describe command("jar xf #{TOMCAT_HOME}/lib/catalina.jar org/apache/catalina/util/ServerInfo.properties;
    grep server.number org/apache/catalina/util/ServerInfo.properties") do
      its('stdout.strip') { should eq "#{TOMCAT_SERVER_NUMBER}" }
    end
  end
  
  
  
  
  
  
  
  
  control "M-2.3" do
    title "2.3 Alter the Advertised server.built Date (Scored)"
    desc  "The server.built date represents the date which Tomcat was compiled
  and packaged. This value is presented to Tomcat clients when clients connect to
  the server. Altering the server.built string may make it harder for attackers
  to fingerprint which vulnerabilities affect the server platform. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "2.3"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": "Perform the following to determine if the server.built
  value has been changed: Extract the ServerInfo.properties file and examine the
  server.built attribute.
  $ cd $CATALINA_HOME/lib
  $ jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties
  $ grep server.built org/apache/catalina/util/ServerInfo.properties
  "
    tag "fix": "Perform the following to alter the server version string that
  gets displayed when clients
  connect to the server. Extract the ServerInfo.properties file from the
  catalina.jar file:
  $ cd $CATALINA_HOME/lib
  $ jar xf catalina.jar org/apache/catalina/util/ServerInfo.properties Navigate
  to the util directory that was created
  $ cd org/apache/Catalina/util Open ServerInfo.properties in an editor Update
  the server.built attribute in the ServerInfo.properties file.
  server.built= Update the catalina.jar with the modified ServerInfo.properties
  file.
  $ jar uf catalina.jar org/apache/catalina/util/ServerInfo.properties
  
  "
    tag "Default Value": "The default value for the server.built attribute is
  build date and time. For example, Jul 8\n2008 11:40:35."
  
    describe command("jar xf #{TOMCAT_HOME}/lib/catalina.jar org/apache/catalina/util/ServerInfo.properties;
     grep server.built org/apache/catalina/util/ServerInfo.properties") do
      its('stdout.strip') { should eq "#{TOMCAT_SERVER_BUILT}" }
    end
  end
  
  
  
  
  
  
  control "M-2.4" do
    title "2.4 Disable X-Powered-By HTTP Header and Rename the Server Value for
  all Connectors (Scored)"
    desc  "The xpoweredBy setting determines if Apache Tomcat will advertise its
  presence via the XPowered-By HTTP header. It is recommended that this value be
  set to false. The server attribute overrides the default value that is sent
  down in the HTTP header further masking Apache Tomcat. Preventing Tomcat from
  advertising its presence in this manner may make it harder for attackers to
  determine which vulnerabilities affect the server platform. "
    impact 0.5
    tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/config/http.html"
    tag "severity": "medium"
    tag "cis_id": "2.4"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": "Perform the following to determine if the server platform,
  as advertised in the HTTP Server
  header, has been changed: Locate all Connector elements in
  $CATALINA_HOME/conf/server.xml. Ensure each Connector has a server attribute
  and that the server attribute does not
  reflect Apache Tomcat. Also, make sure that the xpoweredBy attribute is NOT set
  to true.
  "
    tag "fix": "Perform the following to prevent Tomcat from advertising its
  presence via the XPoweredBy HTTP header. Add the xpoweredBy attribute to each
  Connector specified in
  $CATALINA_HOME/conf/server.xml. Set the xpoweredBy attributes value to false.
  <Connector
  ...
  xpoweredBy='false' />
  Alternatively, ensure the xpoweredBy attribute for each Connector specified in
  
  $CATALINA_HOME/conf/server.xml is absent.
   Add the server attribute to each Connector specified in
  $CATALINA_HOME/conf/server.xml. Set the server attribute value to anything
  except a
  blank string.
  "
    tag "Default Value": "The default value is false.\n"
  
    tomcat_conf = xml("#{TOMCAT_HOME}/conf/server.xml")
  
    serverIter = 1
    if tomcat_conf['Server/Service/Connector/@server'].is_a?(Array)
      numConnectors = tomcat_conf['Server/Service/Connector'].count
      until serverIter > numConnectors do
         describe tomcat_conf["Server/Service/Connector[#{serverIter}]/@server"] do
           it { should_not eq [] }
           it { should_not cmp 'Apache Tomcat' }
         end
         serverIter +=1
       end
  
       
    end
  
    xpoweredByIter = 1
    if tomcat_conf['Server/Service/Connector/@xpoweredBy'].is_a?(Array) && tomcat_conf['Server/Service/Connector/@xpoweredBy'].any?
      numConnectors = tomcat_conf['Server/Service/Connector'].count
      until xpoweredByIter > numConnectors do
         describe.one do
           describe tomcat_conf["Server/Service/Connector[#{xpoweredByIter}]/@xpoweredBy"] do
             it { should cmp 'false' }
           end
           describe tomcat_conf["Server/Service/Connector[#{xpoweredByIter}]/@xpoweredBy"] do
             it { should cmp [] }
           end
         end
         xpoweredByIter +=1
      end
    end
    if !tomcat_conf['Server/Service/Connector/@xpoweredBy'].any?
      describe tomcat_conf["Server/Service/Connector/@xpoweredBy"] do
        it { should cmp [] }
      end
    end
  end
  
  
  
  
  
  
  control "M-2.5" do
    title "2.5 Disable client facing Stack Traces (Scored)"
    desc  "When a runtime error occurs during request processing, Apache Tomcat
  will display debugging information to the requestor. It is recommended that
  such debug information be withheld from the requestor. Debugging information,
  such as that found in call stacks, often contains sensitive information that
  may useful to an attacker. By preventing Tomcat from providing this
  information, the risk of leaking sensitive information to a potential attacker
  is reduced. "
    impact 0.5
    tag "ref": "1.
  https://tomcat.apache.org/tomcat-8.0doc/api/org/apache/tomcat/util/descriptor/web/ErrorPage.html"
    tag "severity": "medium"
    tag "cis_id": "2.5"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if Tomcat is configured
  to prevent sending debug
  information to the requestor Ensure an <error-page> element is defined in$
  CATALINA_HOME/conf/web.xml. Ensure the <error-page> element has an
  <exception-type> child element with a
  value of java.lang.Throwable. Ensure the <error-page> element has a <location>
  child element.
  Note: Perform the above for each application hosted within Tomcat. Per
  application
  instances of web.xml can be found at
  $CATALINA_HOME/webapps/<APP_NAME>/WEBINF/web.xml
  "
    tag "fix": "Perform the following to prevent Tomcat from providing debug
  information to the
  requestor during runtime errors: Create a web page that contains the logic or
  message you wish to invoke when
  encountering a runtime error. For example purposes, assume this page is located
  at
  /error.jsp. Add a child element, <error-page>, to the <web-app>element, in the
  
  $CATALINA_HOME/conf/web.xml file. Add a child element, <exception-type>, to the
  <error-page> element. Set the value of
  the <exception-type> element to java.lang.Throwable.
   Add a child element, <location>, to the <error-page> element. Set the value of
  the
  <location> element to the location of page created in #1.
  The resulting entry will look as follows:
  <error-page>
  <exception-type>java.lang.Throwable</exception-type>
  <location>/error.jsp</location>
  </error-page>
  "
    tag "Default Value": "Tomcats default configuration does not include an
  <error-page> element in\n$CATALINA_HOME/conf/web.xml. Therefore, Tomcat will
  provide debug information to\nthe requestor by default.\n"
  
    # Query the main web.xml
    web_conf = xml("#{TOMCAT_HOME}/conf/web.xml")
    errorIter = 1
    if web_conf['web-app/error-page'].is_a?(Array)
      numConnectors = web_conf['web-app/error-page'].count
      until errorIter > numConnectors  do
         describe web_conf["web-app/error-page[#{errorIter}]"] do
           it { should_not eq [] }
         end
         describe web_conf["web-app/error-page[#{errorIter}]/exception-type"] do
           it { should cmp "java.lang.Throwable"}
         end
         describe web_conf["web-app/error-page[#{errorIter}]/location"] do
           it { should_not eq [] }
         end
         errorIter +=1
       end
      if !web_conf['web-app/error-page'].any?
       describe web_conf["web-app/error-page"] do
         it { should_not eq [] }
       end
     end
    end
  
    # Query the web.xml for each webapp
    command("find #{TOMCAT_HOME}/webapps/ ! -path #{TOMCAT_HOME}/webapps/ -type d -maxdepth 1").stdout.split.each do |webappname|
      webapp_conf = xml("#{webappname}/WEB-INF/web.xml")
      webAppIter = 1
      if webapp_conf['web-app/error-page'].is_a?(Array)
        numConnectors = webapp_conf['web-app/error-page'].count
        until webAppIter > numConnectors  do
           describe webapp_conf["web-app/error-page[#{webAppIter}]"] do
             it { should_not eq [] }
           end
           describe webapp_conf["web-app/error-page[#{webAppIter}]/exception-type"] do
             it { should cmp "java.lang.Throwable"}
           end
           describe webapp_conf["web-app/error-page[#{webAppIter}]/location"] do
             it { should_not eq [] }
           end
           webAppIter +=1
         end
        if !webapp_conf['web-app/error-page'].any?
         describe webapp_conf["web-app/error-page"] do
           it { should_not eq [] }
         end
       end
      end
    end
  end
  
  
  
  
  
  
  control "M-2.6" do
    title "2.6 Turn off TRACE (Scored)"
    desc  "The HTTP TRACE verb provides debugging and diagnostics information for
  a given request. Diagnostic information, such as that found in the response to
  a TRACE request, often contains sensitive information that may useful to an
  attacker. By preventing Tomcat from providing this information, the risk of
  leaking sensitive information to a potential attacker is reduced. "
    impact 0.5
    tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/config/http.html"
    tag "severity": "medium"
    tag "cis_id": "2.6"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the server platform,
  as advertised in the HTTP Server
  header, has been changed: Locate all Connector elements in
  $CATALINA_HOME/conf/server.xml. Ensure each Connector does not have a
  allowTrace attribute or if the allowTrace
  attribute is not set true.
  Note: Perform the above for each application hosted within Tomcat. Per
  application
  instances of web.xml can be found at
  $CATALINA_HOME/webapps/<APP_NAME>/WEBINF/web.xml
  "
    tag "fix": "Perform the following to prevent Tomcat from accepting a TRACE
  request: Set the allowTrace attributes to each Connector specified in
  $CATALINA_HOME/conf/server.xml to false.
  <Connector ... allowTrace='false' />
  Alternatively, ensure the allowTrace attribute for each Connector specified in
  
  $CATALINA_HOME/conf/server.xml is absent.
  
  "
    tag "Default Value": "Tomcat does not allow the TRACE HTTP verb by default.
  Tomcat will only allow TRACE if\nthe allowTrace attribute is present and set to
  true.\n"
  
    allowTraceIter = 1
    tomcat_conf = xml("#{TOMCAT_HOME}/conf/server.xml")
    if tomcat_conf['Server/Service/Connector/@allowTrace'].is_a?(Array) && tomcat_conf['Server/Service/Connector/@allowTrace'].any?
      numConnectors = tomcat_conf['Server/Service/Connector'].count
      until allowTraceIter > numConnectors do
         describe.one do
           describe tomcat_conf["Server/Service/Connector[#{allowTraceIter}]/@allowTrace"] do
             it { should cmp 'false' }
           end
           describe tomcat_conf["Server/Service/Connector[#{allowTraceIter}]/@allowTrace"] do
             it { should cmp [] }
           end
         end
         allowTraceIter +=1
      end
    end
  
    if !tomcat_conf['Server/Service/Connector/@allowTrace'].any?
      describe tomcat_conf['Server/Service/Connector/@allowTrace'] do
        it { should cmp [] }
      end
    end
  end
  
  
  control "M-3.1" do
    title "3.1 Set a nondeterministic Shutdown command value (Scored)"
    desc  "Tomcat listens on TCP port 8005 to accept shutdown requests. By
  connecting to this port and sending the SHUTDOWN command, all applications
  within Tomcat are halted. The shutdown port is not exposed to the network as it
  is bound to the loopback interface. It is recommended that a nondeterministic
  value be set for the shutdown attribute in $CATALINA_HOME/conf/server.xml.
  Setting the shutdown attribute to a nondeterministic value will prevent
  malicious local users from shutting down Tomcat. "
    impact 0.5
    tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/config/server.html"
    tag "severity": "medium"
    tag "cis_id": "3.1"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the shutdown port is
  configured to use the default
  shutdown command: Ensure the shutdown attribute in
  $CATALINA_HOME/conf/server.xml is not set to
  SHUTDOWN.
  $ cd $CATALINA_HOME/conf
  $ grep ‘shutdown[[:space:]]*=[[:space:]]*”SHUTDOWN‟’ server.xml
  "
    tag "fix": "Perform the following to set a nondeterministic value for the
  shutdown attribute. Update the shutdown attribute in
  $CATALINA_HOME/conf/server.xml as follows:
  <Server port='8005' shutdown='NONDETERMINISTICVALUE'>
  Note: NONDETERMINISTICVALUE should be replaced with a sequence of random
  characters.
  "
    tag "Default Value": "The default value for the shutdown attribute is
  SHUTDOWN.\n"
  
    describe xml("#{TOMCAT_HOME}/conf/server.xml") do
      its('Server/@shutdown') { should_not cmp 'SHUTDOWN' }
    end
  end
  
  
  
  
  
  
  
  control "M-4.1" do
    title "4.1 Restrict access to $CATALINA_HOME (Scored)"
    desc  "$CATALINA_HOME is the environment variable which holds the path to the
  root Tomcat directory. It is important to protect access to this in order to
  protect the Tomcat binaries and libraries from unauthorized modification. It is
  recommended that the ownership of $CATALINA_HOME be tomcat_admin:tomcat. It is
  also recommended that the permission on $CATALINA_HOME prevent read, write, and
  execute for the world (o-rwx) and prevent write access to the group (g-w). The
  security of processes and data that traverse or depend on Tomcat may become
  compromised if the $CATALINA_HOME is not secured. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.1"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to ensure the permission on the
  $CATALINA_HOME directory
  prevent unauthorized modification.
  $ cd $CATALINA_HOME
  $ find . -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin -o !
  -group
  tomcat \\) -ls
  The above command should not emit any output.
  "
    tag "fix": "Perform the following to establish the recommended state: Set the
  ownership of the $CATALINA_HOME to tomcat_admin:tomcat. Remove read, write, and
  execute permissions for the world Remove write permissions for the group.
  
  # chown tomcat_admin.tomcat $CATALINA_HOME
  # chmod g-w,o-rwx $CATALINA_HOME"
  
    describe directory("#{TOMCAT_HOME}") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
  
  
  
  control "M-4.2" do
    title "4.2 Restrict access to $CATALINA_BASE (Scored)"
    desc  "$CATALINA_BASE is the environment variable that specifies the base
  directory which most relative paths are resolved. $CATALINA_BASE is usually
  used when there is multiple instances of Tomcat running. It is important to
  protect access to this in order to protect the Tomcat-related binaries and
  libraries from unauthorized modification. It is recommended that the ownership
  of $CATALINA_BASE be tomcat_admin:tomcat. It is also recommended that the
  permission on $CATALINA_BASE prevent read, write, and execute for the world
  (orwx) and prevent write access to the group (g-w). The security of processes
  and data that traverse or depend on Tomcat may become compromised if the
  $CATALINA_BASE is not secured. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.2"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to ensure the permission on the
  $CATALINA_BASE directory prevent
  unauthorized modification.
  $ cd $CATALINA_BASE
  $ find . -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin -o !
  -group
  tomcat \\) -ls
  The above command should not emit any output.
  "
    tag "fix": "Perform the following to establish the recommended state: Set the
  ownership of the $CATALINA_BASE to tomcat_admin:tomcat. Remove read, write, and
  execute permissions for the world Remove write permissions for the group.
  # chown tomcat_admin.tomcat $CATALINA_BASE
  # chmod g-w,o-rwx $CATALINA_BASE"
  
    # describe directory("#{TOMCAT_BASE}") do
    #   its('owner') { should eq "#{TOMCAT_OWNER}" }
    #   its('group') { should eq "#{TOMCAT_GROUP}" }
    #   its('mode') { should cmp '0750' }
    # end
   
    if (File.directory?("#{TOMCAT_BASE}"))
        describe directory("#{TOMCAT_BASE}") do
        its('owner') { should eq "#{TOMCAT_OWNER}" }
        its('group') { should eq "#{TOMCAT_GROUP}" }
        its('mode') { should cmp '0750' }
        end
    else
        puts "#{TOMCAT_BASE}" + ' Doesnt exist'
    end
  end
  
  
    
  
  control "M-4.3" do
    title "4.3 Restrict access to Tomcat configuration directory (Scored)"
    desc  "The Tomcat $CATALINA_HOME/conf/ directory contains Tomcat
  configuration files. It is recommended that the ownership of this directory be
  tomcat_admin:tomcat. It is also recommended that the permissions on this
  directory prevent read, write, and execute for the world (o-rwx) and prevent
  write access to the group (g-w). Restricting access to these directories will
  prevent local users from maliciously or inadvertently altering Tomcats
  configuration. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.3"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/conf are securely configured. Change to the location of the
  $CATALINA_HOME/conf and execute the following:
  # cd $CATALINA_HOME/conf
  # find . -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin -o ! -group
  tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to Tomcat configuration
  files: Set the ownership of the $CATALINA_HOME/conf to tomcat_admin:tomcat.
  Remove read, write, and execute permissions for the world Remove write
  permissions for the group.
  # chown tomcat_admin:tomcat $CATALINA_HOME/conf
  # chmod g-w,o-rwx $CATALINA_HOME/conf
  
  "
    tag "Default Value": "The default permissions of the top-level directories is
  770."
  
    describe directory("#{TOMCAT_HOME}/conf") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
   
  
  
  
  
  
  control "M-4.4" do
    title "4.4 Restrict access to Tomcat logs directory (Scored)"
    desc  "The Tomcat $CATALINA_HOME/logs/ directory contains Tomcat logs. It is
  recommended that the ownership of this directory be tomcat_admin:tomcat. It is
  also recommended that the permissions on this directory prevent read, write,
  and execute for the world (o-rwx). Restricting access to these directories will
  prevent local users from maliciously or inadvertently altering Tomcats logs. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.4"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/logs are securely configured. Change to the location of the
  $CATALINA_HOME/logs and execute the following:
  # cd $CATALINA_HOME
  # find logs -follow -maxdepth 0 \\( -perm /o+rwx -o ! -user tomcat_admin -o !
  group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to Tomcat log files: Set
  the ownership of the $CATALINA_HOME/logs to tomcat_admin:tomcat. Remove read,
  write, and execute permissions for the world
  # chown tomcat_admin:tomcat $CATALINA_HOME/logs
  # chmod o-rwx $CATALINA_HOME/logs
  "
    tag "Default Value": "The default permissions of the top-level directories is
  770."
  
    describe directory("#{TOMCAT_HOME}/logs") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0770' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.5" do
    title "4.5 Restrict access to Tomcat temp directory (Scored)"
    desc  "The Tomcat $CATALINA_HOME/temp/ directory is used by Tomcat to persist
  temporary information to disk. It is recommended that the ownership of this
  directory be tomcat_admin:tomcat. It is also recommended that the permissions
  on this directory prevent read, write, and execute for the world (o-rwx).
  Restricting access to these directories will prevent local users from
  maliciously or inadvertently affecting the integrity of Tomcat processes. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.5"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/temp are securely configured. Change to the location of the
  $CATALINA_HOME/temp and execute the following:
  # cd $CATALINA_HOME
  # find temp -follow -maxdepth 0 \\( -perm /o+rwx -o ! -user tomcat_admin -o !
  group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to Tomcat temp
  directory: Set the ownership of the $CATALINA_HOME/temp to tomcat_admin:tomcat.
  Remove read, write, and execute permissions for the world
  # chown tomcat_admin:tomcat $CATALINA_HOME/temp
  # chmod o-rwx $CATALINA_HOME/temp
  "
    tag "Default Value": "The default permissions of the top-level directories is
  770."
  
    describe directory("#{TOMCAT_HOME}/temp") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0770' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.6" do
    title "4.6 Restrict access to Tomcat binaries directory (Scored)"
    desc  "The Tomcat $CATALINA_HOME/bin/ directory contains executes that are
  part of the Tomcat run-time. It is recommended that the ownership of this
  directory be tomcat_admin:tomcat. It is also recommended that the permission on
  $CATALINA_HOME prevent read, write, and execute for the world (o-rwx) and
  prevent write access to the group (g-w). Restricting access to these
  directories will prevent local users from maliciously or inadvertently
  affecting the integrity of Tomcat processes. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.6"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/bin are securely configured. Change to the location of the
  $CATALINA_HOME/bin and execute the following:
  # cd $CATALINA_HOME
  # find bin -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin -o
  ! -group
  tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed
  when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to Tomcat bin directory:
  Set the ownership of the $CATALINA_HOME/bin to tomcat_admin:tomcat. Remove
  read, write, and execute permissions for the world
  # chown tomcat_admin:tomcat $CATALINA_HOME/bin
  # chmod g-w,o-rwx $CATALINA_HOME/bin
  "
    tag "Default Value": "The default permissions of the top-level directories is
  770."
  
    describe directory("#{TOMCAT_HOME}/bin") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.7" do
    title "4.7 Restrict access to Tomcat web application directory (Scored)"
    desc  "The Tomcat $CATALINA_HOME/webapps directory contains web applications
  that are deployed through Tomcat. It is recommended that the ownership of this
  directory be tomcat_admin:tomcat. It is also recommended that the permission on
  $CATALINA_HOME/webapps prevent read, write, and execute for the world (o-rwx)
  and prevent write access to the group (g-w). Restricting access to these
  directories will prevent local users from maliciously or inadvertently
  affecting the integrity of web applications. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.7"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/webapps are securely configured. Change to the location of the
  $CATALINA_HOME/webapps and execute the
  following:
  # cd $CATALINA_HOME
  # find webapps -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin
  
  -o ! -group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to Tomcat webapps
  directory: Set the ownership of the $CATALINA_HOME/webapps to
  tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
  
  # chown tomcat_admin:tomcat $CATALINA_HOME/webapps
  # chmod g-w,o-rwx $CATALINA_HOME/webapps
  
  "
    tag "Default Value": "The default permissions of the top-level directories is
  770."
  
    describe directory("#{TOMCAT_HOME}/webapps") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.8" do
    title "4.8 Restrict access to Tomcat catalina.policy (Scored)"
    desc  "The catalina.policy file is used to configure security policies for
  Tomcat. It is recommended that access to this file has the proper permissions
  to properly protect from unauthorized changes. Restricting access to this file
  will prevent local users from maliciously or inadvertently altering Tomcats
  security policy. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.8"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/conf/catalina.policy care securely configured. Change to the
  location of the $CATALINA_HOME/ and execute the following:
  # cd $CATALINA_HOME/conf/
  # find catalina.policy -follow -maxdepth 0 \\( -perm /o+rwx -o ! -user
  tomcat_admin -o ! -group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to
  $CATALINA_HOME/conf/catalina.policy. Set the owner and group owner of the
  contents of
  $CATALINA_HOME/conf/catalina.policy to tomcat_admin and tomcat, respectively.
  # chmod 770 $CATALINA_HOME/conf/catalina.policy
  # chown tomcat_admin:tomcat $CATALINA_HOME/conf/catalina.policy
  "
    tag "Default Value": "The default permissions of catalina.policy is 600."
  
    describe file("#{TOMCAT_HOME}/conf/catalina.policy") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0770' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.9" do
    title "4.9 Restrict access to Tomcat catalina.properties (Scored)"
    desc  "catalina.properties is a Java properties files that contains settings
  for Tomcat including class loader information, security package lists, and
  performance properties. It is recommended that access to this file has the
  proper permissions to properly protect from unauthorized changes. Restricting
  access to this file will prevent local users from maliciously or inadvertently
  altering Tomcats security policy. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.9"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/conf/catalina.properties care securely configured. Change to the
  location of the $CATALINA_HOME/ and execute the following:
  # cd $CATALINA_HOME/conf/
  # find catalina.properties -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user
  
  tomcat_admin -o ! -group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to catalina.properties:
  Set the ownership of the $CATALINA_HOME/conf/catalina.properties to
  tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
  Remove write permissions for the group.
  # chown tomcat_admin:tomcat $CATALINA_HOME/conf/catalina.properties
  # chmod g-w,o-rwx $CATALINA_HOME/conf/catalina.properties
  
  "
    tag "Default Value": "The default permissions of the top-level directories is
  600."
  
    describe file("#{TOMCAT_HOME}/conf/catalina.properties") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.10" do
    title "4.10 Restrict access to Tomcat context.xml (Scored)"
    desc  "The context.xml file is loaded by all web applications and sets
  certain configuration options. It is recommended that access to this file has
  the proper permissions to properly protect from unauthorized changes.
  Restricting access to this file will prevent local users from maliciously or
  inadvertently altering Tomcats security policy. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.10"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/conf/context.xml care securely configured. Change to the
  location of the $CATALINA_HOME/conf and execute the following:
  # cd $CATALINA_HOME/conf
  # find context.xml -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user
  tomcat_admin -o ! -group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to context.xml: Set the
  ownership of the $CATALINA_HOME/conf/context.xml to
  tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
  Remove write permissions for the group.
  # chown tomcat_admin:tomcat $CATALINA_HOME/conf/context.xml
  # chmod g-w,o-rwx $CATALINA_HOME/conf/context.xml
  
  "
    tag "Default Value": "The default permissions of context.xml are 600."
  
    describe file("#{TOMCAT_HOME}/conf/context.xml") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.11" do
    title "4.11 Restrict access to Tomcat logging.properties (Scored)"
    desc  "logging.properties is a Tomcat files which specifies the logging
  configuration. It is recommended that access to this file has the proper
  permissions to properly protect from unauthorized changes. Restricting access
  to this file will prevent local users from maliciously or inadvertently
  altering Tomcats security policy. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.11"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/conf/logging.properties care securely configured. Change to the
  location of the $CATALINA_HOME/conf and execute the following:
  # cd $CATALINA_HOME/conf/
  # find logging.properties -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user
  tomcat_admin -o ! -group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to logging.properties:
  Set the ownership of the $CATALINA_HOME/conf/logging.properties to
  tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
  Remove write permissions for the group.
  # chown tomcat_admin:tomcat $CATALINA_HOME/conf/logging.properties
  # chmod g-w,o-rwx $CATALINA_HOME/conf/logging.properties
  
  "
    tag "Default Value": "The default permissions are 600."
  
    describe file("#{TOMCAT_HOME}/conf/logging.properties") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.12" do
    title "4.12 Restrict access to Tomcat server.xml (Scored)"
    desc  "server.xml contains Tomcat servlet definitions and configurations. It
  is recommended that access to this file has the proper permissions to properly
  protect from unauthorized changes. Restricting access to this file will prevent
  local users from maliciously or inadvertently altering Tomcats security
  policy. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.12"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/conf/server.xml care securely configured. Change to the location
  of the $CATALINA_HOME/conf and execute the following:
  # cd $CATALINA_HOME/conf/
  # find server.xml -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user
  tomcat_admin -o ! -group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to server.xml: Set the
  ownership of the $CATALINA_HOME/conf/server.xml to
  tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
  Remove write permissions for the group.
  # chown tomcat_admin:tomcat $CATALINA_HOME/conf/server.xml
  # chmod g-w,o-rwx $CATALINA_HOME/conf/server.xml
  
  "
    tag "Default Value": "The default permissions of the top-level directories is
  600."
  
    describe file("#{TOMCAT_HOME}/conf/server.xml") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
  
  
  
  
  
  
  
  
  control "M-4.13" do
    title "4.13 Restrict access to Tomcat tomcat-users.xml (Scored)"
    desc  "tomcat-users.xml contains authentication information for Tomcat
  applications. It is recommended that access to this file has the proper
  permissions to properly protect from unauthorized changes. Restricting access
  to this file will prevent local users from maliciously or inadvertently
  altering Tomcats security policy. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.13"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/conf/tomcat-users.xml care securely configured. Change to the
  location of the $CATALINA_HOME/conf and execute the following:
  # cd $CATALINA_HOME/conf/
  # find tomcat-users.xml -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user
  tomcat_admin -o ! -group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to tomcat-users.xml: Set
  the ownership of the $CATALINA_HOME/conf/tomcat-users.xml to
  tomcat_admin:tomcat. Remove read, write, and execute permissions for the world.
  Remove write permissions for the group.
  # chown tomcat_admin:tomcat $CATALINA_HOME/conf/tomcat-users.xml
  # chmod g-w,o-rwx $CATALINA_HOME/conf/tomcat-users.xml
  
  "
    tag "Default Value": "The default permissions of the top-level directories is
  600."
  
    describe file("#{TOMCAT_HOME}/conf/tomcat-users.xml") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end
  
  
  
  
  control "M-4.14" do
    title "4.14 Restrict access to Tomcat web.xml (Scored)"
    desc  "web.xml is a Tomcat configuration file that stores application
  configuration settings. It is recommended that access to this file has the
  proper permissions to properly protect from unauthorized changes. Restricting
  access to this file will prevent local users from maliciously or inadvertently
  altering Tomcats security policy. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.14"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and
  permissions on
  $CATALINA_HOME/conf/web.xml care securely configured. Change to the location of
  the $CATALINA_HOME/conf and execute the following:
  # cd $CATALINA_HOME/conf/
  # find web.xml -follow -maxdepth 0 \\( -perm /o+rwx,g=w -o ! -user tomcat_admin
  
  -o ! -group tomcat \\) -ls
  Note: If the ownership and permission are set correctly, no output should be
  displayed when executing the above command.
  "
    tag "fix": "Perform the following to restrict access to web.xml: Set the
  ownership of the $CATALINA_HOME/conf/web.xml to tomcat_admin:tomcat. Remove
  read, write, and execute permissions for the world. Remove write permissions
  for the group.
  # chown tomcat_admin:tomcat $CATALINA_HOME/conf/web.xml
  # chmod g-w,o-rwx $CATALINA_HOME/conf/web.xml
  "
    tag "Default Value": "The default permissions of web.xml is 400."
  
    describe file("#{TOMCAT_HOME}/conf/web.xml") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0750' }
    end
  end




  control "M-5.1" do
    title "5.1 Use secure Realms (Scored)"
    desc  "A realm is a database of usernames and passwords used to identify
  valid users of web applications. Review the Realms configuration to ensure
  Tomcat is configured to use JDBCRealm, UserDatabaseRealm, or JAASRealm.
  Specifically, Tomcat should not utilize MemoryRealm. According to the Tomcat
  documentation, MemoryRealm, JDBCRealm are not designed for production usage and
  could result in reduced availability, the UserDatabaseRealm is not intended for
  large-scale installations, the JAASRealm is not widely used and therefore the
  code is not as mature as the other realms. "
    impact 0.5
    tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/realm-howto.html 2.
  https://tomcat.apache.org/tomcat-8.0-doc/security-howto.html"
    tag "severity": "medium"
    tag "cis_id": "5.1"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": " -"
    tag "fix": "Set the Realm className setting in $CATALINA_HOME/conf/server.xml
  to one of the
  appropriate realms.
  "
  
    describe xml("#{TOMCAT_HOME}/conf/server.xml") do
      its('Server/Service/Engine/Realm/@className') { should_not be_in TOMCAT_REALMS_LIST }
  
      its('Server/Service/Engine/Realm/Realm/@className') { should_not be_in TOMCAT_REALMS_LIST }
  
      its('Server/Service/Host/Realm/@className') { should_not be_in TOMCAT_REALMS_LIST }
  
      its('Server/Service/Host/Realm/Realm/@className') { should_not be_in TOMCAT_REALMS_LIST }
  
      its('Server/Service/Context/Realm/@className') { should_not be_in TOMCAT_REALMS_LIST }
  
      its('Server/Service/Context/Realm/Realm/@className') { should_not be_in TOMCAT_REALMS_LIST }
    end
  
    describe xml("#{TOMCAT_HOME}/conf/context.xml") do
      its('Context/Realm/@className') { should_not be_in TOMCAT_REALMS_LIST }
  
      its('Context/Realm/Realm/@className') { should_not be_in TOMCAT_REALMS_LIST }
    end
  end  




  control "M-5.2" do
    title "5.2 Use LockOut Realms (Scored)"
    desc  "A LockOut realm wraps around standard realms adding the ability to
  lock a user out after multiple failed logins. Locking out a user after multiple
  failed logins slows down attackers from brute forcing logins. "
    impact 0.5
    tag "ref": "1. http://tomcat.apache.org/tomcat-8.0-doc/realm-howto.html 2.
  http://tomcat.apache.org/tomcat-8.0-doc/config/realm.html"
    tag "severity": "medium"
    tag "cis_id": "5.2"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 2
    tag "audit text": "Perform the following to check to see if a LockOut realm
  is being used:
  # grep 'LockOutRealm' $CATALINA_HOME/conf/server.xml
  "
    tag "fix": "Create a lockout realm wrapping the main realm like the example
  below:
  <Realm className='org.apache.catalina.realm.LockOutRealm'
  failureCount='3' lockOutTime='600' cacheSize='1000'
  cacheRemovalWarningTime='3600'>
  <Realm
  className='org.apache.catalina.realm.DataSourceRealm'
  dataSourceName=... />
  </Realm>
  "
  
 
    describe.one do
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Engine/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Engine/Realm/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Host/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Host/Realm/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Context/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/server.xml") do
        its('Server/Service/Context/Realm/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/context.xml") do
        its('Context/Realm/@className') { should cmp lockoutRealm }
      end
      describe xml("#{TOMCAT_HOME}/conf/context.xml") do
        its('Context/Realm/Realm/@className') { should cmp lockoutRealm }
      end
    end
  end



  
