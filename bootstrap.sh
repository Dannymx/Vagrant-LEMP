#!/bin/bash

echo "#########################"
echo "# ADDING DOTDEB SOURCES #"
echo "#########################"
echo "deb http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org squeeze all" >> /etc/apt/sources.list
echo "deb http://packages.dotdeb.org squeeze-php54 all" >> /etc/apt/sources.list
echo "deb-src http://packages.dotdeb.org squeeze-php54 all" >> /etc/apt/sources.list
cd /home
wget http://www.dotdeb.org/dotdeb.gpg
cat dotdeb.gpg | sudo apt-key add -
rm dotdeb.gpg

echo ""
echo "#################################"
echo "#  UPGRADING APTITUDE & STUFF   #"
echo "#################################"
sudo echo grub-common hold | dpkg --set-selections
sudo echo grub-pc hold | dpkg --set-selections
sudo apt-get update --fix-missing 
sudo aptitude safe-upgrade -y
sudo aptitude install -y nfs-common

# apache2
echo ""
echo "#########################"
echo "#  INSTALLING APACHE2   #"
echo "#########################"
sudo aptitude install -y apache2 libapache2-mod-php5
sudo a2enmod rewrite
# sudo a2enmod deflate expires rewrite # todo check it

# php5
echo ""
echo "#########################"
echo "#    INSTALLING PHP5    #"
echo "#########################"
sudo aptitude install -y php5 php5-fpm php5-curl php5-gd php5-cli php5-apc php5-intl

# composer
echo ""
echo "#########################"
echo "#  INSTALLING COMPOSER  #"
echo "#########################"
echo "suhosin.executor.include.whitelist = phar" >> /etc/php5/cli/php.ini
sudo aptitude install -y curl
if [ -f /usr/bin/composer ]; then
    echo "=> Composer already installed skipping to git."
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
sudo aptitude install -y git

# restarting apache2
echo ""
echo "#########################"
echo "#  RESTARTING APACHE2   #"
echo "#########################"
sudo /etc/init.d/apache2 restart
sudo rm /var/www/index.html
sudo echo "<?php phpinfo(); ?>" >> /var/www/index.php 

# add vim
echo ""
echo "#########################"
echo "#      VIM CUSTOM       #"
echo "#########################"
sudo aptitude install -y vim
echo "syntax on" >> /home/vagrant/.vimrc
echo "set number" >> /home/vagrant/.vimrc
sudo cp /home/vagrant/.vimrc /root/ && sudo chown root:root /root/.vimrc

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
echo "alias a2r='/etc/init.d/apache2 restart'" >> /home/vagrant/.bashrc 

# @TODO put this in a specific SF2 file.
# Symfony2 alias 
# echo ""
# echo "#########################"
# echo "#       SF2 ALIAS       #"
# echo "#########################"
# echo "sf2 = 'php app/console'" >> /home/vagrant/.bashrc
# echo "sf2clear = 'php app/console cache:clear'" >> /home/vagrant/.bashrc

sudo cp /home/vagrant/.bashrc /root/ && sudo chown root:root /root/.bashrc

echo ""
echo "#########################"
echo "#         DONE          #"
echo "#########################"
