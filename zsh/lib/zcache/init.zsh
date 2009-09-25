#!/bin/zsh
#
#   Simple interface to memcache
#  
#

local libdir=${0:h}

typeset -g -A -H zcache_vars
typeset -g -A -H zcache_servers

function zcache_reset() {
    # nothing
}

function zcache_setup() {
  zmodload zsh/net/tcp || { echo "zsh/net/tcp module not available for zcache"; return 2 }

  zcache_vars[enabled]=1

  zcache_reset
}

local _zfile

for _zfile in $libdir/functions/*; do
  autoload -Uk ${_zfile:t}
done

# setup in current dir
zcache_setup ${0:h}
