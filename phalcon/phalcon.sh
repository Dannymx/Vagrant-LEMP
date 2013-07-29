#!/bin/bash

echo "###################"
echo "# PHALCON INSTALL #"
echo "###################"
sudo aptitude install -y gcc make
cd 
git clone git://github.com/phalcon/cphalcon.git
cd cphalcon/build
sudo ./install
echo "extension=phalcon.so" >> /etc/php5/fpm/php.ini
echo "extension=phalcon.so" >> /etc/php5/cli/php.ini

sed -i 's/listen = \/var\/run\/php5-fpm.sock/listen = 127.0.0.1:7777/g' /etc/php5/fpm/pool.d/www.conf

echo "####################"
echo "# PHALCON DEVTOOLS #"
echo "####################"
cd 
git clone git://github.com/phalcon/phalcon-devtools.git
cd phalcon-devtools/
./phalcon.sh
sudo ln -s ~/devtools/phalcon.php /usr/bin/phalcon
sudo chmod ugo+x /usr/bin/phalcon

cd /var/www
phalcon project phalcon
chown -R www-data:www-data

rm /etc/nginx/sites-available/default
echo "server {

    listen   80;
    server_name localhost.dev;

    index index.php index.html index.htm;
    set $root_path '/var/www/phalcon/public';
    root $root_path;

    try_files $uri $uri/ @rewrite;

    location @rewrite {
        rewrite ^/(.*)$ /index.php?_url=/$1;
    }

    location ~ \.php {
        fastcgi_pass 127.0.0.1:7777;
        fastcgi_index /index.php;

        include /etc/nginx/fastcgi_params;

        fastcgi_split_path_info       ^(.+\.php)(/.+)$;
        fastcgi_param PATH_INFO       $fastcgi_path_info;
        fastcgi_param PATH_TRANSLATED $document_root$fastcgi_path_info;
        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
    }

    location ~* ^/(css|img|js|flv|swf|download)/(.+)$ {
        root $root_path;
    }

    location ~ /\.ht {
        deny all;
    }
}" >> /etc/nginx/sites-available/default

/etc/init.d/nginx restart
