
# commands common to all logins...for zsh 2.4 beta

# $Date: 2006/07/08 05:11:01 $
# $Source: /Users/robertsanders/RCS/.zprofile,v $
# $Revision: 1.1 $
# $State: Exp $

echo "running zprofile.."

if [ "$TERM" = "console" -o "$TERM" = "dumb" ]; then
   TERM=vt100
fi

if [ "$UID" != "0" ]; then
   # remove '.' from path
   PATH=`echo $PATH | sed -e "s/:\.//g"`
fi
export JAVA_HOME=/usr/java/current
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
export PATH=/usr/X11R6/bin:/usr/krb5/bin:/usr/krb5/sbin:$PATH:/usr/local/bin:/sbin:/usr/sbin:/usr/contrib/bin:/usr/local/pgsql/bin:$JAVA_HOME/bin:/usr/java/ant:/usr/local/java/jython-2.1

pwd=`pwd`
for dir in $HOME/bin/paths/* $HOME/bin; do
    cd $dir
    realdir=`/bin/pwd -P`
    PATH=${realdir}:${PATH}
done
cd $pwd


export MANPATH=$MANPATH:/opt/local/man:/sw/share/man

export PAGER=less
export EDITOR=vi
export BLOCKSIZE=1024
export LINES COLUMNS
export HISTSIZE=400

# adding c makes scrolling faster, but it always takes the
# whole screen
export LESS="efiMqR"

#export hosts=(lucy hrothgar localhost)

export IGNOREEOF=0

hd() {
hexdump -e "\"%07.7_ax  \" 16/1 \"%02x \" \"\n\"" $*
}

export PATH DISPLAY LESS TERM PS1 PS2 ignoreeof
export XDVIFONTS=/usr/local/lib/tex/fonts/cm/%f.%p

umask 022
export GROFF_TYPESETTER=ascii

export TERMCAP
export FONTS_DIR=/usr/lib/X11/misc

export LPDEST=hp1200d

# set up terminal defaults	
stty echoe susp ^z intr ^c lnext undef kill undef werase undef start undef stop undef erase '^?'

# enable meta-key
bindkey -me

# skip fancy stuff for root
if [ "$UID" != "0" ]; then
   # setup TERMCAP for tput and kermit scripts
   #eval `resize`

   # remove duplicates to appease tput
   # XXX - removed on Linux RH9.0 - rsanders - 2003-04-13
   #TERMCAP=`echo $TERMCAP | sed -e "s/\(li#[0-9]*:.*\):li#[0-9]*/\1/g" -e "s/\(co#[0-9]*:.*\):co#[0-9]*/\1/g"`
   #export TERMCAP
fi

# 3 MB coredump limit
ulimit -c 3000

### fix for gnuserv and Xauth with ssh
### xauth extract - $DISPLAY | xauth -f .Xauthority merge -

# linux fix
if [ "$LANG" = "C" ]; then
	unset LANG
fi

test -r /sw/bin/init.sh && . /sw/bin/init.sh

# Your previous .profile  (if any) is saved as .profile.dpsaved
# Setting the path for DarwinPorts.

ZCONFIGDIR=$HOME/.zdir

. $ZCONFIGDIR/zprofile

