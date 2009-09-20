#!/usr/bin/env zsh


function zgit_dirty () {
    emulate -L zsh
    local gitstatus
    local dir=$1
    
    (
      [[ -n $dir ]] && { cd $dir || return 1 }
      [[ -d .git ]] || return 1
 
      gitstatus=$(git status 2>/dev/null)
      [[ -z ${gitstatus:#*working directory clean*} ]] && return 1
      return 0
    )
}

function zrealpath() {
  emulate -L zsh

  local pth="$1"
  
  [[ $pth[1] == "/" ]] || pth="$PWD/$pth"

  if [ "${pth:t}" = "." -o "${pth:t}" = ".." -o -d "$pth" ]; then
      (cd -P "$pth" && pwd -P)
      return
  fi

  if [[ "${pth:h}" == "/" ]]; then
      echo "$pth"
      return
  fi
  
  local dir=${pth:h}
  dir=$(cd -P "$dir" && pwd -P)
  
  echo "$dir/${pth:t}"
}


DOTTODIR=$(zrealpath ${0:h}/..)
ZCONFIGDIR=$DOTTODIR/zsh


dobackup=1
if egrep 'DOTTODIR' $HOME/.zprofile >/dev/null 2>&1; then
  dozbackup=0
else
  dozbackup=1
fi

backupbase=$DOTTODIR/local/backup

zbackupdir=$backupbase/`hostname`
dotbackupdir=$zbackupdir/conf.d

if [[ $dobackup == 1 ]]; then
  if [[ ! -d $backupbase || ! -d $backupbase/.git ]]; then
      mkdir -p "$zbackupdir"
      (cd $backupbase && git init)
  fi
  mkdir -p $dotbackupdir
fi

#
# Install ZSH
#
for zfile in $ZCONFIGDIR/base/*; do
  basefile=`basename $zfile`
  dotfile=.$basefile
    
  # skip if no change
  cmp $HOME/$dotfile $zfile &>/dev/null && continue
  
  if [[ $dobackup == 1 && -f $HOME/$dotfile && $dozbackup = 1 ]]; then
    echo "Backing up $dotfile"
    cp $HOME/$dotfile $zbackupdir/$basefile
  fi
  rm -f $HOME/$dotfile
  cp -f $zfile $HOME/$dotfile
done

#
# linked config files
#

typeset -A installed_dotfiles

for zfile in $DOTTODIR/external/*/conf.d/*(N) $DOTTODIR/conf.d/*(N); do
  basefile=`basename $zfile`
  dotfile=.$basefile
  install=1
  linkdest=${zfile#$HOME/}

  if [[ -n $installed_dotfiles[$dotfile] ]]; then
    echo "Skipping ${zfile#$DOTTODIR/}; already installed $dotfile"
    continue
  fi
  
  # skip example files
  if [[ ${basefile:e} == "example" ]]; then
    continue
  fi
  
  # echo "dotfile=$dotfile, linkdest=$linkdest, rl=$(readlink $HOME/$dotfile), basefile=$basefile, target=$HOME/$dotfile"
  
  # skip if already set properly
  if [[ -h $HOME/$dotfile && $(readlink $HOME/$dotfile) == $linkdest ]]; then
    continue
  fi
  
  if [[ -h $HOME/$dotfile ]]; then
    echo "Removing old symlink for .$basefile"
    rm -f $HOME/$dotfile
  elif [[ -f $HOME/$dotfile || -d $HOME/$dotfile ]]; then
    if [[ $dobackup == 1 ]]; then
      echo "Backing up conf.d/$basefile"
      mv $HOME/$dotfile $dotbackupdir/$basefile
    fi
  fi

  # make relative symlink
  if [ "$install" = "1" ]; then
    installed_dotfiles[$dotfile]=$zfile
    echo "Installing .$basefile symlink"
    ln -s $linkdest $HOME/$dotfile
  fi
done


if [[ $dobackup == 1 ]]; then
  if cd $backupbase && zgit_dirty; then
    echo "Your existing files were backed up into $zbackupdir"
    git add -f `basename $zbackupdir`
    git commit -a -m"backed up host `hostname`"
  fi
fi

echo "Done installing Dotto into $HOME.  Now re-login or 'exec zsh -l' to activate."

return 0
