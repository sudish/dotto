#!/bin/zsh

emulate -L zsh
unsetopt warn_create_global
test -r /sw/bin/init.sh && . /sw/bin/init.sh
