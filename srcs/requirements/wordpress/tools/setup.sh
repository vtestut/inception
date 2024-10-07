#!/bin/bash

chown -R www-data:www-data /var/www/inception/

if [ ! -f "/var/www/inception/wp-config.php" ]; then
   mv /tmp/wp-config.php /var/www/inception/
fi

sleep 10

wp --allow-root --path="/var/www/inception/" core download || true

if ! wp --allow-root --path="/var/www/inception/" core is-installed;
then
    wp  --allow-root --path="/var/www/inception/" core install \
        --url=$WP_URL \
        --title=$SITE_TITLE \
        --admin_user=$ADMIN_USER \
        --admin_password=$ADMIN_PASSWORD \
        --admin_email=$ADMIN_EMAIL
    wp --allow-root --path="/var/www/inception/" plugin delete hello
    wp --allow-root --path="/var/www/inception/" plugin delete akismet
fi;

if ! wp --allow-root --path="/var/www/inception/" core is-installed;
then
    echo "Failed to install wordpress"
    exit 1
fi;

if ! wp --allow-root --path="/var/www/inception/" user get $USER1_LOGIN 2>/dev/null;
then
    wp  --allow-root --path="/var/www/inception/" user create \
        $USER1_LOGIN \
        $USER1_EMAIL \
        --user_pass=$USER1_PASSWORD \
        --role=$USER1_ROLE
fi;

chown -R www-data:www-data /var/www/inception/
chmod -R 755 /var/www/*

exec $@