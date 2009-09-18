##
## zsh prompt themes extension
## by Adam Spiers <adam@spiers.net>
##
## Load with `autoload -Uz promptinit; promptinit'.
## Type `prompt -h' for help.
##

prompt_themes=()
typeset -gU prompt_themes
typeset -g prompt_theme >/dev/null

promptinit () {
  emulate -L zsh
  setopt extendedglob
  local ppath='' name theme

  # Autoload all prompt_*_setup functions in fpath
  for theme in $^fpath/prompt_*_setup(N); do
    if [[ $theme == */prompt_(#b)(*)_setup ]]; then
      name="$match[1]"
      if [[ -r "$theme" ]]; then
        prompt_themes=($prompt_themes $name)
        autoload -U prompt_${name}_setup
      else
        print "Couldn't read file $theme containing theme $name."
      fi
    else
      print "Eh?  Mismatch between glob patterns in promptinit."
    fi
  done

  # To manipulate precmd and preexec hooks...
  autoload -U add-zsh-hook

  # Variables common to all prompt styles
  prompt_newline=$'\n%{\r%}'
}

prompt_preview_safely() {
  emulate -L zsh
  print -P "%b%f%k"
  if [[ -z "$prompt_themes[(r)$1]" ]]; then
    print "Unknown theme: $1"
    return
  fi

  local -a psv; psv=($psvar); local -a +h psvar; psvar=($psv) # Ick
  local +h PS1=$PS1 PS2=$PS2 PS3=$PS3 PS4=$PS4 RPS1=$RPS1
  local -a precmd_functions preexec_functions

  # The next line is a bit ugly.  It (perhaps unnecessarily)
  # runs the prompt theme setup function to ensure that if
  # the theme has a _preview function that it's been autoloaded.
  prompt_${1}_setup

  if typeset +f prompt_${1}_preview >&/dev/null; then
    prompt_${1}_preview "$@[2,-1]"
  else
    prompt_preview_theme "$@"
  fi
}

set_prompt() {
  emulate -L zsh
  local opt preview theme usage old_theme

  usage='Usage: prompt <options>
Options:
    -c              Show currently selected theme and parameters
    -l              List currently available prompt themes
    -p [<themes>]   Preview given themes (defaults to all)
    -h [<theme>]    Display help (for given theme)
    -s <theme>      Set and save theme
    <theme>         Switch to new theme immediately (changes not saved)

Use prompt -h <theme> for help on specific themes.'

  getopts "chlps:" opt
  case "$opt" in
    (h|p)
      setopt localtraps
      if [[ -z "$prompt_theme[1]" ]]; then
        # Not using a prompt theme; save settings
        local -a psv; psv=($psvar); local -a +h psvar; psvar=($psv) # Ick
	local +h PS1=$PS1 PS2=$PS2 PS3=$PS3 PS4=$PS4 RPS1=$RPS1
	local precmd_functions preexec_functions
      else
        trap 'prompt_${prompt_theme[1]}_setup "${(@)prompt_theme[2,-1]}"' 0
      fi
      ;;
  esac
  case "$opt" in
    c) if [[ -n $prompt_theme ]]; then
         print -n "Current prompt theme"
         (( $#prompt_theme > 1 )) && print -n " with parameters"
         print " is:\n  $prompt_theme"
       else
         print "Current prompt is not a theme."
       fi
       return
       ;;
    h) if [[ -n "$2" && -n $prompt_themes[(r)$2] ]]; then
         if functions prompt_$2_setup >/dev/null; then
	   # The next line is a bit ugly.  It (perhaps unnecessarily)
	   # runs the prompt theme setup function to ensure that if
	   # the theme has a _help function that it's been autoloaded.
	   prompt_$2_setup
	 fi
         if functions prompt_$2_help >/dev/null; then
           print "Help for $2 theme:\n"
           prompt_$2_help
         else
           print "No help available for $2 theme."
         fi
         print "\nType \`prompt -p $2' to preview the theme, \`prompt $2'"
         print "to try it out, and \`prompt -s $2' to use it in future sessions."
       else
         print "$usage"
       fi
       ;;
    l) print Currently available prompt themes:
       print ${(i)prompt_themes}
       return
       ;;
    p) preview=( $prompt_themes )
       (( $#* > 1 )) && preview=( "$@[2,-1]" )
       for theme in $preview; do
         [[ "$theme" == "$prompt_theme[*]" ]] && continue
         prompt_preview_safely "$=theme"
       done
       print -P "%b%f%k"
       ;;
    s) print "Set and save not yet implemented.  Please ensure your ~/.zshrc"
       print "contains something similar to the following:\n"
       print "  autoload -U promptinit"
       print "  promptinit"
       print "  prompt $*[2,-1]"
       shift
       ;&
    *) if [[ "$1" == 'random' ]]; then
         local random_themes
         if (( $#* == 1 )); then
           random_themes=( $prompt_themes )
         else
           random_themes=( "$@[2,-1]" )
         fi
         local i=$(( ( $RANDOM % $#random_themes ) + 1 ))
         argv=( "${=random_themes[$i]}" )
       fi
       if [[ -z "$1" || -z $prompt_themes[(r)$1] ]]; then
         print "$usage"
         return
       fi

       # Reset some commonly altered bits to the default
       add-zsh-hook -D precmd "prompt_*_precmd"
       add-zsh-hook -D preexec "prompt_*_preexec"
       add-zsh-hook -D chpwd "prompt_*_chpwd"
       add-zsh-hook -D periodic "prompt_*_periodic"
       add-zsh-hook -D zshaddhistory "prompt_*_zshaddhistory"
       add-zsh-hook -D zshexit "prompt_*_zshexit"

       set -A zle_highlight ${zle_highlight:#default:*}
       RPS1=

       (( ${#zle_highlight} )) || unset zle_highlight

       autoload +X prompt_$1_setup
       prompt_$1_setup "$@[2,-1]" && prompt_theme=( "$@" )
       ;;
  esac
}

prompt () {
  local prompt_opts

  set_prompt "$@"
 
  (( $#prompt_opts )) &&
      setopt noprompt{bang,cr,percent,subst} "prompt${^prompt_opts[@]}"

  true
}

prompt_preview_theme () {
  emulate -L zsh
  local -a psv; psv=($psvar); local -a +h psvar; psvar=($psv) # Ick
  local +h PS1=$PS1 PS2=$PS2 PS3=$PS3 PS4=$PS4 RPS1=$RPS1
  local precmd_functions preexec_functions

  print -n "$1 theme"
  (( $#* > 1 )) && print -n " with parameters \`$*[2,-1]'"
  print ":"
  prompt_${1}_setup "$@[2,-1]"
  [[ -n ${precmd_functions[(r)prompt_${1}_precmd]} ]] &&
    prompt_${1}_precmd
  [[ -o promptcr ]] && print -n $'\r'; :
  print -P "${PS1}command arg1 arg2 ... argn"
  [[ -n ${preexec_functions[(r)prompt_${1}_preexec]} ]] &&
    prompt_${1}_preexec
}

[[ -o kshautoload ]] || promptinit "$@"
