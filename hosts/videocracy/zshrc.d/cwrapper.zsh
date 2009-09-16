local fpath fname
for fpath in /usr/local/lib/cw/*(.xN)
do
    fname=$fpath:t
    if ! typeset -f $fname >/dev/null; then
        eval "$fname() { $fpath \"\${(@)*}\" }"
    fi
done

