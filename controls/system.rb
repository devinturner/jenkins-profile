title 'system'
version = attribute(
  'version',
  default: '2.164.1',
  description: 'Jenkins version'
)
jenkins_home = attribute(
  'jenkins_home',
  default: '/var/lib/jenkins',
  description: 'Jenkins home'
)
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
  describe apt('http://pkg.jenkins.io/debian-stable') do
    it { should exist }
    it { should be_enabled }
  end
  describe user('jenkins') do
    its('shell') { should eq '/bin/bash' }
  end
  describe file(jenkins_home) do
    it { should be_directory }
    its('group') { should eq 'jenkins' }
    its('owner') { should eq 'jenkins' }
  end
end
