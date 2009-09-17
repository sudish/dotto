#!/bin/zsh

df () {
   if [ -x /usr/local/lib/cw/df ]; then
        /usr/local/lib/cw/df -h -T nowebdav "${(@)*}" 2>>(grep -v "negative filesystem block")
   else
        command df -h -T nowebdav "${(@)*}"
   fi
}

