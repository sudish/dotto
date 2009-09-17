#!/bin/zsh

local output
if [ -n "$SSH_TTY" ]; then
    if which tmux 2>/dev/null; then
        if output=`tmux list-sessions`; then
            echo $output
        fi
    fi
    if which screen 2>/dev/null; then
        if output=`screen -ls`; then
            echo $output
        fi
    fi
fi
