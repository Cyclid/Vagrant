#!/bin/bash
TARGET_DIR=/vagrant/config
HMAC=$(grep 'Admin secret:' /var/lib/cyclid/cyclid-db-init | awk '{print $3}')

mkdir $TARGET_DIR

echo "server: localhost
port: 8080
organization: admins
username: admin
secret: $HMAC" > ${TARGET_DIR}/vagrant
