#!/bin/zsh

typeset -g SSH_AGENT_FILE=${SSH_AGENT_FILE:-HOME/.sshagent}
typeset -g SSH_AGENT_FILE_MTIME=0

reload_ssh_agent() {
	local doload=0 lmtime=""
	typeset -A statres
	if [ "$SHLVL" -gt 1 -a -r "$SSH_AGENT_FILE" -a \( -z "$SSH_AUTH_SOCK" -o ! -e "$SSH_AUTH_SOCK" \) ]; then
    
    builtin stat -H statres $SSH_AGENT_FILE
		lmtime=$statres[mtime]
		
		if [ $lmtime != $SSH_AGENT_FILE_MTIME ]; then
			doload=1
		fi
	fi

	if [ $doload != 0 ]; then
		zlog "loading agent file"

    builtin stat -H statres $SSH_AGENT_FILE

		SSH_AGENT_FILE_MTIME=$statres[mtime]
		source $SSH_AGENT_FILE
	fi
}

typeset -g -a preexec_functions
preexec_functions+="reload_ssh_agent"

# set up scan for SSH agent file every 60 seconds
# zcron_add 60 agent
