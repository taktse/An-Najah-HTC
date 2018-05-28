require 'spec_helper'
describe 'reboot_notify' do
  context 'with default values for all parameters' do
    it { should contain_class('reboot_notify') }
  end
end
