local x
for x in /usr/local/lib/cw/*(.xN)
do
  hash `basename $x`=$x
done
