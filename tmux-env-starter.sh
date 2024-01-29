#!/usr/bin/env bash

#HOME='/home/delubu'

tmux new-session -s 'DEV' -n 'Ref' -c "$HOME/notes" -d
tmux send-keys -t 'Ref' 'git st' Enter
tmux split-window -h -c "$HOME/.config/nvim" # No idea how this knows which window to split.
tmux send-keys 'tree' Enter
tmux new-window -n 'OldSpice Notes' -c "$HOME/client/Kablamo/OldSpice/"
## if sending this via cmd above, window will close after exit
tmux send-keys -t 'OldSpice Notes' 'vim notes.txt' Enter

# Open some windows for the code
tmux new-window -n 'osfin' -c "$HOME/client/Kablamo/OldSpice/code/osfin"
tmux send-keys -t 'osfin' 'ls' Enter

# Open some windows for the code
tmux new-window -n 'osfin-security' -c "$HOME/client/Kablamo/OldSpice/osfin-security"
tmux send-keys -t 'osfin-security' 'ls' Enter

# Open some windows for the code
tmux new-window -n 'osfin-customer' -c "$HOME/client/Kablamo/OldSpice/osfin-customer"
tmux send-keys -t 'osfin-customer' 'ls' Enter

# Set focus on Notes window
tmux select-window -t 'DEV':'OldSpice Notes'
tmux attach-session -t 'DEV' -d
