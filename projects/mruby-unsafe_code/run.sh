#!/bin/bash

trap "[[ -f /etc/app-password ]] && sudo rm -v /etc/app-password" EXIT
sudo bash -c 'echo -n MyP@ssw0rd > /etc/app-password'
./mruby/bin/mruby -e 'p UnsafeCode.check "invalid_password"'
./mruby/bin/mruby -e 'p UnsafeCode.check "MyP@ssw0rd"'
./mruby/bin/mruby -e 'p UnsafeCode.check "X"*32'
./mruby/bin/mruby -e 'p UnsafeCode.check "X"*64'

