aptitude update && aptitude safe-upgrade

# MANDATORY
aptitude install -y vim


# LAMP

# apache2
aptitude install -y apache2
a2enmod rewrite

# mysql
aptitude install -y mysql-server
mysql_secure_installation
sed -i 's/[mysqld]\n/[mysqld]\ncollation-server = utf8_general_ci\ncharacter-set-server = utf8/' /etc/mysql/my.cnf

# php5
aptitude install -y php5

# composer
aptitude install -y curl
echo "suhosin.executor.include.whitelist = phar" >> /etc/php5/cli/php.init
curl -s https://getcomposer.org/installer | php

# git
aptitude install -y git

# restarting apache2
/etc/init.id/apache2 restart


# SECURITY

# Reconfigure sshd - change port and disable root login
sed -i 's/^Port [0-9]*/Port '${SSHD_PORT}'/' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
service ssh reload
