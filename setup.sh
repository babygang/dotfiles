#!/bin/bash
function mksymln() {
  local dirpath=${2:-~}
  unlink $dirpath/$1 2>/dev/null
  ln -s `pwd`/$1 $dirpath/
}

mksymln .vimrc
mksymln .bashrc
mksymln .bash_profile
mksymln .gitconfig
mksymln .gitattributes
mksymln .gitignore_global
mksymln git-imgdiff /usr/local/bin
