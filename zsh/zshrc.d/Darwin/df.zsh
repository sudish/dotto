#!/bin/zsh

df () {
   typeset -a dasht
   dasht=(-T nowebdav)

   [[ -n $*[(r)-T] || -n $*[(r)-l] ]] && dasht=()
   
   if [ -x /usr/local/lib/cw/df ]; then
        /usr/local/lib/cw/df -h $dasht "${(@)*}" 2>>(grep -v "negative filesystem block")
   else
        command df -h $dasht "${(@)*}"
   fi
}

