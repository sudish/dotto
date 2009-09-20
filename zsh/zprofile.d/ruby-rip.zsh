
# -- start rip config -- #

typeset -g RIPDIR=$HOME/.rip
typeset -g RUBYLIB="$RUBYLIB:$RIPDIR/active/lib"
PATH="$PATH:$RIPDIR/active/bin"
export RIPDIR RUBYLIB PATH

# -- end rip config -- #
