#!/bin/zsh

typeset -g AGENT_FILE=$HOME/.sshagent
typeset -g AGENT_FILE_MTIME=0

agent() {
	local doload=0 lmtime
	if [ -r "$AGENT_FILE" -a \( -z "$SSH_AUTH_SOCK" -o ! -e "$SSH_AUTH_SOCK" \) ]; then
		lmtime=`builtin stat +mtime $AGENT_FILE`
		if [ $lmtime != $AGENT_FILE_MTIME ]; then
			doload=1
		fi
	fi

	if [ $doload != 0 ]; then
		zlog "loading agent file"
		AGENT_FILE_MTIME=`builtin stat +mtime $AGENT_FILE`
		source $AGENT_FILE
	fi
}

# set up scan for SSH agent file every 60 seconds
zcron_add 60 agent
