# !bin/bash

# Esta configuracion, elimina la configuracion del servidor que indica
# que el autoindex esta en modo on. Despues, crea un enlace simbolico del
# archivo de configuracion del nginx que pone el autoindex off utiliza los
# archivos index por defecto.

# Despues, movemos nuestro archivo index.html personalizado a la ruta de los
# /html.
# Una vez hecho todo esto, reiniciamos el servidor.

rm /etc/nginx/sites-enabled/nginx.autoindex.on.conf
ln -s /etc/nginx/sites-available/nginx.autoindex.off.conf /etc/nginx/sites-enabled/
mv /tmp/index.html /var/www/html/
service nginx restart
