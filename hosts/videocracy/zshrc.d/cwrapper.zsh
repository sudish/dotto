local x
for x in /usr/local/lib/cw/*(.x)
do
  echo "LOCAL CW: $x"
  hash `basename $x`=$x
done
