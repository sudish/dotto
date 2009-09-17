#!/bin/zsh

local output
if [ -n "$SSH_TTY" ]; then
    if which tmux >/dev/null; then
        if output=`tmux list-sessions`; then
            echo "** TMUX\n$output"
        fi
    fi
    if which screen >/dev/null; then
        if output=`screen -ls`; then
            echo "** SCREEN\n$output"
        fi
    fi
fi
