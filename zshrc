
# Z-Shell .rc file

# $Date: 2003/03/18 07:11:02 $
# $Source: /home/rsanders/RCS/.zshrc,v $
# $Revision: 1.1 $
# $State: Exp $

echo "running zshrc.."

# ZSH options
setopt nolistbeep autolist nonomatch sh_word_split noclobber
unsetopt menucomplete

if [ "$TERM" = "xterm" -o "$TERM" = "rxvt" ]; then
	XTERMPROMPT=$(echo -n "\e]0;%m - %n\07")
fi
#if [ "$INSCREEN" = 1  ]; then
#    SCREENNULLPROMPT=$(echo -n "\033k\033\\")
#else
#    SCREENNULLPROMPT=""
#fi

# the magic prompt, oh yes
PS1="%{$SCREENNULLPROMPT%}%{$XTERMPROMPT%}%(0#.%S.%B)%n%(0#.%s.%b){%m}%B%~%b%(#.#.$) "
RPROMPT="%(?..[%?])"

# get that BASH-like "> file" behavior
noeolecho()
{
echo -n
}
NULLCMD=noeolecho

bindkey -e

# bind F1 to run-help
# THIS causes rlogins to lucy to die
# bindkey -s "`echotc k1`" "run-help "

if [ "`uname -s`" = "FreeBSD" -a "$TERM" = "vt100" ]; then
	export TERM="vt100-color"
fi

if [ "$TERM" = "screen" -o "$TERM" = "vt100-color" -o "$TERM" = "vt100" ]; then
	# export TERM=vt100
	DO_COLOR=yes
fi

# if on the console, alias ls to cls (color ls)
if [ "$TERM" = "console" -o "$TERM" = "xterm" -o "X$DO_COLOR" = "Xyes" -o "$TERM" = "vt100" -o "$TERM" = "screen" -o "$TERM" = "xterm-color" ]
then
	#which colorls > /dev/null 2> /dev/null
	if [ "`uname -s`" != Linux ];  then
		alias ls='ls -G'
	else
		# GNU generation, baby
		alias ls='ls --color=auto'
	fi
fi

#if [ "$TERM" = "xterm" ]; then
#	if [ "$DISPLAY" = ":0.0" -o "$DISPLAY" = "$HOST:0.0" ]; then
#		stty erase ^H
#	fi
#fi

stty erase '^?'


which tput > /dev/null 2> /dev/null
if [ $? = 0 ]; then
	alias clear="echo -n \"`tput clear`\""
fi

# set hostname
HOSTNAME=`hostname`

# because zsh doesn't load termcap in for some reason, and Linux's tput
# is using Berkeley-curses, which depends on TERMCAP being set... 

tput() {
   CAP=$1
   shift
   case $CAP in
     cols) echo $COLUMNS;;
     lines) echo $LINES;;
     *) command tput $CAP $*;;
   esac
}

if [ -x /usr/local/bin/rdist ]; then
	alias rdist=/usr/local/bin/rdist
fi

###
# establish a stub function to autoload functions from a file

function autoload_from
{
	local alf_file=$1
	local alf_func
	shift

	for alf_func in $*
	do
		eval "function $alf_func () { . $alf_file; $alf_func \$* }"
	done
}

alias vi=vim
export SHORTHOST=$(hostname -s)



# set up completion magic
hosts=(turok test.zeevex.com prod.zeevex.com monitor.zeevex.com schultz.dreamhost.com minimus-2.local)
if [ -r ~/.zcomp ]; then
	. ~/.zcomp
fi

if [ -r ~/.zperiodic ]; then
	. ~/.zperiodic
fi

if [ -r ~/.sshagent ]; then
	. ~/.sshagent
fi

if [ -r ~/.zmacosx ]; then
	. ~/.zmacosx
fi

if [ -r ~/.ec2rc ]; then
	. ~/.ec2rc
fi

pdoc=/Users/Shared/Documents/Prog\ Docs

export EDITOR='mate-w'

#export SF_ENVIRONMENT=robertdev

for zrc in $HOME/.zrc/*; do
    . $zrc
done

