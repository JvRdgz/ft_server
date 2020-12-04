#!bin/bash

# Creacion del contenedor
docker build -t ft_server:1.0 .

# Lanzamiento del servidor
docker run -it -p 80:80 -p 443:443 ft_server:1.0
