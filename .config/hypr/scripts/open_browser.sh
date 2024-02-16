#!/bin/bash

if [[ $(hyprctl activeworkspace | grep "workspace ID 5") == "" ]]; then
  hyprctl dispatch workspace 5
fi

if [[ $(pgrep firefox) == "" ]]; then
  firefox
fi
