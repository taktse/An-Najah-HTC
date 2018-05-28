require 'spec_helper'
describe 'cvmfs' do
  context 'with default values for all parameters' do
    it { should contain_class('cvmfs') }
  end
end
