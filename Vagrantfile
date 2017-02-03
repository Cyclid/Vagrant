# -*- mode: ruby -*-
# vi: set ft=ruby :

chef_path = ENV.fetch('CYCLID_COOKBOOK_PATH', '../chef')

Vagrant.configure(2) do |config|
  # Database, two servers, containers...we need RAM
  config.vm.provider 'virtualbox' do |vb|
    vb.memory = '4096'

    # Issue #3: over-ride the settings in the Xenial box
    vb.customize [ 'modifyvm', :id, '--uartmode1', 'disconnected']
  end

  # Make the Cyclid API accessable from the host on port 8361
  config.vm.network 'forwarded_port', guest: 8361, host: 8361

  # Make the Cyclid UI accessable from the host on port 8080
  config.vm.network 'forwarded_port', guest: 80, host: 8080

  # Use Berkshelf to install the cookbook dependencies
  config.berkshelf.enabled = true

  # Trusty with LXC based containers
  config.vm.define "cyclid-trusty-lxc" do |trusty|
    trusty.vm.box = 'ubuntu/trusty64'
    trusty.vm.hostname = 'ubuntu-trusty-cyclid'

    # Configure with the Cyclid Chef recipes and Vagrant specific configuration
    # data
    trusty.vm.provision 'chef_zero' do |chef|
      chef.channel = 'stable'
      chef.version = '12.10.24'

      chef.environments_path = 'fixtures/environments'
      chef.data_bags_path = 'fixtures/data_bags'
      chef.nodes_path = 'fixtures/nodes'

      chef.environment = 'vagrant'

      chef.run_list = ['recipe[vagrant_mysql::server]',
                       'recipe[cyc_api]',
                       'recipe[vagrant_mysql::database]',
                       'recipe[cyc_builder]',
                       'recipe[cyc_ui]',
                       'recipe[vagrant::finalize]']
    end

    # Run the script to produce the client configuration file
    trusty.vm.provision 'shell', inline: '/var/lib/cyclid/client-config.sh'
  end

  # Xenial with LXD based containers
  config.vm.define "cyclid-xenial-lxd" do |xenial|
    xenial.vm.box = 'ubuntu/xenial64'
    xenial.vm.hostname = 'ubuntu-xenial-cyclid'

    # Configure with the Cyclid Chef recipes and Vagrant specific configuration
    # data
    xenial.vm.provision 'chef_zero' do |chef|
      chef.channel = 'stable'
      chef.version = '12.10.24'

      chef.environments_path = 'fixtures/environments'
      chef.data_bags_path = 'fixtures/data_bags'
      chef.nodes_path = 'fixtures/nodes'

      chef.environment = 'vagrant'

      chef.run_list = ['recipe[vagrant_mysql::server]',
                       'recipe[cyc_api]',
                       'recipe[vagrant_mysql::database]',
                       'recipe[vagrant::lxd]',
                       'recipe[cyc_ui]',
                       'recipe[vagrant::finalize]']
    end

    # Run the script to produce the client configuration file
    xenial.vm.provision 'shell', inline: '/var/lib/cyclid/client-config.sh'
  end
end
