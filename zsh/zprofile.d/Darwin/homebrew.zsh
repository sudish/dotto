#!/bin/zsh
#
# The homebrew packaging system.  See
#    git://github.com/mxcl/homebrew.git
#

# check for the homebrew main executable
if which brew &>/dev/null; then
  return 0
fi

emulate -L zsh
unsetopt warn_create_global

local root=""

for root in /usr/local /usr/local/homebrew /usr/local/brew /opt/brew /opt/homebrew; do
  if [[ -d $root/bin && -x $root/bin/brew ]]; then
    manpath+=${root}/share/man
    path+=${root}/bin
    break
  fi
done

