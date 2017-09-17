#!/bin/bash

# This script is called from the j command on the local box.
# Its first parameter is a deployment name.  It opens a new session
# and renames the session to the deployment name for easy identification when returning after
# an unintentional disconection.

if [ $# -ne 0 ]; then
    sess=$1-$RANDOM
    tmux new-session -s $sess -d
    tmux send -t $sess 'j '$1 ENTER
    tmux attach -t $sess
else
    printf "The passed cmd: $1 \n"
    printf "ERROR: A single deployment must be passed as the first arg ...\n\n"
fi
