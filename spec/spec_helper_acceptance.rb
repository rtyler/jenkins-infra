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
    install_pe
    # Install module to all hosts
    hosts.each do |host|
      next

      dist_dir = File.join(module_root, 'dist')
      Dir.foreach(dist_dir) do |d|
        module_dir = File.join(dist_dir, d)
        next unless File.directory? module_dir
        next if d.start_with? '.'

        install_dev_puppet_module_on(host,
          :source => module_dir,
          :module_name => d,
          :target_module_path => "/etc/puppet/modules/")
      end
    end
  end
end

