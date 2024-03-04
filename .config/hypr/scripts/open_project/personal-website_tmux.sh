#!/bin/bash
tmux kill-server
tmux new-session -d -s personal-website
tmux split-window -h
tmux resize-pane -R 50
tmux send-keys -t 0 "cd /home/bartek/Projects/personal-website" C-m
tmux send-keys -t 1 "cd /home/bartek/Projects/personal-website" C-m
tmux send-keys -t 0 "nvim ." C-m
tmux select-pane -t 0
tmux attach-session -t personal-website
