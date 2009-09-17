#!/bin/zsh

if true; then
    zmodload -a zsh/stat stat zstat 
    zmodload -a zsh/zpty zpty
    zmodload -a zsh/zprof zprof
    zmodload -ap zsh/mapfile mapfile
    zmodload -a zsh/sched sched
    zmodload -a zsh/system syserror sysread syswrite
    zmodload -a zsh/terminfo echoti
    zmodload -a zsh/termcap echotc
    zmodload -a zsh/zprof zprof
    zmodload -a zsh/zpty zpty
    zmodload -a zsh/clone clone

    zmodload zsh/datetime
    zmodload zsh/mathfunc
    zmodload zsh/mapfile
    zmodload zsh/parameter
    zmodload zsh/regex
    zmodload zsh/zutil
fi 2>/dev/null
