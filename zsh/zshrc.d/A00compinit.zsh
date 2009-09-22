#!/bin/zsh

# redefine menu-select widget, other goodies
zmodload -i zsh/complist

autoload -U compinit

# compinit, but don't dump if we're sudo/su
local compinit_args
compinit_args=(-C)

[[ ! -O $HOME ]] && compinit_args+=(-D)
compinit ${compinit_args}

# -*- Mode: Shell Script; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
