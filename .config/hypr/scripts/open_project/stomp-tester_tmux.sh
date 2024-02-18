#!/bin/bash
tmux kill-server
tmux new-session -d -s stomp-tester
tmux split-window -h
tmux resize-pane -R 50
tmux send-keys -t 0 "cd /home/bartek/Projects/stomp-tester" C-m
tmux send-keys -t 1 "cd /home/bartek/Projects/stomp-tester" C-m
tmux send-keys -t 0 "nvim ." C-m
tmux select-pane -t 0
tmux attach-session -t stomp-tester
