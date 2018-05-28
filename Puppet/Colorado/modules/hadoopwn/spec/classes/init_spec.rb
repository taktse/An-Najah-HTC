require 'spec_helper'
describe 'hadoopwn' do
  context 'with default values for all parameters' do
    it { should contain_class('hadoopwn') }
  end
end
