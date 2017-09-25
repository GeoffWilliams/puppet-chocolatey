require 'spec_helper'
describe 'chocolatey' do
  context 'with default values for all parameters' do
    it { should contain_class('chocolatey') }
  end
end
