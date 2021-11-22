TOMCAT_HOME= attribute(
    'tomcat_home',
    description: 'location of tomcat home directory',
    value: '/usr/local/tomcat'
  )

control "1.1" do
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
  
  extraneous_res =  ["webapps/docs", "webapps/examples", "webapps/host-manager", "webapps/manager"]

    for res in extraneous_res do 
      describe file("#{TOMCAT_HOME}/#{res}") do
        it { should_not exist } 
      end
    end
  end