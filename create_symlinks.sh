#!/bin/bash

DOTFILES_PATH=~/.dotfiles

for dotfile in $DOTFILES_PATH/.*; do
  echo $(basename $dotfile)
  if [[ $(basename $dotfile) == ".git" ]]; then
    continue 
  fi
  rm -rf ~/$(basename $dotfile)
  ln -sf $dotfile ~/$(basename $dotfile)
done
