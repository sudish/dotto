#!/bin/zsh
#
# If su'ing to root, look for sbin equivalents for bin paths
#

[[ ! ($UID = 0 && (-n $SUDO_UID || $HOME == ~root) ) ]] && return 0

local binpath="" sbin=""

for binpath in $path; do
  [[ ${binpath:t} != "bin" ]] && continue
  sbin=${${binpath:h}%/}/sbin
  [[ -d $sbin && -z $path[(r)$sbin] ]] && path+=$sbin
done