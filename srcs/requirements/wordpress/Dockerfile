FROM debian:latest

RUN apt-get update && apt upgrade -y 
RUN apt-get install -y php php8.2-fpm php8.2-mysqli mariadb-client curl

COPY ./conf/www.conf /etc/php/8.2/fpm/pool.d/www.conf

RUN mkdir -p /run/php
RUN chmod 777 /run/php

COPY ./tools/script.sh /usr/local/bin/script.sh
RUN chmod +x /usr/local/bin/script.sh

EXPOSE 9000

WORKDIR /var/www/html/

ENTRYPOINT ["/usr/local/bin/script.sh"]
