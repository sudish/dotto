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

function zperiodic_function() {
	for func in ${(k)PERIOD_FUNCS}
	do
		$func
 	done

  run_cron_funcs
	run_periodic_dir hourly 3600
	run_periodic_dir daily 86400
	run_periodic_dir weekly 604800
}

typeset -g -a periodic_functions
periodic_functions+=zperiodic_function

