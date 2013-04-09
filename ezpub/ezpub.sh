#!/bin/bash

read -p "Path to project ? " project_path
cd project_path

read -p "Project name ?" project_name
git clone https://github.com/ezsystems/ezpublish-community.git project_name

cd project_path/project_name
git clone https://github.com/ezsystems/ezpublish-legacy.git ezpublish_legacy

php composer.phar install --prefer-dist

chown -R www-data:www-data ezpublish/{cache,logs,config} ezpublish_legacy/{design,extension,settings,var}
find {ezpublish/{cache,logs,config},ezpublish_legacy/{design,extension,settings,var}} -type d | xargs chmod -R 775
find {ezpublish/{cache,logs,config},ezpublish_legacy/{design,extension,settings,var}} -type f | xargs chmod -R 664

<VirtualHost *:80>
    <Directory /var/www/ezpub/web>
        Options FollowSymLinks
        AllowOverride None
    </Directory>
 
    <IfModule mod_php5.c>
        php_admin_flag safe_mode Off
        php_admin_value register_globals 0
        php_value magic_quotes_gpc 0
        php_value magic_quotes_runtime 0
        php_value allow_call_time_pass_reference 0
    </IfModule>
 
    DirectoryIndex index.php
 
    <IfModule mod_rewrite.c>
        RewriteEngine On
        RewriteRule content/treemenu/? /index_treemenu.php [L]
        RewriteRule ^/var/storage/.* - [L]
        RewriteRule ^/var/[^/]+/storage/.* - [L]
        RewriteRule ^/var/cache/texttoimage/.* - [L]
        RewriteRule ^/var/([^/]+/)?cache/(texttoimage|public)/.* - [L]
        RewriteRule ^/design/[^/]+/(stylesheets|images|javascript)/.* - [L]
        RewriteRule ^/share/icons/.* - [L]
        RewriteRule ^/extension/[^/]+/design/[^/]+/(stylesheets|flash|images|javascripts?)/.* - [L]
        Rewriterule ^/packages/styles/.+/(stylesheets|images|javascript)/[^/]+/.* - [L]
        RewriteRule ^/packages/styles/.+/thumbnail/.* - [L]
        RewriteRule ^/favicon\.ico - [L]
        RewriteRule ^/robots\.txt - [L]
        # Uncomment the following lines when using popup style debug.
        # RewriteRule ^/var/cache/debug\.html.* - [L]
        # RewriteRule ^/var/[^/]+/cache/debug\.html.* - [L]
        RewriteRule .* /index.php
    </IfModule>
 
    DocumentRoot /var/www/ezpub/web
    ServerName ezpub
</VirtualHost>

/etc/init.d/apache2 restart

