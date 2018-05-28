require 'spec_helper'
describe 'network_manager' do
  context 'with default values for all parameters' do
    it { should contain_class('network_manager') }
  end
end
