#!/bin/bash
vagrant destroy
vagrant up
vagrant package --output cyclid.box --vagrantfile package/Vagrantfile
