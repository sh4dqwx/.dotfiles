#!/bin/bash

if [[ $(hyprctl clients -j | jq "[.[] | select(.workspace.id == 1)] | length") == "0" ]]; then
  return
fi

if [[ $(hyprctl activeworkspace -j | jq ".id") != "1" ]]; then
  hyprctl dispatch workspace 1
fi
