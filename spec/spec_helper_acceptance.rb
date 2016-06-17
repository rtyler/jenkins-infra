require 'beaker-rspec'

# Install Puppet on all hosts
#hosts.each do |host|
#  install_puppet_on host, :default_action => 'gem_install'
#end
#
PE_VERSION = '2016.1'

RSpec.configure do |c|
  module_root = File.expand_path(File.join(File.dirname(__FILE__), '..'))

  c.formatter = :documentation

  c.before :suite do
    hosts_as('master').each do |host|
      module_fixtures = [module_root, 'spec', 'fixtures', 'modules'].join(File::SEPARATOR)

      Dir.foreach(module_fixtures) do |dir|
        module_dir = File.join(module_fixtures, dir)
        next unless File.directory? module_dir
        next if dir.start_with? '.'

        install_dev_puppet_module_on(host,
          :source => module_dir,
          :module_name => dir,
          :target_module_path => "/etc/puppetlabs/code/modules/")
      end
    end
  end
end
