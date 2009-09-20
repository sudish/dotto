#!/usr/bin/env zsh

DOTTODIR=`dirname $0`/..
ZCONFIGDIR=$DOTTODIR/zsh


function zgit_dirty () {
    emulate -L zsh
    local gitstatus
    
    gitstatus=$(git status 2>/dev/null) && [[ -n ${gitstatus:#*nothing to commit*} ]] && return 0
}

if egrep 'DOTTODIR' $HOME/.zprofile >/dev/null 2>&1; then
  dozbackup=0
else
  dozbackup=1
fi

backupbase=$DOTTODIR/local/backup

zbackupdir=$backupbase/`hostname`

if [[ ! -d $backupbase || ! -d $backupbase/.git ]]; then
    mkdir -p "$zbackupdir"
    (cd $backupbase && git init)
fi

#
# Install ZSH
#
for zfile in $ZCONFIGDIR/base/*; do
  basefile=`basename $zfile`
  dotfile=.$basefile
    
  # skip if no change
  cmp $HOME/$dotfile $zfile &>/dev/null && continue
  
  if [[ -f $HOME/$dotfile && $dozbackup = 1 ]]; then
    echo "Backing up $dotfile"
    cp $HOME/$dotfile $zbackupdir/$basefile
  fi
  # mv -i $HOME/$dotfile $HOME/${dotfile}.prezfiles
  rm -f $HOME/$dotfile
  cp -f $zfile $HOME/$dotfile
done

#
# linked config files
#

typeset -A installed_dotfiles

for zfile in $DOTTODIR/external/conf.d/*(N) $DOTTODIR/conf.d/*(N); do
  basefile=`basename $zfile`
  dotfile=.$basefile
  install=1

  if [[ -n $installed_dotfiles[$dotfile] ]]; then
    echo "Skipping ${zfile#$DOTTODIR/}; already installed $dotfile"
    continue
  fi
  
  # skip example files
  if [[ ${basefile:e} == "example" ]]; then
    continue
  fi
  
  # skip if no change
  cmp $HOME/$dotfile $zfile >/dev/null && continue
  
  if [[ -h $HOME/$dotfile ]]; then
    echo "Removing old symlink for .$basefile"
    rm -f $HOME/$dotfile
  elif [[ -f $HOME/$dotfile || -d $HOME/$dotfile ]]; then
    echo "Backing up conf.d $dotfile and creating symlink"
    mv $HOME/$dotfile $zbackupdir/$basefile
  else
    echo "No backup necessary for $basefile"
  fi

  # make relative symlink
  if [ "$install" = "1" ]; then
    installed_dotfiles[$dotfile]=$zfile
    echo "Installing .$basefile symlink"
    ln -s ${zfile#$HOME/} $HOME/$dotfile
  fi
done


if [ "$dozbackup" = 1 ]; then
  cd $backupbase && zgit_dirty && \
         git add -f `basename $zbackupdir` && \
         git commit -a -m"backed up host `hostname`"
fi

echo "Done installing Dotto into $HOME.  Now re-login or 'exec zsh -l' to activate."

return 0
