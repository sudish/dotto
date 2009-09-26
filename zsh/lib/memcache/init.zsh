#!/bin/zsh
#
#   Simple interface to memcache
#  
#

local libdir=${0:h}

typeset -g -A -H memcache_vars
typeset -g -A -H memcache_servers


function memcache_reset() {
  emulate -L zsh

  for var in last_opened_server last_opened_fd; do
    unset "memcache_vars[$var]"
  done
}

function memcache_setup() {
  zmodload zsh/net/tcp || { echo "zsh/net/tcp module not available for memcache"; return 2 }
  zmodload zsh/system || { echo "zsh/system module not available for memcache"; return 2 }

  uselib zcron
  zcron add 30 memcache:periodic

  memcache_vars[enabled]=1
  memcache_vars[persistent]=0

  memcache_vars[default_timeout]=3600
  memcache_vars[default_port]=11211
  
  dotto_session_id > /dev/null
  memcache_vars[default_prefix]="zsh.$REPLY"
  
  memcache_servers[localhost:11211]="1"

  memcache_reset
}

local _zfile _zdir

for _zfile in $libdir/functions/*(.N); do
  autoload -Uk ${_zfile:t}
done

for _zdir in $libdir/functions/*:(/N); do
  fpath+=$_zdir
  for _zfile in $_zdir/*(.); do
    autoload -Uk ${_zfile:t}
  done
done

# setup in current dir
memcache_setup ${0:h}
