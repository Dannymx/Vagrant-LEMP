#!/bin/bash

echo "#########################"
echo "# ADDING DOTDEB SOURCES #"
echo "#########################"
echo "deb http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy all" >> /etc/apt/sources.list
echo "deb http://packages.dotdeb.org wheezy-php54 all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org wheezy-php54 all" >> /etc/apt/sources.list
wget http://www.dotdeb.org/dotdeb.gpg
cat dotdeb.gpg | sudo apt-key add -
rm dotdeb.gpg

echo ""
echo "###########################"
echo "#    UPDATING PACKAGES    #"
echo "###########################"
sudo apt-get update 

echo ""
echo "###########################"
echo "#     INSTALLING STUFF    #"
echo "###########################"
sudo apt-get install -y htop curl wget git

# php5
echo ""
echo "#########################"
echo "#    INSTALLING PHP5    #"
echo "#########################"
sudo apt-get install -y php5 php5-fpm php5-curl php5-gd php5-cli php5-apc php5-intl php5-mcrypt

# composer
echo ""
echo "#########################"
echo "#  INSTALLING COMPOSER  #"
echo "#########################"
if [ -f /usr/bin/composer ]; then
    echo "=> Composer already installed skipping to git."
else
    curl -s https://getcomposer.org/installer | php
    mv composer.phar /usr/bin/composer
fi

# add alias
echo ""
echo "#########################"
echo "#       ADD ALIAS       #"
echo "#########################"
echo "alias l='ls -la'" >> /home/vagrant/.bashrc
echo "alias ..='cd ..'" >> /home/vagrant/.bashrc
echo "alias ...='cd ../../'" >> /home/vagrant/.bashrc
echo "alias ....='cd ../../../'" >> /home/vagrant/.bashrc
echo "alias .....='cd ../../../../'" >> /home/vagrant/.bashrc
echo "alias ......='cd ../../../../../'" >> /home/vagrant/.bashrc

echo ""
echo "#########################"
echo "#         DONE          #"
echo "#########################"
