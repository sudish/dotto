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

typeset -g -A -H gitinfo_vars
typeset -g -A -H git_dirs

function gitinfo_reset() {
    # nothing
}

function gitinfo_setup() {
    local dir="${1:h}"
    gitinfo_reset
}

for _zfile in $libdir/functions/*; do
  autoload -Uk ${_zfile:t}
done

# setup in current dir
gitinfo_setup ${0:h}

