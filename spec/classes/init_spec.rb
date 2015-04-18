require 'spec_helper'
describe 'ssh_login_message' do

  context 'with defaults for all parameters' do
    it { should contain_class('ssh_login_message') }
  end
end
