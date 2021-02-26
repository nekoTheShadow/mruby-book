#!/bin/bash

set -x

rake mod
sudo rake install

sudo cp -vpf minimruby.conf /etc/apache2/sites-enabled
sudo a2enmod minimruby
sudo service apache2 restart

curl http://localhost/errtest
curl http://localhost/htmltest
curl -X POST -d "BODY" "http://localhost/htmltest?arg1=ABC&arg2=DEF"