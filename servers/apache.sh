# apache2
echo ""
echo "#########################"
echo "#  INSTALLING APACHE2   #"
echo "#########################"
sudo aptitude install -y apache2 libapache2-mod-php5
sudo a2enmod rewrite
# sudo a2enmod deflate expires rewrite # todo check it

# restarting apache2
echo ""
echo "#########################"
echo "#  RESTARTING APACHE2   #"
echo "#########################"
sudo /etc/init.d/apache2 restart
sudo rm /var/www/index.html