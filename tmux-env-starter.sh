#!/usr/bin/env bash

#HOME='/home/delubu'

tmux new-session -s 'DEV' -n 'Ref' -c "$HOME/notes" -d
sleep 0.4
tmux send-keys -t 'Ref' 'git st' Enter
tmux split-window -h -c "$HOME/.config/nvim" # No idea how this knows which window to split.
sleep 0.4
tmux send-keys 'tree' Enter
tmux new-window -n 'OldSpice Notes' -c "$HOME/client/Kablamo/OldSpice/"
## if sending this via cmd above, window will close after exit
sleep 0.4
tmux send-keys -t 'OldSpice Notes' 'vim notes.txt' Enter

# Open some windows for the code
tmux new-window -n 'all code' -c "$HOME/client/Kablamo/OldSpice/code"
sleep 0.4
tmux send-keys -t 'all code' 'ls' Enter

# Set focus on Notes window
tmux select-window -t 'DEV':'OldSpice Notes'
tmux attach-session -t 'DEV' -d
