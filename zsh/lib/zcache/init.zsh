#!/bin/zsh
#
#   Simple interface to memcache
#  
#

local libdir=${0:h}

typeset -g -A -H zcache_vars
typeset -g -A -H zcache_servers


function zcache_reset() {
  emulate -L zsh

  for var in last_opened_server last_opened_fd; do
    unset "zcache_vars[$var]"
  done
}

function zcache_setup() {
  zmodload zsh/net/tcp || { echo "zsh/net/tcp module not available for zcache"; return 2 }
  zmodload zsh/system || { echo "zsh/system module not available for zcache"; return 2 }

  zcache_vars[enabled]=1
  zcache_vars[persistent]=0

  zcache_vars[default_timeout]=3600
  zcache_vars[default_port]=11211
  
  dotto_session_id > /dev/null
  zcache_vars[default_prefix]="zsh.$REPLY"
  
  zcache_servers[localhost:11211]="1"

  zcache_reset
}

local _zfile

for _zfile in $libdir/functions/*; do
  autoload -Uk ${_zfile:t}
done

# setup in current dir
zcache_setup ${0:h}
