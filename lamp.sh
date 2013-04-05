#!/bin/bash

echo "#########################"
echo "# ADDING DOTDEB SOURCES #"
echo "#########################"
echo "deb http://packages.dotdeb.org squeeze all" >> /etc/apt/source.list
echo "deb-src http://packages.dotdeb.org squeeze all" >> /etc/apt/source.list
echo "deb http://packages.dotdeb.org squeeze-php54 all" >> /etc/apt/source.list
echo "deb-src http://packages.dotdeb.org squeeze-php54 all" >> /etc/apt/source.list
cd /home
wget http://www.dotdeb.org/dotdeb.gpg
cat dotdeb.gpg | sudo apt-key add -
rm dotdeb.gpg

echo ""
echo "#########################"
echo "#  UPGRADING APTITUDE   #"
echo "#########################"
aptitude update -y
aptitude upgrade -y

# apache2
echo ""
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
# sed -i "s/[mysqld](\n|\r\n)/[mysqld]\ncollation-server = utf8_general_ci\ncharacter-set-server = utf8\nskip-character-set-client-handshake" /etc/mysql/my.cnf
# [mysqld]
# collation-server = utf8_general_ci
# character-set-server = utf8
# skip-character-set-client-handshake

# php5
echo ""
echo "#########################"
echo "#    INSTALLING PHP5    #"
echo "#########################"
aptitude install -y php5 php5-curl php5-gd php5-mysql php5-cli php5-apc

# composer
echo ""
echo "#########################"
echo "#  INSTALLING COMPOSER  #"
echo "#########################"
echo "suhosin.executor.include.whitelist = phar" >> /etc/php5/cli/php.ini
aptitude install -y curl
if [ -f /usr/bin/composer ]; then
    echo "=> Composer allready installed skipping to git."
else
    cd /home
    curl -s https://getcomposer.org/installer | php
    mv composer.phar /usr/bin/composer
fi

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

# add vim
echo ""
echo "#########################"
echo "#          VIM          #"
echo "#########################"
aptitude install -y vim

# add alias
echo ""
echo "#########################"
echo "#       ADD ALIAS       #"
echo "#########################"
echo "alias l='ls -la'" >> /root/.bashrc
echo "alias ..='cd ..'" >> /root/.bashrc
echo "alias ...='cd ../../'" >> /root/.bashrc
echo "alias ....='cd ../../../'" >> /root/.bashrc
echo "alias .....='cd ../../../../'" >> /root/.bashrc
echo "alias ......='cd ../../../../../'" >> /root/.bashrc
echo "alias a2r='/etc/init.d/apache2 restart'" >> /root/.bashrc 


echo ""
echo "#########################"
echo "#         DONE          #"
echo "#########################"
