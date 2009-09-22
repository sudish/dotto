#!/bin/zsh

# redefine menu-select widget, other goodies
zmodload -i zsh/complist

autoload -U compinit

# compinit, but don't dump if we're sudo/su
local compinit_arg
[[ -O $HOME && -z $SUDO_USER ]] || compinit_arg="-D"
compinit -u ${compinit_arg}

zctrace "compinit args was ${compinit_arg}"

# -*- Mode: Shell Script; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
