title 'system'
version = attribute(
  'version', default: '2.60.3-1.1', description: 'Jenkins version')

control 'system-01' do
  title 'Jenkins Service'
  impact 0.8
  describe service('jenkins') do
    it { should be_installed }
    it { should be_enabled }
    it { should be_running }
  end
  describe package('jenkins') do
    it { should be_installed }
    its('version') { should eq version }
  end
  describe yum do
    its('jenkins') { should exist }
    its('jenkins') { should be_enabled }
  end
  describe user('jenkins') do
    its('shell') { should eq '/bin/bash' }
  end
end
