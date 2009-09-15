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

if [ "$dozbackup" = 1 ]; then
  cd $ZCONFIGDIR
  git add $zbackupdir $zbackupdir/*
  git commit -m"backed up host `hostname`"
  git push --all
fi

