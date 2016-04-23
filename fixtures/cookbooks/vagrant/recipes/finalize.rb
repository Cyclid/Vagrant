#
# Cookbook Name:: vagrant
# Recipe:: finalize
#
# Copyright (c) 2016 Liqwyd Ltd., All Rights Reserved.

# Chef-zero depends on ruby-rack 1.5 which gets installed via. apt. This breaks
# Sinatra & Unicorn because it depends on Rack 1.6, which is installed from
# Gems
package 'ruby-rack' do
  action :remove
  notifies :restart, 'runit_service[unicorn]'
end

# Restart Unicorn so that it loads the correct Rack Gem
runit_service 'unicorn' do
  action :nothing
end

# Just clean up anything that's hanging around
execute 'apt-get-autoremove' do
  command 'apt-get autoremove -y'
end

# Extract the Admin HMAC secret that was created by cyclid-db-init and generate
# Cyclid client configuration using it.
cookbook_file '/var/lib/cyclid/client-config.sh' do
  source 'client-config.sh'
  mode 0755
end

execute 'generate-config' do
  command '/var/lib/cyclid/client-config.sh'
end
