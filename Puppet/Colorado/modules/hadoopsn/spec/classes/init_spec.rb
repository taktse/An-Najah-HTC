require 'spec_helper'
describe 'hadoopsn' do
  context 'with default values for all parameters' do
    it { should contain_class('hadoopsn') }
  end
end
