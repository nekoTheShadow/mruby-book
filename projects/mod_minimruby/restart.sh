#!/bin/bash

set -x

rake mod
sudo rake install

sudo cp -vpf minimruby.conf /etc/apache2/sites-enabled
sudo a2enmod minimruby
sudo service apache2 restart

curl -v http://localhost/minitest
curl -v http://localhost/errtest