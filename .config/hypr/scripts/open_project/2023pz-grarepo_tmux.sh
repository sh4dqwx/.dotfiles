#!/bin/bash
tmux kill-server
tmux new-session -d -s 2023pz-grarepo
tmux split-window -h
tmux split-window -v
tmux resize-pane -R 50
tmux send-keys -t 0 "cd /home/bartek/Projects/2023pz-grarepo" C-m
tmux send-keys -t 1 "cd /home/bartek/Projects/2023pz-grarepo/mobile" C-m
tmux send-keys -t 2 "cd /home/bartek/Projects/2023pz-grarepo/backend" C-m
tmux send-keys -t 0 "nvim ." C-m
tmux select-pane -t 0
tmux attach-session -t 2023pz-grarepo
