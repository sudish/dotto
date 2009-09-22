#!/bin/zsh

# Rmdir only real directories
compctl -g '*(/)' rmdir

# See the func/cdmatch function in the distribution
# compctl -K cdmatch -S '/' -x 'S[/][~]' -g '*(-/)' -- cd pushd
#### didn't complete .dirs - RDS
# compctl -k '(. ..)' -g '*(/,@)' cd
compctl -g '*(-/x)' + -g '*(D-/x)' cd

# for the run-help script
compctl -k "(`ls $ZSHDOCDIR`)" run-help

# networking programs
compctl -k hosts ping telnet ncftp ftp rlogin rsh tcpspray 

compctl -B builtin 

# Start of cdmatch.
# Save in your functions directory and autoload, then do
#   compctl -K cdmatch -S '/' cd pushd
# or if you prefer
#   compctl -K cdmatch -S '/' -x 'S[/][~]' -g '*(-/)' -- cd pushd
# (to use ordinary globbing for absolute paths).
#
# Completes directories for cd, pushd, ... anything which knows about cdpath.
# Note that . is NOT automatically included.  It's up to you to put it in
# cdpath somewhere.

cdmatch() {
  local dir nword args pref ngtrue
  [[ -o nullglob ]] && ngtrue=1
  setopt nullglob

  read -nc nword
  read -Ac args
  pref=$args[$nword]

  if [[ $pref[1] = [/\~] ]]; then
    eval "reply=($pref*(-/))"
  else
    reply=()
    for dir in $cdpath
    do
      eval "reply=(\$reply $dir/$pref*(-/:s,$dir/,,))"
    done
  fi
  [[ $ngtrue = 1 ]] || unsetopt nullglob
  return
}
# End of cdmatch.

# For rcs users, co and rlog from the RCS directory.  We don't want to see
# the RCS and ,v though.
compctl -g 'RCS/*(:t:s/\,v//)' co rlog rcs rcsdiff

# Run ghostscript on postscript files, but if no postscript file matches what
# we already typed, complete directories as the postscript file may not be in
# the current directory.
compctl -g '*.ps' + -g '*(-/)' gs ghostview

# Similar things for tex, texinfo and dvi files.
compctl -g '*.tex*' + -g '*(-/)' tex latex texi2dvi
compctl -g '*.dvi' + -g '*(-/)' xdvi dvips

# Anything after nohup is a command by itself with its own completion
compctl -l '' nohup exec open

# If the command is rsh, make the first argument complete to hosts and treat the
# rest of the line as a command on its own.
compctl -k hosts -x 'p[2,-1]' -l '' -- rsh

# kill takes signal names as the first argument after -, but job names after %
compctl -j -P % -x 's[-] p[1]' -k signals -- kill killall
compctl -j -x 's[-] p[1]' -k signals -- killall

# gzip files, but gzip -d only gzipped or compressed files
compctl -f -x 'R[-*d,^*]' -g '*.gz *.z *.Z' + -g '*(-/)' -- gzip
compctl -g '*.gz *.z *.Z' + -g '*(-/)' gunzip
compctl -g '*.Z' + -g '*(-/)' uncompress

# rudimentary completion for gcc

typeset -a gccfopts gccwopts gccopts gcclibs gccsource

gccfopts=(caller-saves cse-follow-jumps \
  cse-skip-blocks delayed-branch elide-constructors \
  expensive-optimizations fast-math float-store force-addr \
  force-mem inline-functions keep-inline-functions memoize-lookups \
  no-default-inline no-defer-pop no-function-cse no-inline \
  no-peephole omit-frame-pointer rerun-cse-after-loop \
  schedule-insns schedule-insns2 strength-reduce thread-jumps \
  unroll-all-loops unroll-loops all-virtual cond-mismatch \
  dollars-in-identifiers enum-int-equiv no-asm no-builtin \
  no-strict-prototype signed-bitfields signed-char \
  this-is-variable unsigned-bitfields unsigned-char \
  writable-strings)

gccwopts=(all aggregate-return cast-align \
  cast-qual char-subscript comment conversion enum-clash error \
  format id-clash-len implicit inline missing-prototypes \
  nested-externs no-import parentheses pointer-arith \
  redundant-decls return-type shadow strict-prototypes switch \
  template-debugging traditional trigraphs uninitialized unused \
  write-strings)

gccopts=(c S E o pipe v s l \
  qmagic mieee-fp m486 m386 static dll-verbose posix \
  ansi traditional traditional-cpp trigraphs fsyntax-only \
  pedantic pedantic-errors w a dletters g \
  p pg save-temps W  \
  print-libgcc-file-name O O2 C dD dM dN D E H \
  idirafter include imacros iprefix iwithprefix M MD MM MMD nostdinc P \
  Umacro undef W... f...)

gcclibs=(c m termcap curses dbm g++)
gccsource="*.c *.cc *.cxx *.C *.S *.s *.i *.ii *.m"

compctl -g "$gccsource *.o *.a *(/)" -x 's[-l]' -k "($gcclibs)" - \
        's[--W][-W]' -k "($gccwopts)" - \
        's[--f][-f]' -k "($gccfopts)" - \
        's[--][-]' -k "($gccopts)" - \
        'c[-1,-o]' -g '*(/) *.o' - \
        'c[-1,-c]' -g "$gccsource *(/)" -- \
        gcc cc g++ c++ 

unset gccsource gcclibs gccopts gccwopts gccfopts

# find is very system dependent, this one is for GNU find.
compctl -x 's[-]' -k "(daystart depth follow maxdepth mindepth noleaf version xdev \
amin anewer cmin cnewer ctime empty false fstype gid group inum links lname mmin \
mtime name newer nouser nogroup path perm regex size true type uid used user xtype \
exec fprint fprint0 fprintf ok print print0 printf prune ls)" - \
'p[1]' -g '. .. *(-/)' - \
'c[-1,-anewer][-1,-cnewer][-1,-newer][-1,-fprint][-1,fprint0][-1,fprintf]' -f - \
'r[-exec,;][-ok,;]' -l '' -- find

# See func/multicomp
# compctl -D -f + -U -K multicomp

# -*- Mode: Shell Script; tab-width: 2; indent-tabs-mode: nil; c-basic-offset: 2 -*-
