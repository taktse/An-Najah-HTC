require 'spec_helper'
describe 'local_defs' do
  context 'with default values for all parameters' do
    it { should contain_class('local_defs') }
  end
end
