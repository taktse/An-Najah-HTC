require 'spec_helper'
describe 'hadoopdn' do
  context 'with default values for all parameters' do
    it { should contain_class('hadoopdn') }
  end
end
