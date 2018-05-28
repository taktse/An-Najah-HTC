# -*- ruby -*-

require 'serverspec'

set :backend, :exec

def lsb_release
  command('lsb_release -c').stdout
end

def new_version?
  lsb_release =~ /stretch|buster/
end

def nrpe_service_name
  if new_version?
    'nagios-nrpe-server'
  else
    'nrpe'
  end
end

describe 'Packages' do
  [
    'nagios-nrpe-server',
    'nagios-plugins'
  ].each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end

# describe 'Service' do
#   describe service(nrpe_service_name) do
#     it { should be_running }
#   end
# end

describe 'Configuration files (nrpe.cfg)' do
  describe file('/etc/nagios/nrpe.cfg') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
    it { should contain '127.0.0.1' }
  end
end

describe 'Configuration files (nrpe_local.cfg)' do
  describe file('/etc/nagios/nrpe_local.cfg') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
    it { should contain 'aufs' }
    it { should contain '/usr/lib/nagios/plugins' }
  end
end

describe 'Directory (nrpe.d)' do
  describe file('/etc/nagios/nrpe.d') do
    it { should exist }
    it { should be_directory }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 755 }
  end
end

describe 'Command (check_memory.cfg)' do
  describe file('/etc/nagios/nrpe.d/check_memory.cfg') do
    it { should exist }
    it { should be_owned_by 'root' }
    it { should be_grouped_into 'root' }
    it { should be_mode 644 }
    it { should contain '/usr/lib/nagios/plugins/check_memory' }
  end
end
# EOF
