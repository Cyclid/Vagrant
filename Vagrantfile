# -*- mode: ruby -*-
# vi: set ft=ruby :

chef_path = ENV.fetch('CYCLID_COOKBOOK_PATH', '../chef')

Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'

  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '1024'
  end

  # Make the Cyclid API accessable from the host on port 8080
  config.vm.network 'forwarded_port', guest: 80, host: 8080

  # Use Berkshelf to install the cookbook dependencies
  config.berkshelf.enabled = true

  # Configure with the Cyclid Chef recipes and Vagrant specific configuration
  # data
  config.vm.provision 'chef_zero' do |chef|
    chef.environments_path = 'fixtures/environments'
    chef.data_bags_path = 'fixtures/data_bags'
    chef.nodes_path = 'fixtures/nodes'

    chef.environment = 'vagrant'

    chef.run_list = ['recipe[vagrant_mysql::server]',
                     'recipe[cyc_api]',
                     'recipe[vagrant_mysql::database]',
                     'recipe[cyc_builder]',
                     'recipe[vagrant::finalize]']
  end

  # Run the script to produce the client configuration file
  config.vm.provision 'shell', inline: '/var/lib/cyclid/client-config.sh'
end
