#!/bin/bash

if [[ $(hyprctl activeworkspace | grep "workspace ID 6") == "" ]]; then
  hyprctl dispatch workspace 6
fi

if [[ $(pgrep -f /opt/discord/Discord) == "" ]]; then
  discord --enable-features=WaylandWindowDecorations --ozone-platform-hint=auto 
fi
