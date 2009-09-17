
function ztheme_precmd {

    local TERMWIDTH
    (( TERMWIDTH = ${COLUMNS} - 1 ))


    ###
    # Truncate the path if it's too long.
    
    PR_FILLBAR=""
    local PR_PWDLEN=""
    
    typeset -A -L altchar
    set -A altchar ${(s..)terminfo[acsc]}
    local PR_HBAR=${altchar[q]:--}
    
    local promptsize=${#${(%):---(%n@%m:%l)---()--}}
    local pwdsize=${#${(%):-%~}}
    
    if [[ "$promptsize + $pwdsize" -gt $TERMWIDTH ]]; then
	    (( PR_PWDLEN=$TERMWIDTH - $promptsize ))
    else
	    PR_FILLBAR="\${(l.(($TERMWIDTH - ($promptsize + $pwdsize)))..${PR_HBAR}.)}"
    fi

    vcs_info

    PR_APM=''
    PR_APM_RESULT=''
}


setopt extended_glob
function ztheme_preexec () {
    if [[ "$TERM" == "screen" ]]; then
	  local CMD=${1[(wr)^(*=*|sudo|-*)]}
	  echo -n "\ek$CMD\e\\"
    fi
}

autoload -Uz vcs_info

function old_box_prompt_info() {
  local CURRENT_BRANCH
  if [[ -d .git ]]; then
    local ref=$(git symbolic-ref HEAD 2> /dev/null) || return
    local branch=${ref#refs/heads/}
    CURRENT_BRANCH="git:($PR_MAGENTA${branch}$PR_YELLOW)$PR_NO_COLOUR$(parse_git_dirty)"
  else
    CURRENT_BRANCH='%D{%a,%b%d}'
  fi

  echo $CURRENT_BRANCH
}


function box_prompt_info() {
  if [ -n "$vcs_info_msg_0_" ]; then
    # CURRENT_BRANCH="git:($PR_MAGENTA${branch}$PR_YELLOW)$PR_NO_COLOUR$(parse_git_dirty)"
    CURRENT_BRANCH="$vcs_info_msg_0_"
  else
    # CURRENT_BRANCH="($PR_YELLOW%D{%a,%b%d}$PR_BLUE)"
    CURRENT_BRANCH=""
  fi

  echo $CURRENT_BRANCH
}




parse_git_dirty () {
  [[ $(git status | tail -n1) != "nothing to commit (working directory clean)" ]] && echo " %{$fg[yellow]%}x$PR_NO_COLOUR"
}

setprompt () {
    ###
    # Need this so the prompt will work.

    setopt prompt_subst


    ###
    # See if we can use colors.

    autoload colors zsh/terminfo
    if [[ "$terminfo[colors]" -ge 8 ]]; then
	  colors
    fi
    for color in RED GREEN YELLOW BLUE MAGENTA CYAN WHITE; do
	  eval local PR_$color='%{$terminfo[bold]$fg[${(L)color}]%}'
	  eval local PR_LIGHT_$color='%{$fg[${(L)color}]%}'
	  (( count = $count + 1 ))
    done
    local PR_NO_COLOUR="%{$terminfo[sgr0]%}"


    ###
    # See if we can use extended characters to look nicer.
    
    typeset -A altchar
    set -A altchar ${(s..)terminfo[acsc]}
    local PR_SET_CHARSET="%{$terminfo[enacs]%}"
    local PR_SHIFT_IN="%{$terminfo[smacs]%}"
    local PR_SHIFT_OUT="%{$terminfo[rmacs]%}"
    local PR_HBAR=${altchar[q]:--}
    local PR_ULCORNER=${altchar[l]:--}
    local PR_LLCORNER=${altchar[m]:--}
    local PR_LRCORNER=${altchar[j]:--}
    local PR_URCORNER=${altchar[k]:--}

    
    ###
    # Decide if we need to set titlebar text.
    
    local PR_TITLEBAR
    case $TERM in
	xterm*)
	    PR_TITLEBAR=$'%{\e]0;%(!.-=*[ROOT]*=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\a%}'
	    ;;
	screen)
	    PR_TITLEBAR=$'%{\e_screen \005 (\005t) | %(!.-=[ROOT]=- | .)%n@%m:%~ | ${COLUMNS}x${LINES} | %y\e\\%}'
	    ;;
	*)
	    PR_TITLEBAR=''
	    ;;
    esac
    
    
    ###
    # Decide whether to set a screen title
    local PR_STITLE
    if [[ "$TERM" == "screen" ]]; then
	  PR_STITLE=$'%{\ekzsh\e\\%}'
    else
	  PR_STITLE=''
    fi

    # 
    ###
    # Finally, the prompt.

    local RSBOXHOST=`hostname -s`

    PROMPT="$PR_SET_CHARSET$PR_STITLE${(e)PR_TITLEBAR}\
$PR_CYAN$PR_SHIFT_IN$PR_ULCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_MAGENTA%$PR_PWDLEN<...<%~%<<\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_HBAR\${(e)PR_FILLBAR}$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
$PR_GREEN%(!.%SROOT%s.%n)$PR_GREEN@%m:%l\
$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_URCORNER$PR_SHIFT_OUT\

$PR_CYAN$PR_SHIFT_IN$PR_LLCORNER$PR_BLUE$PR_HBAR$PR_SHIFT_OUT(\
%(?..$PR_LIGHT_RED%?$PR_BLUE:)\
${(e)PR_APM}$PR_YELLOW${RSBOXHOST}\
$PR_LIGHT_BLUE:%(!.$PR_RED.$PR_WHITE)%#$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_NO_COLOUR "

    RPROMPT=" $PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_BLUE$PR_HBAR$PR_SHIFT_OUT\
\$(box_prompt_info)$PR_SHIFT_IN$PR_HBAR$PR_CYAN$PR_LRCORNER$PR_SHIFT_OUT$PR_NO_COLOUR"

    PS2="$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_BLUE$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT(\
$PR_LIGHT_GREEN%_$PR_BLUE)$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT\
$PR_CYAN$PR_SHIFT_IN$PR_HBAR$PR_SHIFT_OUT$PR_NO_COLOUR "
}

setprompt
