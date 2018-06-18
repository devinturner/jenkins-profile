title 'vitals'
ports = attribute(
  'ports',
  default: ['8080'],
  description: 'Ports that Jenkins listening on'
)

as_client = attribute(
  'as_client',
  default: false,
  description: 'Test as client'
)

jenkins_url = attribute(
  'jenkins_url',
  default: 'http://localhost:8080',
  description: 'Jenkins URL'
)

control 'vital-1.0' do
  impact 1.0
  title 'Port connections'
  ports.each do |port|
    describe port(port) do
      it { should be_listening }
    end
  end
end

control 'vital-2.0' do
  impact 1.0
  title 'Jenkins process'
  describe processes('jenkins') do
    it { should exist }
  end
end

control 'vital-3.0' do
  impact 1.0
  title 'Web interface'
  describe http(jenkins_url, enable_remote_worker: as_client) do
    its('status') { should cmp 200 }
    its('body') { should include 'Jenkins' }
  end
end
