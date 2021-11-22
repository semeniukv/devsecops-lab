control 'os-01' do
  impact 1.0
  title 'Trusted hosts login'
  desc "hosts.equiv file is a weak implemenation of authentication. Disabling the hosts.equiv support helps to prevent users from subverting the system's normal access control mechanisms of the system."
  describe file('/etc/hosts.equiv') do
    it { should_not exist }
  end
end

control 'os-02' do
  impact 1.0
  title 'Check owner and permissions for /etc/shadow'
  desc 'Check periodically the owner and permissions for /etc/shadow'
  describe file('/etc/shadow') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    its('group') { should eq shadow_group }
    it { should_not be_executable }
    it { should_not be_readable.by('other') }
  end
  if os.redhat? || os.name == 'fedora'
    describe file('/etc/shadow') do
      it { should_not be_writable.by('owner') }
      it { should_not be_readable.by('owner') }
    end
  else
    describe file('/etc/shadow') do
      it { should be_writable.by('owner') }
      it { should be_readable.by('owner') }
    end
  end
  if os.debian? || os.suse?
    describe file('/etc/shadow') do
      it { should be_readable.by('group') }
    end
  else
    describe file('/etc/shadow') do
      it { should_not be_readable.by('group') }
    end
  end
end

control 'os-03' do
  impact 1.0
  title 'Check owner and permissions for /etc/passwd'
  desc 'Check periodically the owner and permissions for /etc/passwd'
  describe file('/etc/passwd') do
    it { should exist }
    it { should be_file }
    it { should be_owned_by 'root' }
    its('group') { should eq 'root' }
    it { should_not be_executable }
    it { should be_writable.by('owner') }
    it { should_not be_writable.by('group') }
    it { should_not be_writable.by('other') }
    it { should be_readable.by('owner') }
    it { should be_readable.by('group') }
    it { should be_readable.by('other') }
  end
end