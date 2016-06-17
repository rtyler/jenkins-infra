require 'spec_helper_acceptance'

describe 'a simple test', :confine => {:role => 'agent'} do
  let(:manifest) do
    'include role::spinach'
  end

  describe package('mysql-server') do
    it { is_expected.to be_installed }
  end

  #it 'should apply the manifest cleanly' do
  #  pending
  #  apply_manifest(manifest, :expect_changes=> true)

  #  # run a second time without changes
  #  apply_manifest(manifest, :catch_changes => true)
  #end
end
