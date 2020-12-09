# ft_server by Javier Rodriguez Montero.

# Content

* [What this server does?](#what-this-server-does-?)
* [Requisites to run this server](#requisites-to-run-this-server)
* [How to install it](#how-to-install-it)
* [How it works?](#how-it-works-?)
* [How to run it](#how-to-run-it)

## What this server does?
This server is able to run several services at the same time. It uses **Docker**
technology to install a complete web server. The services that it runs are:

* Wordpress.
* PhpMyAdmin.
* SQL database.

## Requisites to run this server

<br>As I mentioned above, it uses Docker technology, so in order to
run this project, you need to have Docker installed on your local machine.
You can check how to install **Docker** on your machine clicking [here](https://docs.docker.com/engine/install/).</br>
<br>It is recommended to use a Unix operating system to run this project, but 
it is not a mandatory option.</br>
<br>You should have root permissions in order to run docker commands.</br>

## How to install it
Type this commands on your terminal or on your CMD
```
git clone https://github.com/JvRdgz/ft_server
cd ft_server
```

## How it works?
<br>It runs a Nginx server in a Debian:buster container. Once the server is running, it
starts PhpMyAdmin and Wordpress services. Then, it creates a MySQL Database that
works with PhpMyAdmin, as well as in Wordpress. This server also uses SSL protocol
but it is not certificated. You can certificate it by your own.</br>
<br>Once everything is running, you could start developing your own web server!</br>

## How to run it
First, you need to create the container and then, you need to run the image.
But... How do we do that? Well, once you've clone this repository on your local, 
i've made to ``.sh`` scripts that makes everything for you ;).
Just inside of the ft_server folder, you will see two scripts:
```
execute_server_linux.sh
execute_server_macosx.sh
```
Obviously, depends on which Operating system you are using, you will need yo run
one script or the other. To run it, you can simply use:
```
sh execute_server_....sh
```
It will take a few minutes to prepare and install all the programs that are specified
on the Dockerfile.
Now you are inside the container running the Nginx web server. If you want
to check if it is working, you need to open your web browser and type this url:
```
localhost
```
Then, it will show the PhpMyAdmin and Wordpress directories and you can feel free
to surf between them.
Okey, now if you have some Nginx knowledgement you can see that in the actual
directory that you are now ``/tmp`` you can see ``ls -la`` that there are two
script called ``autoindex_off.sh`` and ``autoindex_on.sh``.
Those scripts modifies the autoindex instruction from the Nginx configuration file.
At this moment, you are running the "default" Nginx configuration file, with the
``autoindex on``. But, if you run the ``autoindex_off.sh`` script, it will turn
the autoindex instruction to *on* and if you reload the localhost web page that you
run before on your web browser, it will shows a custom ``index.html`` file. This
file are in the ``/var/www/html/`` directory, and by this way you can make your
on web page!! Isn't that awesome?
Eventually, if you want to close and stop the webserver, you have to type inside
the container this command:
```
exit
```
This command will stop the container and, therefore, stop the Nginx server, since
the container runs only locally.
Hope you like it!
