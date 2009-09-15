#!/bin/zsh

local zpwd realpath
for dir in $HOME/bin/paths/* $HOME/bin; do
    realpath=$(cd $dir; unset PWD; /bin/pwd)
done
unset zpwd realpath

