#!/bin/bash

mysql_install_db
sleep 5
service mariadb start;

#mysql --verbose -u ${MYSQL_ROOT} -e "ALTER USER '${MYSQL_ROOT}'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; FLUSH PRIVILEGES;"
mysqladmin -u ${MYSQL_ROOT} password "$MYSQL_ROOT_PASSWORD; FLUSH PRIVILAGES;"

DB_EXISTS=$(mysql -u ${MYSQL_ROOT} -p${MYSQL_ROOT_PASSWORD} -e "SHOW DATABASES LIKE '${DB_NAME}';" | grep ${DB_NAME})

if [ -n "$DB_EXISTS" ];
then
	echo "Mariadb $DB_NAME database exists."
else
	echo "Mariadb $DB_NAME database does not exist."
	mysql --verbose -u ${MYSQL_ROOT} -p${MYSQL_ROOT_PASSWORD} -e "CREATE DATABASE $DB_NAME; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MYSQL_ROOT} -p${MYSQL_ROOT_PASSWORD} -e "CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MYSQL_ROOT} -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER '${DB_USER}'@'%' IDENTIFIED BY '${DB_USER_PASSWORD}'; FLUSH PRIVILEGES;"
	mysql  --verbose -u ${MYSQL_ROOT} -p${MYSQL_ROOT_PASSWORD} -e "GRANT ALL ON $DB_NAME.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD' WITH GRANT OPTION; FLUSH PRIVILEGES;"
fi

mysqladmin -u ${MYSQL_ROOT} --password=${MYSQL_ROOT_PASSWORD} shutdown

mysqld
