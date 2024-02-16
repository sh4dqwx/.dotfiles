#!/bin/bash

SCRIPTS_PATH=~/.config/hypr/scripts
PROJECTS_PATH=~/Projects

cd $SCRIPTS_PATH

if [[ -f "open_project.log" ]]; then
  rm open_project.log
fi
touch open_project.log
echo "start" >> open_project.log

# Close all windows
window_pids=$(hyprctl clients | awk '/^\tpid/ { print $2 }')
for window_pid in $window_pids; do
  hyprctl dispatch closewindow pid:$window_pid
done
echo "windows closed" >> open_project.log

# Open nvim for this project
cat << EOF > project_tmux.sh
#!/bin/bash
SESSION_ID=\$(uuidgen)
tmux new-session -d -s \$SESSION_ID
tmux split-window -h
tmux resize-pane -R 50
tmux split-window -v
tmux send-keys -t 0 "cd $PROJECTS_PATH/2023pz-grarepo" C-m
tmux send-keys -t 1 "cd $PROJECTS_PATH/2023pz-grarepo/backend" C-m
tmux send-keys -t 2 "cd $PROJECTS_PATH/2023pz-grarepo/mobile" C-m
tmux send-keys -t 0 "nvim ." C-m
tmux select-pane -t 0
tmux attach-session -t \$SESSION_ID
EOF
echo "project_tmux created" >> open_project.log
chmod +x project_tmux.sh
echo "project_tmux changed security" >> open_project.log
hyprctl dispatch exec "[workspace 1 silent] kitty --hold sh -c $SCRIPTS_PATH/project_tmux.sh"
echo "project_tmux used by hyprctl" >> open_project.log

# Open lazygit for this project
cat << EOF > project_lazygit.sh
#!/bin/bash
cd $PROJECTS_PATH/2023pz-grarepo
lazygit
EOF
echo "project_lazygit created" >> open_project.log
chmod +x project_lazygit.sh
echo "project_lazygit changed security" >> open_project.log
hyprctl dispatch exec "[workspace 2 silent] kitty --hold sh -c $SCRIPTS_PATH/project_lazygit.sh"
echo "project_lazygit used by hyprctl" >> open_project.log
