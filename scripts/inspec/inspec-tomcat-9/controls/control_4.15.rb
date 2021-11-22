   TOMCAT_HOME= attribute(
    'tomcat_home',
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
    value: 'tomcat'
  )

  control "4.15" do
    title "4.15 Restrict access to jaspic-providers.xml (Scored)"
    desc  "Tomcat implements JASPIC 1.1 Maintenance Release B (JSR 196). The implementation is
primarily intended to enable the integration of 3rd party JASPIC authentication
implementations with Tomcat.
JASPIC may be configured dynamically by an application or statically via the
$CATALINA_BASE/conf/jaspic-providers.xml configuration file. It is recommended that
access to this file properly protect from unauthorized changes. "
    impact 0.5
    tag "severity": "medium"
    tag "cis_id": "4.15"
    tag "cis_control": ["No CIS Control", "6.1"]
    tag "cis_level": 1
    tag "audit text": "Perform the following to determine if the ownership and permissions on
$CATALINA_HOME/conf/jaspic-providers.xml are securely configured.
# cd $CATALINA_HOME/conf/
# find jaspic-providers.xml -follow -maxdepth 0 \( -perm /o+rwx,g+rwx,u+x -o
! -user tomcat_admin -o ! -group tomcat \) -ls
The above command should not produce any output."
    tag "fix": "Perform the following to restrict access to $CATALINA_HOME/conf/jaspic-providers.xml.
1. Set the ownership of the $CATALINA_HOME/conf/jaspic-providers.xml file to
tomcat_admin:tomcat.
# chown tomcat_admin:tomcat $CATALINA_HOME/conf/jaspic-providers.xml
2. Set the permissions for the $CATALINA_HOME/conf/jaspic-providers.xml file to
600.
# chmod 600 $CATALINA_HOME/conf/jaspic-providers.xml"
    tag "Default Value": "The default permissions of jaspic-providers.xml are 600."
  
    describe file("#{TOMCAT_HOME}/conf/jaspic-providers.xml") do
      its('owner') { should eq "#{TOMCAT_OWNER}" }
      its('group') { should eq "#{TOMCAT_GROUP}" }
      its('mode') { should cmp '0600' }
    end
  end
  