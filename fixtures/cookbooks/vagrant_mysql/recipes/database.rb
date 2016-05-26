#
# Cookbook Name:: vagrant_mysql
# Recipe:: database
#
# Copyright (c) 2016 Liqwyd Ltd., All Rights Reserved.

# Get the root password from the databag that cyc_api uses for the MySQL
# server.
auth_data = data_bag_item('cyc_api', 'mysql')
creds = auth_data[node.chef_environment]

# Create the database if it doesn't exist, and then run cyclid-db-init to
# create the schema & initial admin user
execute 'create-cyclid-database' do
  command "mysql --user=#{creds['username']} --password=#{creds['password']} -S /var/run/mysql-cyclid/mysqld.sock -e 'create database cyclid;' --batch"
  not_if "mysql --user=#{creds['username']} --password=#{creds['password']} -S /var/run/mysql-cyclid/mysqld.sock -e 'show databases;' --batch | grep cyclid >/dev/null"
  notifies :run, 'execute[cyclid-init-database]'
end

execute 'cyclid-init-database' do
  command 'cyclid-db-init 2>/var/lib/cyclid/cyclid-db-init'
  action :nothing
end
