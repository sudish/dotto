#!/bin/zsh

local output
if [ -n "$SSH_TTY" ]; then
    if which tmux >/dev/null; then
        if output=`tmux list-sessions`; then
            echo "** TMUX\n$output"
        fi
    fi
    if which screen >/dev/null; then
        screen -ls >/dev/null 2>&1
        if [ $? -gt 10 ]; then
            echo "** SCREEN\n`screen -ls`"
        fi
    fi
fi
