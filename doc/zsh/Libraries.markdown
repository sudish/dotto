Dotto Libraries for ZSH
=======================

Some parts of Dotto are loaded into the shell by default, but some pieces of functionality
are provided as discrete libraries which are only loaded when requested.

In your $DOTTODIR/zsh/lib directory there are several bundled libraries.  They include:

1. themes -- an enhanced prompt theming system
2. zcron -- a system for scheduling the recurring invocation of shell functions
3. zgit -- some git functions optimized for very fast execution so that they can be used
   in shell prompts.

Using a Library
---------------       

A library is dormant until it is activated via the "uselib" shell function, which
is called with one or more library names.  For example, you might put the following
lines in your "prefs" file:

    # load the Dotto bundled libraries
    
    uselib zcron 
    uselib zgit 
    uselib themes

The library may document the functions it provides, but you can get a good idea by just
looking into its "functions" directory and its init.zsh file.


Making Your Own Libraries
-------------------------

To make your own library, just create a zsh/lib/$LIBRARY_NAME directory in
one of the usual places.  In that library you'll want the following file
structure

    init.zsh
    functions/
    completions/
    (any other directories you need)
    
init.zsh is sourced by the "uselib" function.  The path to the file is passed in
the $0 shell special variable, and can be used with ${0:h} to get the library's
path.

init.zsh is expected to handle the following responsibilities, if needed:

* Load any zsh modules needed for the library to work.

* Call uselib on any libraries it requires

* Autoload the library's functions (but uselib takes care of adding the library's 
  functions and completions directories to FPATH)

* Set any global variables.  Keep the namespace pollution to a minimum by using a single
  global association variable to hold your collection of scalar variables.

* Set any shell options; though it is best not to set options unless necessary.  Inside your
  library's functions, use "emulate -L zsh" to constrain the effects of setopt/unsetopt
  to just that function.

* Schedule functions to be run during shell initialization by adding the relevant function
  names to one or more of the following global array variables:

    newshell_functions
    zprofile_functions
    zshrc_functions
    zlogin_functions
    zlogout_functions

* Schedule any recurring tasks via the zcron / periodic_functions subsystem.

* Return an exit status indicating success or failure.


There is currently no way to pass parameters to the library via uselib.
If your init.zsh needs to accept parameters at activation/uselib time, it should do so through
one or more well-known shell variables.  For example, see the ZSH_THEME variable used by the
themes library.

It is sometimes better to define a setup function for the invoking user to call with his
configuration choices as arguments.

