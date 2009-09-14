for file in $ZCONFIGDIR/functions/*; do
  base=`basename $file`
  if [ $base != "setup.zsh" ]; then
    autoload -U $base
  fi
done
