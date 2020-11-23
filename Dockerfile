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

# nginx ==> Servidor
# mariadb-server ==> Motor de base de datos, con mejor rendimiento que MySQL
# php-fpm ==> Interprete del lenguaje PHP para separar el servicio, de las peticiones del servidor.
# php-mysql ==> Permite conexion con la base de datos de MySQL.
# php-mbstring ==> Proporciona funciones de cadenas de texto multibyte para PHP. (+256 caracteres).
# openssl ==> Libreria para cifrar trafico de datos etre el servidor/cliente o visitante y viceversa.
# No es una buena practica crear una imagen con el comando apt-get update, dado que provoca que se
# actualicen paquetes de apt que se guardan en cache y probablemente no sean necesarios.
RUN apt-get update && \
	apt-get install -y \
	nginx \
	mariadb-server \
	php-fpm \
	php-mysql \
	php-mbstring \
	openssl \
