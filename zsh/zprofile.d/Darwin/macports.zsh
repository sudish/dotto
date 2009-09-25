#!/bin/zsh

emulate -L zsh
unsetopt warn_create_global

# add macports if not already present
if [[ -d /opt/local/bin && -z $path[(r)/opt/local/bin] ]]; then
  manpath+=/opt/local/man
  manpath+=/opt/local/share/man
  path+=/opt/local/bin
fi

[[ $UID == 0 && -z $path[(r)/opt/local/sbin] ]] && path+=/opt/local/sbin
