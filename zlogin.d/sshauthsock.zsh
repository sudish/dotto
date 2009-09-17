#!/bin/zsh

if [ -n "$SSH_AUTH_SOCK" -a "$SHLVL" = 1 -a -z "$TMUX" -a -z "$SCREEN" ]; then
  echo "SSH_AUTH_SOCK=$SSH_AUTH_SOCK" >! ~/.sshagent
fi
