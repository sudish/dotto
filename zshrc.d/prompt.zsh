
# Directory stuff.
setopt AUTO_NAME_DIRS

# Speed stuff.
setopt AUTO_CD
setopt MULTIOS
setopt CDABLEVARS

#setopt NO_BEEP

if [[ x$WINDOW != x ]]
then
    SCREEN_NO="%B$WINDOW%b "
else
    SCREEN_NO=""
fi

PS1="%n@%m:%~%# "

# Setup the prompt with pretty colors
setopt prompt_subst

export LSCOLORS="Gxfxcxdxbxegedabagacad"

RPROMPT=''
ztheme() {
  if [ "$1" = "-l" ]; then
    ls -1 $ZCONFIGDIR/themes | sed -e 's/.zsh-theme$//'
  elif [ -n "$1" ]; then
    ZSH_THEME=$1
    RPROMPT=
    PS1='%m%#  '
    PS2='%_> '
    PS3='?# '
    PS4='+%N:%i> '
  else
    echo "Current theme is $ZSH_THEME"
  fi
  source "$ZCONFIGDIR/themes/$ZSH_THEME.zsh-theme"
}

if [ -n "$ZSH_THEME" ]; then
  ztheme $ZSH_THEME
fi
