#!/bin/bash

set -x

sudo cp -vpf dyn-proxy.conf /etc/apache2/sites-enabled/
sudo cp -vff dyn-proxy.rb /var/lib/mruby/dyn-proxy.rb
sudo cp -vff circuit-breaker.rb /var/lib/mruby/circuit-breaker.rb

sudo a2enmod proxy
sudo a2enmod proxy_http
sudo service apache2 restart