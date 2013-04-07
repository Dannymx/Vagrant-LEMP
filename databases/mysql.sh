#!/bin/bash

# mysql
echo ""
echo "#########################"
echo "#   INSTALLING MYSQL    #"
echo "#########################"
sudo debconf-set-selections <<< 'mysql-server-5.1 mysql-server/root_password password toor'
sudo debconf-set-selections <<< 'mysql-server-5.1 mysql-server/root_password_again password toor'
sudo aptitude install -y mysql-server
# mysql_secure_installation
# sed -i "s/[mysqld](\n|\r\n)/[mysqld]\ncollation-server = utf8_general_ci\ncharacter-set-server = utf8\nskip-character-set-client-handshake" /etc/mysql/my.cnf
# [mysqld]
# collation-server = utf8_general_ci
# character-set-server = utf8
# skip-character-set-client-handshake
