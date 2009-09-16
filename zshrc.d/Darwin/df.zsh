df () {
   if [ -x /usr/local/lib/cw/df ]; then
        /usr/local/lib/cw/df "${(@)*}" 2>>(grep -v "negative filesystem block")
   else
        command df "${(@)*}"
   fi
}


