#!/bin/bash

[[ -e a.out ]] && rm -v a.out
gcc -O0 -g -DNESTING_MAX=1 sstack.c
./a.out

[[ -e a.out ]] && rm -v a.out
gcc -O0 -g -DNESTING_MAX=5 sstack.c
./a.out

gdb -ex 'break sstack.c:33' -ex 'run' ./a.out