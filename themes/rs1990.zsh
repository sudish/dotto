
if [ "$TERM" = "xterm" -o "$TERM" = "rxvt" ]; then
        XTERMPROMPT=$(echo -n "\e]0;%m - %n\07")
fi

#if [ "$INSCREEN" = 1  ]; then
#    SCREENNULLPROMPT=$(echo -n "\033k\033\\")
#else
#    SCREENNULLPROMPT=""
#fi

# the magic prompt, oh yes
PS1="%{$SCREENNULLPROMPT%}%{$XTERMPROMPT%}%(0#.%S.%B)%n%(0#.%s.%b){%m}%B%~%b%(#.#.$) "
RPROMPT="%(?..[%?])"


