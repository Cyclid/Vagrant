#!/bin/bash
BOX=cyclid-xenial-lxd

vagrant destroy $BOX
vagrant up $BOX
vagrant package $BOX --output $BOX.box --vagrantfile package/Vagrantfile
