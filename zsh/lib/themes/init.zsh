#!/bin/zsh

# Setup the prompt with pretty colors
setopt prompt_subst

typeset -g -A zthemevars

ztheme_setup() {
    fpath+=$ZCONFIGDIR/themes
    
    source ${1}/promptinit.zsh
    promptinit

    if [ -n "$ZSH_THEME" ]; then
        prompt $ZSH_THEME
    fi
}

typeset -g -H PS1 PS2 PS3 PS4 RPS1 RPS2 PROMPT PROMPT2 PROMPT3 RPROMPT prompt

zshrc_files+="${0:h}/librc.zsh"



