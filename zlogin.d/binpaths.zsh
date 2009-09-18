#!/bin/zsh

local zpwd realpath tempdir
for tempdir in $HOME/bin/paths/* $HOME/bin; do
    realpath=$(cd -P $tempdir; builtin pwd -P)
done
unset zpwd realpath tempdir
