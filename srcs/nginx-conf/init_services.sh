#!bin/bash

# Inicializacion de servicios
service php7.3-fpm start
service mysql start
service nginx start

# Construccion de la base de datos 'wordpress'
echo "CREATE DATABASE wordpress;" | mysql -u root
echo "GRANT ALL PRIVILEGES ON wordpress.* TO 'root'@'localhost';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "UPDATE mysql.user SET plugin = 'mysql_native_password' WHERE user='root';" | mysql -u root
mysql -u root < /var/www/html/phpMyAdmin-5.0.4-all-languages/sql/create_tables.sql

echo "quit" | mysql -u root

bash
