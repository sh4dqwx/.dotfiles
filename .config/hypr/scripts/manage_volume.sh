#!/bin/bash

inc_volume() {
  if [[ $(pamixer --get-mute) == "true" ]]; then
    return
  fi
  pamixer -i 5
}

dec_volume() {
  if [[ $(pamixer --get-mute) == "true" ]]; then
    return
  fi
  pamixer -d 5
}

toggle_mute_volume() {
  pamixer -t
}

if [[ "$1" == "--inc" ]]; then
  inc_volume
elif [[ "$1" == "--dec" ]]; then
  dec_volume
elif [[ "$1" == "--toggle-mute" ]]; then
  toggle_mute_volume
fi
