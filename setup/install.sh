#!/usr/bin/env zsh
if [ -z "$ZCONFIGDIR" ]; then
  ZCONFIGDIR=`dirname $0`/..
fi

if grep ZCONFIGDIR $HOME/.zprofile >/dev/null 2>&1; then
  dozbackup=0
else
  dozbackup=1
  zbackupdir=$ZCONFIGDIR/backup/`hostname`
  mkdir -p "$zbackupdir"
fi 

for zfile in $ZCONFIGDIR/base/*; do
  basefile=`basename $zfile`
  dotfile=.$basefile
  if [ "$dozbackup" = 1 ]; then
    echo "Backing up $dotfile"
    cp $HOME/$dotfile $zbackupdir/$basefile
  fi
  mv -i $HOME/$dotfile $HOME/${dotfile}.prezfiles
  cp -f $zfile $HOME/$dotfile
done

#
# linked config files
#
for zfile in $ZCONFIGDIR/conf.d/*; do
  basefile=`basename $zfile`
  dotfile=.$basefile
  install=1
  if [ -h $HOME/$dotfile ]; then
    echo "Removing old symlink for .$basefile"
    rm -f $HOME/$dotfile
  elif [ -f $HOME/$dotfile -o -d $HOME/$dotfile ]; then
    echo "Backing up conf.d $dotfile and creating symlink"
    mv -i $HOME/$dotfile $zbackupdir/$basefile
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
  cd $ZCONFIGDIR
  git add $zbackupdir $zbackupdir/*
  git commit -m"backed up host `hostname`"
  git push --all
fi

