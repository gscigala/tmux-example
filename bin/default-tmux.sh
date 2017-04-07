#!/bin/bash

SESSION="Default"

function has-session {
    tmux has-session -t $SESSION 2>/dev/null
}

if has-session ; then
    echo "Session already exists"
else
    # Setup session
    tmux new-session -d -s $SESSION

    # Setup window 1
    tmux select-window -t $SESSION:1
    tmux rename-window 'Home'
    tmux split-window -v
    tmux split-window -h
    tmux select-pane -t 0
    tmux send-keys "htop" C-m
    tmux select-pane -t 1
    tmux send-keys "cd" C-m C-l
    tmux select-pane -t 2
    tmux send-keys "cd /tmp" C-m C-l

    # Setup window 2
    tmux new-window -t $SESSION:2 -n 'Git'
    tmux select-pane -t 0
    tmux send-keys "cd ~/Git" C-m C-l

    # Setup window 3
    tmux new-window -t $SESSION:3 -n 'Desktop'
    tmux select-pane -t 0
    tmux send-keys "cd ~/Bureau" C-m C-l

    # Set default window
    tmux select-window -t $SESSION:1

    # Attach to session
    tmux attach-session -d -t $SESSION
fi

