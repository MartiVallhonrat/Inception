#!/bin/bash

sleep 15

if [ ! -f ./wp-config.php ]
then
	echo "Setting up wordpress..."
	cd /var/www/html
	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	./wp-cli.phar core download --allow-root
	./wp-cli.phar config create --dbname=$DB_NAME --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --allow-root
	./wp-cli.phar core install --url=$DOMAIN_NAME --title=$WP_TITLE --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email --allow-root
	./wp-cli.phar user create $WP_USER --role=author --user_pass=$WP_USER_PASSWORD --allow-root
	./wp-cli.phar theme install twentytwentyfour --activate --allow-root
else
	echo "Wordpress is alredy setted"
fi

/usr/sbin/php-fpm8.2 -F;
