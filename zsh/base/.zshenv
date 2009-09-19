#!/bin/zsh

if [ -z "$ZCONFIGDIR" ]; then
   for zbase in $HOME $HOME/config $HOME/.rsconfig $HOME/home; do
     for zfilesdir in .zdir zdir .zfiles zfiles .zconfig zconfig; do
       if [ -d "$zbase/$zfilesdir" ]; then
         export ZCONFIGDIR="$zbase/$zfilesdir"
         break 2
       fi
     done
   done
fi

unset zbase zfilesdir

if [ -n "$ZCONFIGDIR" -a -d "$ZCONFIGDIR" ]; then
  . $ZCONFIGDIR/core/zshenv
fi

