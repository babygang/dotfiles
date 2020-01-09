#!/bin/bash
function mksymln() {
  unlink ~/$1 2>/dev/null
  ln -s `pwd`/$1 ~/
}

mksymln .vimrc
mksymln .bashrc
mksymln .bash_profile
mksymln .gitconfig
