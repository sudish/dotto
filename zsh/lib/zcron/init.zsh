#!/bin/zsh
#
# References / Inspirations
#
#  zsh bundled vcs_info
#  original box prompt source from which the rsbox theme was hacked up
#  http://github.com/sudish/dotfiles/blob/master/.zshinit/S90_git_status
#  http://volnitsky.com/project/git-prompt/git-prompt.sh
#  
#

local libdir=${0:h}

zmodload -i zsh/stat

# zmodload -i zsh/sched 2>/dev/null

typeset -g PERIOD=30
typeset -A -H g PERIOD_FUNCS
typeset -A -H -g ZCRON_TIMESTAMPS
typeset -A -H -g ZCRON_FUNCTIONS

local _zfile

for _zfile in $libdir/functions/*; do
  autoload -Uk ${_zfile:t}
done

typeset -g -a periodic_functions
periodic_functions+=zperiodic_function

