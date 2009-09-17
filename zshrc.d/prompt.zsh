#!/bin/zsh

# Setup the prompt with pretty colors
setopt prompt_subst

typeset -g -A zthemevars

ztheme_reset() {
    zthemevars=

    for funcname in preexec precmd chpwd periodic; do
        eval "function ztheme_${funcname} () { }"
        typeset -g -a "${funcname}_functions"
        set_add "${funcname}_functions" "ztheme_${funcname}"
    done
}

ztheme() {
  if [ "$1" = "-l" ]; then
    ls -1 $ZCONFIGDIR/themes | sed -e 's/.zsh-theme$//'
  elif [ -n "$1" ]; then
    ZSH_THEME=$1
  else
    echo "Current theme is $ZSH_THEME"
    return
  fi
  
  local file="$ZCONFIGDIR/themes/$ZSH_THEME.zsh-theme"
  
  if [ -f $file ]; then
    RPROMPT=''
    PS1='%m%#  '
    PS2='%_> '
    PS3='?# '
    PS4='+%N:%i> '
    ztheme_reset
    source "$ZCONFIGDIR/themes/$ZSH_THEME.zsh-theme"
  fi
}


if [ -n "$ZSH_THEME" ]; then
  ztheme $ZSH_THEME
else
  ztheme_reset
fi

typeset -g -H PS1 PS2 PS3 PS4 RPS1 RPS2 PROMPT PROMPT2 PROMPT3 RPROMPT prompt


