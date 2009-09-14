if [ -f "$HOME/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}" ]; then
    source ~/.zkbd/$TERM-${DISPLAY:-$VENDOR-$OSTYPE}
    [[ -n ${key[Left]} ]] && bindkey "${key[Left]}" backward-char
    [[ -n ${key[Right]} ]] && bindkey "${key[Right]}" forward-char
    # etc.
fi


