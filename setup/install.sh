#!/usr/bin/env zsh
if [ -z "$ZCONFIGDIR" ]; then
  ZCONFIGDIR=`dirname $0`/..
fi

for zfile in $ZCONFIGDIR/base/*; do
  basefile=`basename $zfile`
  dotfile=.$basefile
  echo "Backing up $dotfile"
  mv -n $HOME/$dotfile $HOME/${dotfile}.prezfiles
  cp -f $zfile $HOME/$dotfile
done


