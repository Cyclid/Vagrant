source 'https://supermarket.chef.io'

chef_path = ENV.fetch('CYCLID_COOKBOOK_PATH', '../chef')

cookbook 'cyc_lxc', path: "#{chef_path}/cookbooks/cyc_lxc"
cookbook 'cyc_builder', path: "#{chef_path}/cookbooks/cyc_builder"
cookbook 'cyc_nginx', path: "#{chef_path}/cookbooks/cyc_nginx"
cookbook 'cyc_api', path: "#{chef_path}/cookbooks/cyc_api"
cookbook 'cyc_mist', path: "#{chef_path}/cookbooks/cyc_mist"

cookbook 'vagrant_mysql', path: 'fixtures/cookbooks/vagrant_mysql'
