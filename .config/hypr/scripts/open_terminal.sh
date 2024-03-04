#!/bin/bash

if [[ $(hyprctl activeworkspace | grep "workspace ID 3") == "" ]]; then
  hyprctl dispatch workspace 3
fi

if [[ $( hyprctl clients | grep -c "workspace: 3") == "0" ]]; then
  cd $HOME
  kitty
fi
