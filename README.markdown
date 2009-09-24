Dotto - the Dotfile Framework
=============================

Version: 0.2

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

Customization
-------------

Next, if you're a new user, you need to create a directory for personalization.
There are two ways to do that: fork an example configuration (preferred), or
create one from scratch.

### Forking an Example Configuration Package

A simple Dotto configuration package is available at the following GitHub URL.
You should use your GitHub account to fork it.

    http://github.com/rsanders/dotto_example_config

After installing Dotto to your home directory, fork this repository.  Pull
it into your Dotto installation like so:

    cd $HOME/.dotto/external

    git clone http://github.com/YOUR-GITHUB-USERNAME/dotto_example_config $USERNAME

    # or if you didn't fork it, use the following command to get started:
    #  git clone http://github.com/rsanders/dotto_example_config $USERNAME
    
    cd $USERNAME
    vi prefs
    ...


### Creating a Configuration Package from Scratch

The other way to get your configuration package started is to use the
template tool included with Dotto, as follows:

    cd $HOME/.dotto
    zsh setup/create_external.zsh

The script will tell you which directory it created, more than likely at:

    $HOME/.dotto/external/$USERNAME
  
The most important file in that directory is "prefs".  That is where you'll
put the configuration items that drive Dotto.


License
-------

Original portions of Dotto are covered by the MIT License; see the LICENSE file
for the complete text.

Some third party code has been included; where noted, other licenses may apply
for those potions.


See Also
--------

Dotto has received inspiration or code from the following projects:

* The Z-Shell distribution itself.  http://zsh.org/
* Oh My Zsh: http://github.com/robbyrussell/oh-my-zsh/
* Emacs Starter Kit:  http://github.com/technomancy/emacs-starter-kit/
* Scientifing Computing on OS X ZSH mega-config:
   http://sage.ucsc.edu/~wgscott/xtal/wiki/index.php/Explanations_for_each_zsh_template_file

Bugs and Feedback
-----------------

If you discover any bugs, please send an e-mail to rsanders@gmail.com.  Better yet,
fork this on github, fix the bug, and send me a pull request.

Copyright (c) 2009 Robert Sanders, http://github.com/rsanders

