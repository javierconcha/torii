#!/bin/bash
# var for session name (to avoid repeated occurences)
sn=0

# Start the session and window 0 in /etc
#   This will also be the default cwd for new windows created
#   via a binding unless overridden with default-path.
cd /etc
tmux new-session -s "$sn" -n etc -d

# Create a bunch of windows in /var/log
cd ~/data2/GOCI/
for i in {1..2}; do
	tmux new-window -t "$sn:$i" -n "var$i"
	tmux send-keys -t "$sn:$i" C-z './temp_echo.sh' Enter
done

# Set the default cwd for new windows (optional, otherwise defaults to session cwd)
#tmux set-option default-path /

# Select window #1 and attach to the session
tmux select-window -t "$sn:0"
tmux -2 attach-session -t "$sn"
