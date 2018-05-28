require 'spec_helper'
describe 'common_services' do
  context 'with default values for all parameters' do
    it { should contain_class('common_services') }
  end
end
