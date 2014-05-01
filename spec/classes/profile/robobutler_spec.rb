require 'spec_helper'

describe 'profile::robobutler' do
  it { should contain_class 'docker' }
end
