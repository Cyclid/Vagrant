# Cyclid Vagrant

This repository contains a Vagrantfile and some supporting Chef cookbooks that can create & configure a Vagrant instance running Cyclid, and the Mist server to create LXC containers as build hosts.

## Creating the Vagrant box

### Prequisites

* A recent version of Vagrant, and a supported hypervisor.
* The [vagrant-berkshelf](https://github.com/berkshelf/vagrant-berkshelf) plugin
* ChefDK

The Cyclid Vagrant box currently only supports the Virtualbox hypervisor.

### Process

Clone the [Cyclid chef cookbooks](https://github.com/Liqwyd/chef) and this repository into the same directory:

	$ git clone https://github.com/Liqwyd/chef
	$ git clone https://github.com/Liqwyd/Vagrant

Start Vagrant

	$ cd Vagrant
	$ vagrant up

Vagrant will download the base box image and configure it with the Cyclid chef recipes to run Cyclid, a MySQL 5.5 server and a Mist server.

A Cyclid client configuration file will be automatically generated for you in the `config/vagrant` file; this file is created with the generated HMAC secret for the `admin` user on the Cyclid server.

The Cyclid API is forwarded to the guest on port 8080.

## Usage

If you have installed the Cyclid client, just copy the `config/vagrant` configuration file to the client configuration directory and then select it as the current configuration:

	$ cp config/vagrant $HOME/.cyclid/
	$ cyclid org use vagrant

Alternatively you can pass the location of the configuration file to the client:

	$ cyclid org show -c /path/to/config/vagrant

You can then use the Cyclid Vagrant instance as you would any other Cyclid server, including submitting jobs to run. Just bare in mind that everything is running in a single virtual machine, including the buildhost containers!