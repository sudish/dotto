for x in /usr/local/lib/cw/*(.x)
do
  hash `basename $x`=$x
done
