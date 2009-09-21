This is the ZSH interactive shell portion of Dotto.

Non-interactive shells:

   zshenv
     any external/* zshenv.d files

Login interactive shells:

    zshenv
      external/* zshenv.d files
    newshell
      external/* newshell.d files
    zprofile
      external/* zprofile.d files
      library zprofile files
    user prefs
    zshrc
      external/* zshrc.d files
      library zshrc files
    zcomp
      external/* zcomp.d files
      library zcomp files
    zperiodic
      external/* zperiodic.d files
      library zperiodic files
    zlogin
      external/* zlogin.d files
      library zperiodic files

Non-login interactive shells:

    zshenv
      external/* zshenv.d files
    newshell
      external/* newshell.d files
    user prefs
    zshrc
      external/* zshrc.d files
      library zshrc files
    zcomp
      external/* zcomp.d files
      library zcomp files
    zperiodic
      external/* zperiodic.d files
      library zperiodic files


When a login shell is closed, the following files are sourced:

    zlogout
      external/* zlogout.d files
      library zlogout files

When any interactive shell terminates, the functions named in the ZSH standard
"zshexit_functions" hook are executed.



