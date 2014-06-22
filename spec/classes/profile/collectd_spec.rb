require 'spec_helper'

describe 'profile::collectd' do
  it { should contain_class('collectd').with_purge('true') }
end
