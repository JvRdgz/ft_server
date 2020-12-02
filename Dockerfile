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
RUN	apt-get update && 
	apt-get upgrade -y && \
	apt-get install -y \
	nginx \
	mariadb-server \
	php7.3 \
	php7.3-fpm \
	php7.3-mysql \
	php7.3-curl \
	php7.3-mbstring \
	openssl \

# Cambiamos el propietario y grupo del directorio /var/www/ y damos permisos a ese directorio.
RUN	chown -R www-data:www-data /var/www/* && \
	chmod 775 -R /var/www/html/




##############################################################################
#################    CONFIFURACION DEL PROTOCOLO SSL	######################
##############################################################################

RUN	openssl genrsa -out /etc/ssl/private/nginx.key 4096 && \
	openssl req -x509 -nodes -days 365 -newkey rsa:2048 -subj "/C=SP/ST=Spain/L=Madrid/O=42Madrid/CN=127.0.0.1" -keyout /etc/ssl/private/localhost.key -out /etc/ssl/certs/localhost.crt && \




##############################################################################
#################	CONFIFURACION DE PHPMYADMIN	######################
##############################################################################

# Descargamos el archivo php.tar.gz, lo descomprimimos, eliminarmos el .tar y lo movemos al
# directorio var/www/html/phpmyadmin. El flag -c evita que se interrumpa la descarga en caso de
# fallo de conexion. Si falla la conexion, la descarga continua por donde se quedo.
RUN	wget -c https://files.phpmyadmin.net/phpMyAdmin/5.0.4/phpMyAdmin-5.0.4-all-languages.tar.gz && \
	tar xvf phpMyAdmin.5.0.4-all-languages.tar.gz && \
	rm phpMyAdmin.5.0.4-all-languages.tar.gz && \
	mv phpMyAdmin-5.0.4-all-languages /var/www/html/ && \

# Copiamos nuestro archivo config.inc.php modificado y el info.php y los metemos en la imagen.
COPY	./srcs/phpMyAdmin-5.0.4-all-languages/config.inc.php /var/www/html/phpmyadmin-5.0.4-all-languages/
COPY	./srcs/phpMyAdmin-5.0.4-all-languages/info.php ./



##############################################################################
#################	CONFIGURACION DE WORDPRESS	######################
##############################################################################

# Descargamos el directorio wordpress.org/latest.tar.gz, lo descomprimimos, eliminamos el .tar,
# cogemos el wp-config.php y lo movemos al directorio var/www/html/wordpress.
RUN	wget -c https://wordpress.org/latest.tar.gz && \
	tar xvf latest.tar.gz && \
	rm latest.tar.gz && \
	mv wordpress /var/www/html/

# Copiamos nuestro archivo wp-config.php modificado y lo metemos en la imagen.
COPY	./srcs/wordpress/wp-config.php /var/www/html/wordpress/




##############################################################################
#################	CONFIGURACION DE NGINX		######################
##############################################################################

# Copiamos los archivos de configuracin del nginx y mi index.html y los pegamos en el workspace
COPY	./srcs/nginx-conf/*.sh ./
COPY	./srcs/nginx-conf/*.conf ./
COPY	./srcs/nginx-conf/index.html ./

# Eliminamos el archivo de configuracion del nginx que viene por defecto. Despues,
# movemos los dos archivos de configuracion al directorio sites-availables del nginx
# porque aqui es donde se va a ejecutar el archivo correspondiente. Luego tenemos
# que crear un enlace simbolico (por defecto elegimos el archivo del autoindex on) entre
# el archivo de configuracion seleccionado con el directorio enabled para que utilice
# esa configuracion.
RUN	rm /etc/nginx/sites-enabled/default && \
	mv /tmp/*.conf /etc/nginx/sites-available/ && \
	ln -s /etc/nginx/sites-available/nginx.autoindes.on.conf /etc/nginx/sites-enabled/ && \
	rm /var/www/html/*.html




##############################################################################
#################  PUERTOS DE ESCUCHA DE LOS SERVIDORES  #####################
##############################################################################

EXPOSE 80 443




##############################################################################
#################	INICIALIZACION DE SERVICIOS	######################
##############################################################################

CMD bash /tmp/init_services.sh
