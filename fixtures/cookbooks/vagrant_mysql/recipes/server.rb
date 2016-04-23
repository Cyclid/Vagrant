#
# Cookbook Name:: vagrant_mysql
# Recipe:: server
#
# Copyright (c) 2016 Liqwyd Ltd., All Rights Reserved.

# Get the root password from the databag that cyc_api uses for the MySQL
# server. In the cyc_api cookbook this is a chef_vault_item but we know that
# in Vagrant it can just be loaded as a data bag, as there is no Chef vault and
# the data isn't expected to be secure.
auth_data = data_bag_item('cyc_api', 'mysql')
creds = auth_data[node.chef_environment]

mysql_service 'cyclid' do
  version '5.5'
  initial_root_password creds['password']
  action [:create, :start]
end

# Fix up a symlink from the default socket location to the mysql-cyclid
# location so that the 'mysql' client works.
link '/var/run/mysqld/mysqld.sock' do
  to '/var/run/mysql-cyclid/mysqld.sock'
end
