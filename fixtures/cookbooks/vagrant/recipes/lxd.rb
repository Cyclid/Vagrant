#
# Cookbook Name:: vagrant
# Recipe:: lxd
#
# Copyright (c) 2016 Liqwyd Ltd., All Rights Reserved.

package 'lxd'

cookbook_file '/etc/cyclid/lxd_client.key' do
  owner 'root'
  group 'root'
  mode 0400
  source 'lxd_client.key'
end

cookbook_file '/etc/cyclid/lxd_client.crt' do
  owner 'root'
  group 'root'
  mode 0400
  source 'lxd_client.crt'
  notifies :run, 'execute[add client cert]'
end

execute 'initialize LXD' do
  command 'lxd init --auto --network-address 127.0.0.1 --network-port 8443'
end

# "lxd init" can't configure the bridge from the command line
cookbook_file '/etc/default/lxd-bridge' do
  owner 'root'
  group 'root'
  source 'lxd-bridge'
  notifies :restart, 'service[lxd-bridge]'
end

service 'lxd-bridge' do
  action :nothing
end

execute 'add client cert' do
  command 'lxc config trust add /etc/cyclid/lxd_client.crt'
  action :nothing
end

gem_package 'cyclid-lxd-plugin' do
  gem_binary '/usr/bin/gem2.3'
  notifies :restart, 'runit_service[cyclid-ui]'
  notifies :restart, 'runit_service[sidekiq]'
end
