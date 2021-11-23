describe file('/etc/passwd-') do
    it { should exist }
    it { should_not be_more_permissive_than('0600') }
    its('uid') { should cmp 0 }
    its('gid') { should cmp 0 }
  end