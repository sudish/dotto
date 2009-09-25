#!/bin/zsh

local zpwd realpath tempdir
for tempdir in $HOME/bin/paths/* $HOME/bin; do
  zrealpath $tempdir && realpath=$REPLY && path+=$realpath
done >/dev/null 2>/dev/null

unset zpwd realpath tempdir
