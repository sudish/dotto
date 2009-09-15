FPATH=`dirname $0`/functions:$FPATH

echo "LODIING LIB"
local zfunc
for zfunc in `dirname $0`/functions/*; do
  autoload -Uz `basename $zfunc`
done
unset zfunc
