# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Dockerfile                                         :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: jarodrig <marvin@42.fr>                    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2020/11/18 20:04:48 by jarodrig          #+#    #+#              #
#    Updated: 2020/11/23 20:29:22 by jarodrig         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

# Instalacion de la imagen seleccionada de Docker Hub: Debian Buster(version)
FROM debian:buster

LABEL maintainer="github.com/JvRdgz"

# Directorio de trabajo
WORKDIR /tmp



##############################################################################
#################	INSTALACION DE SERVICIOS	######################
##############################################################################

# nginx ==> Servidor
# mariadb-server ==> Motor de base de datos, con mejor rendimiento que MySQL
# php-fpm ==> Interprete del lenguaje PHP para separar el servicio, de las peticiones del servidor.
# php-mysql ==> Permite conexion con la base de datos de MySQL.
# php-curl ==> Permite realizar peticiones http a servidores remotos.
# php-mbstring ==> Proporciona funciones de cadenas de texto multibyte para PHP. (+256 caracteres).
# openssl ==> Libreria para cifrar trafico de datos etre el servidor/cliente o visitante y viceversa.
# No es una buena practica crear una imagen con el comando apt-get update, dado que provoca que se
# actualicen paquetes de apt que se guardan en cache y probablemente no sean necesarios.
# Instalo todos los paquetes y programas necesarios.
RUN apt-get update && 
	apt-get upgrade -y && \
	apt-get install -y \
	nginx \
	mariadb-server \
	php \
	php-fpm \
	php-mysql \
	php-curl \
	php-mbstring \
	openssl \

# Cambiamos el propietario y grupo del directorio /var/www/ y damos permisos a ese directorio.
RUN	chown -R www-data:www-data /var/www/* && \
	chmod 775 -R /var/www/html/



##############################################################################
#################	CONFIFURACION DE PHPMYADMIN	######################
##############################################################################

# Descargamos el archivo php.tar.gz, lo descomprimimos, eliminarmos el .tar y lo movemos al
# directorio var/www/html/phpmyadmin. El flag -c evita que se interrumpa la descarga en caso de
# fallo de conexion. Si falla la conexion, la descarga continua por donde se quedo.
RUN wget -c https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
	tar xvf phpMyAdmin.5.0.4-all-languages.tar.gz && \
	rm phpMyAdmin.5.0.4-all-languages.tar.gz && \
	mv phpMyAdmin-5.0.4-all-languages /var/www/html/ && \

# Copiamos nuestro archivo config.inc.php modificado y lo metemos en la imagen.
COPY	./srcs/phpMyAdmin-5.0.4-all-languages/config.inc.php /var/www/html/phpmyadmin-5.0.4-all-languages/



##############################################################################
#################	CONFIGURACION DE WORDPRESS	######################
##############################################################################

# Descargamos el directorio wordpress.org/latest.tar.gz, lo descomprimimos, eliminamos el .tar,
# cogemos el wp-config.php y lo movemos al directorio var/www/html/wordpress.
RUN wget -c https://wordpress.org/latest.tar.gz && \
	tar xvf latest.tar.gz && \
	rm latest.tar.gz && \
	mv wordpress /var/www/html/

# Copiamos nuestro archivo wp-config.php modificado y lo metemos en la imagen.
COPY	./srcs/wordpress/wp-config.php /var/www/html/wordpress/
