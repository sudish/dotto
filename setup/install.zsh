#!/usr/bin/env zsh

DOTTODIR=`dirname $0`/..
ZCONFIGDIR=$DOTTODIR/zsh

if egrep 'DOTTODIR' $HOME/.zprofile >/dev/null 2>&1; then
  dozbackup=0
else
  dozbackup=1
fi

backupbase=$DOTTODIR/external/backup

zbackupdir=$backupbase/`hostname`

if [[ ! -d $backupbase || ! -d $backupbase/.git ]]; then
    mkdir -p "$zbackupdir"
    (cd $backupbase && git init)
fi

for zfile in $ZCONFIGDIR/base/*; do
  basefile=`basename $zfile`
  dotfile=.$basefile
  if [ "$dozbackup" = 1 ]; then
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
for zfile in $DOTTODIR/conf.d/*; do
  basefile=`basename $zfile`
  dotfile=.$basefile
  install=1
  if [ -h $HOME/$dotfile ]; then
    echo "Removing old symlink for .$basefile"
    rm -f $HOME/$dotfile
  elif [ -f $HOME/$dotfile -o -d $HOME/$dotfile ]; then
    echo "Backing up conf.d $dotfile and creating symlink"
    mv $HOME/$dotfile $zbackupdir/$basefile
  else
    echo "No backup necessary for $basefile"
  fi
  # make relative symlink
  if [ "$install" = "1" ]; then
      echo "Installing .$basefile symlink"
      ln -s ${zfile#$HOME/} $HOME/$dotfile
  fi
done


if [ "$dozbackup" = 1 ]; then
  cd $backupbase && git add -f `basename $zbackupdir` && git commit -a -m"backed up host `hostname`"
fi

