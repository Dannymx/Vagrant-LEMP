#!/bin/bash

# mysql
echo ""
echo "#########################"
echo "#   INSTALLING MYSQL    #"
echo "#########################"
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password password root'
sudo debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password root'
sudo apt-get install -y mysql-server php5-mysql
# mysql_secure_installation
# sed -i "s/[mysqld](\n|\r\n)/[mysqld]\ncollation-server = utf8_general_ci\ncharacter-set-server = utf8\nskip-character-set-client-handshake" /etc/mysql/my.cnf
# [mysqld]
# collation-server = utf8_general_ci
# character-set-server = utf8
# skip-character-set-client-handshake
