Dotto - the Dotfile Framework
=============================

Version: 0.1

Description
-----------

Dotto is a ZSH-centric dotfile framework for Mac OS X, Linux, and any other very
Unix-y environment (including Cygwin).  

What is a "dotfile framework", you ask?  Well, don't do that.  I don't have
a good answer yet and it's very annoying.

The intent is to have a system which makes it possible for a person to manage
all his program configurations

All-singing support:

* Z Shell (ZSH)
   
Simple support:

* Screen and TMUX
* Ruby / IRB
* SSH
   
File distribution:

* Any system with a single dotfile or dot-directory in your $HOME.

There are two very interesting targets of opportunity in Emacs and VIM,
but that's a bigger kettle of fish than I've got time to work on and there
are some solutions already available.

keywords: zsh, git, dotfiles, framework, configuration management

Installation
------------

First you need to grab a copy of the framework from GitHub.

  cd $HOME
  git clone git://github.com/rsanders/dotto.git .dotto
  zsh .dotto/setup/install.zsh

You don't need to name the local directory ".dotto".  It may also be named one of
the following things:

* .dotto
* dotto
* .dotfiles
* dotfiles

And you don't have to put the .dotto directory (or whatever) in your $HOME.  
It can be in any of the following directories:

* $HOME
* $HOME/config
* $HOME/lib
* $HOME/.external
* $HOME/home

Alternately, if you have a system-wide installation, you can just define
the environment variable DOTTODIR in your system-wide environment file (e.g.,
/etc/zshenv), like so:

  DOTTODIR=/usr/local/share/dotto

Next, if you're a new user, you need to create a directory for personalization.

  cd $HOME/.dotto
  zsh setup/create_external.zsh

The script will tell you which directory it created, more than likely 

  `$HOME/.dotto/external/$USERNAME`
  
The most important file in that directory is "prefs".  That is where you'll


License
-------

Original portions of Dotto are covered by the MIT License; see the LICENSE file
for the complete text.

Some third party code has been included; where noted, other licenses may apply
for those potions.


See Also
--------

* Oh My Zsh: http://github.com/robbyrussell/oh-my-zsh/
* Emacs Starter Kit:  http://github.com/technomancy/emacs-starter-kit/

Bugs and Feedback
-----------------

If you discover any bugs, please send an e-mail to rsanders@gmail.com.  Better yet,
fork this on github, fix the bug, and send me a pull request.

Copyright (c) 2009 Robert Sanders, http://github.com/rsanders

