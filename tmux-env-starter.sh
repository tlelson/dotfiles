#!/usr/bin/env bash

#HOME='/home/delubu'

tmux new-session -s 'DEV' -n 'Ref' -c "$HOME/notes" -d
tmux send-keys -t 'Ref' 'git st' Enter
tmux split-window -h -c "$HOME/.aws"  # No idea how this knows which window to split.
tmux send-keys 'tree' Enter
tmux new-window -n 'OldSpice Notes' -c "$HOME/client/Kablamo/OldSpice/"
## if sending this via cmd above, window will close after exit
tmux send-keys -t 'OldSpice Notes' 'vim notes.txt' Enter
# Open some windows for the code
tmux new-window -n 'OldSpice Code' -c "$HOME/client/Kablamo/OldSpice/code"
tmux send-keys -t 'OldSpice Code' 'ls' Enter

tmux new-window -n 'BoatShed' -c "$HOME/client/Boatshed" #'vim'

tmux select-window -t 'DEV':'OldSpice Notes'
tmux attach-session -t 'DEV' -d
