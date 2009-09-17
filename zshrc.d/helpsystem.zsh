#!/bin/zsh

unalias run-help 2>/dev/null
autoload -U run-help
bindkey -s "`echotc k1`" "run-help "