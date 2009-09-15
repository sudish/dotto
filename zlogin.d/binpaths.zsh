#!/bin/zsh

local zpwd 
zpwd=`pwd`
for dir in $HOME/bin/paths/* $HOME/bin; do
    cd $dir
    PATH=`/bin/pwd -P`:${PATH}
done
cd $zpwd
unset zpwd

