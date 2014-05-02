require 'spec_helper'

describe 'profile::robobutler' do
  it { should contain_class 'docker' }
  it { should contain_file '/var/lib/butlerbot'}
end
