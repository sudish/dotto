#!/bin/zsh

export AGENT_FILE=$HOME/.sshagent
export AGENT_FILE_MTIME=0

agent() {
	doload=0
	if [ -r "$AGENT_FILE" ]; then
		lmtime=`builtin stat +mtime $AGENT_FILE`
		if [ $lmtime != $AGENT_FILE_MTIME ]; then
			doload=1
		fi
	else
		doload=0
	fi

	if [ $doload != 0 ]; then
		zlog "loading agent file"
		AGENT_FILE_MTIME=`builtin stat +mtime $AGENT_FILE`
		. $AGENT_FILE
	fi
}

# set up scan for SSH agent file every 60 seconds
zcron_add 60 agent