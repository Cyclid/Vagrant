#!/bin/bash
HMAC=$(grep 'Admin secret:' /var/lib/cyclid/cyclid-db-init | awk '{print $3}')

echo "server: localhost
port: 8080
organization: admins
username: admin
secret: $HMAC" > /vagrant/config/vagrant
