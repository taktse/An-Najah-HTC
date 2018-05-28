require 'spec_helper'
describe 'gnome_desktop' do
  context 'with default values for all parameters' do
    it { should contain_class('gnome_desktop') }
  end
end
