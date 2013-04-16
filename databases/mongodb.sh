#!/bin/bash

# set up APT
echo ""
echo "#########################"
echo "#       SET UP APT      #"
echo "#########################"
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
sudo echo "deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen" >> /etc/apt/sources.list.d/10gen.list
sudo apt-get update

# mongodb
echo ""
echo "#########################"
echo "#   INSTALLING MONGODB  #"
echo "#########################"
sudo aptitude install -y php-pear php5-dev mongodb-10gen

# Mongo PHP extension 
echo ""
echo "#########################"
echo "#  PHP EXTENSION MONGO  #"
echo "#########################"
pecl install mongo

# Link mongo with Apache 
echo ""
echo "#########################"
echo "#   MONGO WITH APACHE   #"
echo "#########################"
echo "extension=mongo.so" >> /etc/php5/apache2/php.ini

# restarting apache2
echo ""
echo "#########################"
echo "#  RESTARTING SERVICES  #"
echo "#########################"
sudo /etc/init.d/apache2 restart
sudo /etc/init.d/mongodb restart
