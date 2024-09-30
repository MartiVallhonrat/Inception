FROM debian:latest

RUN apt-get update 
RUN apt-get install -y mariadb-server

EXPOSE 3306

RUN mkdir -p /run/mariadb
COPY ./tools/script.sh /run/mariadb/script.sh
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

RUN chmod +x /run/mariadb/script.sh

ENTRYPOINT ["bash", "/run/mariadb/script.sh"]
