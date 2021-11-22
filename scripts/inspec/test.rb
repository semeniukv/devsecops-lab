# Disallow insecure protocols by testing

describe file('/usr/sbin/telnetd') do
	it { should_not exist }
end

describe port(80) do
  it { should_not be_listening }
end

#describe port(443) do
#  it { should be_listening }
#  its('protocols') {should include 'tcp'}
#end
