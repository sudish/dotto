#!/bin/zsh

typeset -g -A -H gitinfo_vars

typeset -g -A -H git_dirs

gitinfo_reset() {
}

gitinfo_setup() {
    local root="${1:h}"
    gitinfo_reset()
}

# setup in current dir
gitinfo_setup ${0:h}



