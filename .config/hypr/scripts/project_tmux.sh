#!/bin/bash
SESSION_ID=$(uuidgen)
tmux new-session -d -s $SESSION_ID
tmux split-window -h
tmux resize-pane -R 50
tmux split-window -v
tmux send-keys -t 0 "cd /home/bartek/Projects/2023pz-grarepo" C-m
tmux send-keys -t 1 "cd /home/bartek/Projects/2023pz-grarepo/backend" C-m
tmux send-keys -t 2 "cd /home/bartek/Projects/2023pz-grarepo/mobile" C-m
tmux send-keys -t 0 "nvim ." C-m
tmux select-pane -t 0
tmux attach-session -t $SESSION_ID
