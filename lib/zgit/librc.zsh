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

typeset -g -A -H zgit_vars
typeset -g -A -H zgit_dirs

function zgit_reset() {
    # nothing
}

function zgit_setup() {
    local dir="${1:h}"
    zgit_reset
}

local _zfile

for _zfile in $libdir/functions/*; do
  autoload -Uk ${_zfile:t}
done

# setup in current dir
zgit_setup ${0:h}
