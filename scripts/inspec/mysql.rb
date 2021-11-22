mysql_hardening_file = '/etc/mysql/conf.d/hardening.cnf'

# set OS-dependent filenames and paths
case os[:family]
when 'ubuntu', 'debian'
  mysql_config_path = '/etc/mysql/'
  mysql_config_file = mysql_config_path + 'my.cnf'
  mysql_data_path = '/var/lib/mysql/'
  mysql_log_path = '/var/log/'
  mysql_log_file = 'mysql.log'
  mysql_log_group = 'adm'
  service_name = 'mysql'
when 'redhat', 'fedora'
  mysql_config_path = '/etc/'
  mysql_config_file = mysql_config_path + 'my.cnf'
  mysql_data_path = '/var/lib/mysql/'
  mysql_log_path = '/var/log/'
  mysql_log_file = 'mysqld.log'
  mysql_log_group = 'mysql'
  service_name = 'mysqld'
  service_name = 'mariadb' if os[:release] >= '7'
end

control 'mysql-conf-01' do
  impact 0.5
  title 'ensure the service is enabled and running'
  describe service(service_name) do
    it { should be_enabled }
    it { should be_running }
  end
end

# 'Check for multiple instances' do
control 'mysql-conf-02' do
  impact 0.5
  title 'only one instance of mysql should run on a server'
  describe command('ps aux | grep mysqld | egrep -v "grep|mysqld_safe|logger" | wc -l') do
    its(:stdout) { should match(/^1$/) }
  end
end

# Parsing configfiles for unwanted entries
control 'mysql-conf-03' do
  impact 0.7
  title 'enable secure configurations for mysql'
  describe mysql_conf.params('mysqld') do
    its('safe-user-create') { should cmp 1 }
    its('old_passwords') { should_not cmp 1 }
    its('secure-auth') { should cmp 1 }
    its('user') { should cmp 'mysql' }
    its('skip-symbolic-links') { should cmp 1 }
    its('secure-file-priv') { should_not eq nil }
    its('local-infile') { should cmp 0 }
    its('skip-show-database') { should eq '' }
    its('skip-grant-tables') { should eq nil }
    its('allow-suspicious-udfs') { should cmp 0 }
  end
end

# 'Mysql-config: owner, group and permissions'
control 'mysql-conf-04' do
  impact 0.7
  title 'ensure the mysql data path is owned by mysql user'
  describe file(mysql_data_path) do
    it { should be_directory }
    it { should be_owned_by 'mysql' }
    it { should be_grouped_into 'mysql' }
  end
end

control 'mysql-conf-05' do
  impact 0.5
  title 'ensure data path is owned by mysql user'
  describe file("#{mysql_data_path}/ibdata1") do
    it { should be_owned_by 'mysql' }
    it { should be_grouped_into 'mysql' }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should_not be_executable.by('others') }
  end
end

control 'mysql-conf-06' do
  impact 0.5
  title 'ensure log file is owned by mysql user'
  describe file("#{mysql_log_path}/#{mysql_log_file}") do
    it { should be_owned_by 'mysql' }
    it { should be_grouped_into mysql_log_group }
    it { should_not be_readable.by('others') }
    it { should_not be_writable.by('others') }
    it { should_not be_executable.by('others') }
  end
end

control 'mysql-conf-07' do
  impact 0.7
  title 'ensure the mysql config file is owned by root'
  describe file(mysql_config_file) do
    it { should be_file }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_readable.by('others') }
  end
end

# test this only if we have a mysql_hardening_file
control 'mysql-conf-08' do
  impact 0.5
  title 'ensure the mysql hardening config file is owned by root'
  describe file(mysql_hardening_file) do
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should_not be_readable.by('others') }
  end
  only_if { command("ls #{mysql_hardening_file}").exit_status.zero? }
end

# 'Mysql environment'
control 'mysql-conf-09' do
  impact 1.0
  title 'the use of MYSQL_PWD is insecure and can exploit the password'
  describe command('env') do
    its(:stdout) { should_not match(/^MYSQL_PWD=/) }
  end
end

user = attribute('User', description: 'MySQL database user', default: 'root', required: true)
pass = attribute('Password', description: 'MySQL database password', default: 'iloverandompasswordsbutthiswilldo', required: true)

control 'mysql-db-01' do
  impact 0.3
  title 'use supported mysql version in production'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select version();' | tail -1") do
    its(:stdout) { should_not match(/Community/) }
  end
end

control 'mysql-db-02' do
  impact 0.5
  title 'use mysql version 5 or higher'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select substring_index(version(),\".\",1);'") do
    its(:stdout) { should cmp >= 5 }
  end
end

control 'mysql-db-03' do
  impact 1.0
  title 'test database must be deleted'
  describe command("mysql -u#{user} -p#{pass} -s -e 'show databases like \"test\";'") do
    its(:stdout) { should_not match(/test/) }
  end
end

control 'mysql-db-04' do
  impact 1.0
  title 'deactivate annonymous user names'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where user=\"\";' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end

control 'mysql-db-05' do
  impact 1.0
  title 'default passwords must be changed'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where length(password)=0 or password=\"\";' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end

control 'mysql-db-06' do
  impact 0.5
  title 'the grant option must not be used'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where grant_priv=\"y\" and User!=\"root\" and User!=\"debian-sys-maint\";' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end

control 'mysql-db-07' do
  impact 0.5
  title 'ensure no wildcards are used for hostnames'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where host=\"%\"' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end

control 'mysql-db-08' do
  impact 0.5
  title 'it must be ensured that superuser can login via localhost only'
  describe command("mysql -u#{user} -p#{pass} mysql -s -e 'select count(*) from mysql.user where user=\"root\" and host not in (\"localhost\",\"127.0.0.1\",\"::1\")' | tail -1") do
    its(:stdout) { should match(/^0/) }
  end
end