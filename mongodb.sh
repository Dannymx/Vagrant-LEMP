#!/bin/bash

# mongodb
echo ""
echo "#########################"
echo "#   INSTALLING MONGODB  #"
echo "#########################"
sudo aptitude install -y php-pear php5-dev mongodb mongodb-server

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
echo "extension=mongo.so" >> /etc/php5/cli/php.ini

# restarting apache2
echo ""
echo "#########################"
echo "#  RESTARTING APACHE2   #"
echo "#########################"
sudo /etc/init.d/apache2 restart