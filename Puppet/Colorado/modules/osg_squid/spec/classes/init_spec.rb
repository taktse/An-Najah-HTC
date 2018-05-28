require 'spec_helper'
describe 'osg_squid' do
  context 'with default values for all parameters' do
    it { should contain_class('osg_squid') }
  end
end
