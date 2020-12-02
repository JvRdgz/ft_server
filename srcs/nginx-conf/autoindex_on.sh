# !bin/bash

# Esta configuracion, elimina la configuracion del servidor que indica
# que el autoindex esta en modo off. Despues, crea un enlace simbolico del
# archivo de configuracion del nginx que pone el autoindex on que utiliza nuestro
# archivo index.html personalizado.

# Despues, mueve el archivo por defecto index.html que se encuentra en el directorio
# /var/www/html/ al directorio de trabajo /tmp
# Una vez hecho todo esto, reiniciamos el servidor.

rm /etc/nginx/sites-enabled/nginx.autoindex.off.conf
ln -s /etc/nginx/sites-available/nginx.autoindex.on.conf /etc/nginx/sites-enabled/
mv /var/www/html/index.html /tmp
service nginx restart
