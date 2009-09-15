FPATH=`dirname $0`/functions:$FPATH

local zfunc
for zfunc in `dirname $0`/functions/*; do
  autoload -Uz `basename $zfunc`
done
unset zfunc
