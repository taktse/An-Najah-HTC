require 'spec_helper'
describe 'datadisks' do
  context 'with default values for all parameters' do
    it { should contain_class('datadisks') }
  end
end
