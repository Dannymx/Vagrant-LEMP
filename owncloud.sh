#!/bin/bash

cd /home
wget http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_6.0/Release.key
apt-key add - < Release.key
rm /home/Release.key

echo 'deb http://download.opensuse.org/repositories/isv:ownCloud:community/Debian_6.0/ /' >> /etc/apt/sources.list.d/owncloud.list 
apt-get update
apt-get install owncloud

/etc/init.d/apache2 restart
