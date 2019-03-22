#!/bin/sh
unlink ~/.vimrc
ln -s `pwd`/.vimrc ~/

unlink ~/.bashrc
ln -s `pwd`/.bashrc ~/

unlink ~/.bash_profile
ln -s `pwd`/.bash_profile ~/
