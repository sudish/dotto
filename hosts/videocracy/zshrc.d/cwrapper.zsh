local fpath fname
for fpath in /usr/local/lib/cw/*(.xN)
do
    fname=$fpath:t
    eval "$fname() { $fpath \"\${(@)*}\" }"
done

