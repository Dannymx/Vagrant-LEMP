#!/bin/bash

# apache2
echo "#########################"
echo "#  INSTALLING APACHE2   #"
echo "#########################"
aptitude install -y apache2
a2enmod rewrite

# mysql
echo ""
echo "#########################"
echo "#   INSTALLING MYSQL    #"
echo "#########################"
aptitude install -y mysql-server
# mysql_secure_installation
# [mysqld]
# collation-server = utf8_general_ci
# character-set-server = utf8
# skip-character-set-client-handshake 

# php5
echo ""
echo "#########################"
echo "#    INSTALLING PHP5    #"
echo "#########################"
aptitude install -y php5

# composer
echo ""
echo "#########################"
echo "#  INSTALLING COMPOSER  #"
echo "#########################"
dpkg -s curl >/dev/null 2>&1 && {
	echo "=> Curl allready installed skipping to composer install."
} || {
	echo "=> Curl currently not installed. Doing it."
	aptitude install curl
}
if [ -f /usr/bin/composer ]; then
	echo "=> Composer allready installed skipping to git."
else
	cd /home
	curl -s https://getcomposer.org/installer | php
	mv composer.phar /usr/bin/composer
fi
echo "suhosin.executor.include.whitelist = phar" >> /etc/php5/cli/php.ini

# git
echo ""
echo "#########################"
echo "#    INSTALLING GIT     #"
echo "#########################"
aptitude install -y git

# restarting apache2
echo ""
echo "#########################"
echo "#  RESTARTING APACHE2   #"
echo "#########################"
/etc/init.d/apache2 restart