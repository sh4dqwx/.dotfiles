#!/bin/bash

SCRIPTS_PATH=~/.config/hypr/scripts/open_project
PROJECTS_PATH=~/Projects
LOGS_PATH=~/.config/hypr/logs

cd $SCRIPTS_PATH

if [[ -f $LOGS_PATH/open_project.log ]]; then
  rm $LOGS_PATH/open_project.log
fi
touch $LOGS_PATH/open_project.log
echo "start" >> $LOGS_PATH/open_project.log

# Show menu
selected_project=$(ls -1 $PROJECTS_PATH | wofi --show dmenu)
if [[ -z $selected_project ]]; then
  return
fi

# Close all windows
window_pids=$(hyprctl clients | awk '/^\tpid/ { print $2 }')
for window_pid in $window_pids; do
  hyprctl dispatch closewindow pid:$window_pid
done
echo "windows closed" >> $LOGS_PATH/open_project.log

# Open nvim for this project
if [[ ! -e "${selected_project}_tmux.sh" ]]; then
cat << EOF > "${selected_project}_tmux.sh"
#!/bin/bash
tmux kill-server
tmux new-session -d -s $selected_project
tmux split-window -h
tmux resize-pane -R 50
tmux send-keys -t 0 "cd $PROJECTS_PATH/$selected_project" C-m
tmux send-keys -t 1 "cd $PROJECTS_PATH/$selected_project" C-m
tmux send-keys -t 0 "nvim ." C-m
tmux select-pane -t 0
tmux attach-session -t $selected_project
EOF
echo "project_tmux created" >> $LOGS_PATH/open_project.log
chmod +x "${selected_project}_tmux.sh"
echo "project_tmux changed security" >> $LOGS_PATH/open_project.log
fi
hyprctl dispatch exec "[workspace 1 silent] kitty --hold sh -c $SCRIPTS_PATH/${selected_project}_tmux.sh"
echo "project_tmux used by hyprctl" >> $LOGS_PATH/open_project.log

# Open lazygit for this project
if [[ ! -e "${selected_project}_lazygit.sh" ]]; then
cat << EOF > "${selected_project}_lazygit.sh"
#!/bin/bash
cd $PROJECTS_PATH/$selected_project
lazygit
EOF
echo "project_lazygit created" >> $LOGS_PATH/open_project.log
chmod +x "${selected_project}_lazygit.sh"
echo "project_lazygit changed security" >> $LOGS_PATH/open_project.log
fi
hyprctl dispatch exec "[workspace 2 silent] kitty --hold sh -c $SCRIPTS_PATH/${selected_project}_lazygit.sh"
echo "project_lazygit used by hyprctl" >> $LOGS_PATH/open_project.log
