require 'spec_helper'
describe 'autofs' do
  context 'with default values for all parameters' do
    it { should contain_class('autofs') }
  end
end
