require 'spec_helper'
describe 'package_yum_groupinstall' do
  context 'with default values for all parameters' do
    it { should contain_class('package_yum_groupinstall') }
  end
end
