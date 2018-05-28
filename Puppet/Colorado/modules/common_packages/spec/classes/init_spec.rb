require 'spec_helper'
describe 'common_packages' do
  context 'with default values for all parameters' do
    it { should contain_class('common_packages') }
  end
end
