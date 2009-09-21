# History stuff.
setopt HIST_VERIFY
setopt INC_APPEND_HISTORY
setopt EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_FIND_NO_DUPS
setopt HIST_NO_STORE

# you may wish to override this if your HOME is on a network filesystem (NFS/AFS/SMB)
setopt HIST_FCNTL_LOCK 2>/dev/null

# prefix commands with a space to keep them out of permanent history
# like "Private Browsing" mode for commands
setopt HIST_IGNORE_SPACE

## Command history configuration
#
typeset -g HISTFILE=$DOTTODIR/log/.zsh_history
typeset -g HISTSIZE=2500
typeset -g SAVEHIST=2500


