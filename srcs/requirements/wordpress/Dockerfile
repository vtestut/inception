FROM debian:bullseye

EXPOSE 9000

ARG PHPPATH=/etc/php/7.4/fpm

RUN apt update && apt install --no-install-recommends --no-install-suggests -y \
		ca-certificates \
		php7.4-fpm \
		php7.4-mysql \
		wget \
		sendmail \
		tar && \
		rm -rf /var/lib/apt/lists/*

RUN service php7.4-fpm stop

COPY conf/www.conf ${PHPPATH}/pool.d/

# Modifications dans PHP-FPM :
# - Desactivation de cgi.fix_pathinfo pour la securite
# - PHP-FPM ecoutera sur le port 9000 au lieu du fichier socket
# - Activation de listen.mode pour fixer les permissions du socket
# - Empêcher PHP-FPM de tourner en arrière-plan (important pour Docker)
RUN sed -i 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' ${PHPPATH}/php.ini && \
	sed -i "s/listen = \/run\/php\/php$PHP_VERSION_ENV-fpm.sock/listen = 9000/g" ${PHPPATH}/pool.d/www.conf && \
	sed -i 's/;listen.mode = 0660/listen.mode = 0660/g' ${PHPPATH}/pool.d/www.conf && \
	sed -i 's/;daemonize = yes/daemonize = no/g' ${PHPPATH}/pool.d/www.conf

# installation de WPCLI pour gerer WP via la ligne de cmde
RUN wget --no-check-certificate https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
	chmod +x wp-cli.phar && \
	mv wp-cli.phar /usr/local/bin/wp

# necessaire pour PHP et WoP
RUN mkdir -p /run/php/ && \
	mkdir -p /var/run/php/ && \
	mkdir -p /var/www/inception/

COPY conf/wp-config.php /tmp/

COPY tools/setup.sh /bin/
RUN chmod +x /bin/setup.sh

CMD ["setup.sh", "php-fpm7.4", "--nodaemonize"]
