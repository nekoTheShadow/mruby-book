#!/bin/bash

set -x

sudo apxs -a -c -i mod_minimruby.c 

sudo cp -vpf minimruby.conf /etc/apache2/sites-enabled
sudo a2dismod mruby
sudo rm -v /etc/apache2/sites-enabled/dyn-proxy.conf

sudo a2enmod minimruby
sudo service apache2 restart

curl -v http://localhost/minitest