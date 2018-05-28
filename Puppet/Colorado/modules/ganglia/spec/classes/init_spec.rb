require 'spec_helper'
describe 'ganglia' do
  context 'with default values for all parameters' do
    it { should contain_class('ganglia') }
  end
end
