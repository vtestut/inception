FROM	debian:bullseye

EXPOSE	443

RUN		apt update && apt install -y --no-install-recommends --no-install-suggests \
		nginx \
		openssl && \
		rm -rf /var/lib/apt/lists/*

# generation du certificat SSL auto signe
RUN		mkdir -p /etc/nginx/certs/ && \
		openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
		-out /etc/nginx/certs/certificate.crt \
		-keyout /etc/nginx/certs/certificate.key \
		-subj "/C=FR/ST=IDF/L=paris/O=42/OU=42/CN=vtestut.42.fr"

COPY	conf/nginx.conf	/etc/nginx/
COPY	conf/server.conf	/etc/nginx/conf.d/

RUN		mkdir -p /var/www/
RUN		chown -R www-data:www-data /var/www/

CMD		["nginx", "-g", "daemon off;"]