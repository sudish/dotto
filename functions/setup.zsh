#!/bin/zsh

for file in $ZCONFIGDIR/functions/*; do
  zcbase=`basename $file`
  if [ $zcbase != "setup.zsh" ]; then
    autoload -U $zcbase
  fi
done
unset $zcbase
