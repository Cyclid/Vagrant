#!/bin/bash
TARGET_DIR=/vagrant/config
HMAC=$(grep 'Admin secret:' /var/lib/cyclid/cyclid-db-init | awk '{print $3}')

if [ ! -e $TARGET_DIR ]
then
  mkdir -p $TARGET_DIR
fi

echo "server: localhost
port: 8361
organization: admins
username: admin
secret: $HMAC" > ${TARGET_DIR}/vagrant
