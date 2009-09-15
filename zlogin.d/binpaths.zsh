#!/bin/zsh

pwd=`pwd`
for dir in $HOME/bin/paths/* $HOME/bin; do
    cd $dir
    realdir=`/bin/pwd -P`
    PATH=${realdir}:${PATH}
done
cd $pwd
