#!/bin/zsh

zctrace "running muxers..."

local output
if [ -n "$SSH_TTY" -a -z "$TMUX" -a "$SHLVL" -le 1 -a "$TERM" != "screen" ]; then
    if which tmux >/dev/null; then
        if output=`tmux list-sessions 2>/dev/null`; then
            echo "** TMUX\n$output"
        fi
    fi
    if which screen >/dev/null; then
        screen -q -ls >/dev/null
        if [ $? -gt 10 ]; then
            echo "** SCREEN\n`screen -ls`"
        fi
    fi
fi
