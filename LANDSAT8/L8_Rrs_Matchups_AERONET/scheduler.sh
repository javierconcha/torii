#!/bin/bash
# Script to schedule multiple jubs using different tmux windows within a tmux session
# Created by Javier Concha, 2016-06-24

# number of jobs per window
n_jobs=50

# tmux configuration
# var for session name (to avoid repeated occurences)
sn=0

tmux new-session -s "$sn" -n main -d

# Create a bunch of windows in /var/log
cd ~/data2/LANDSAT8/L8_Rrs_Matchups_AERONET/

line_no=$(wc -l < idlatlon_list.txt)
max=$((line_no/n_jobs+1))

for (( i = 1; i <= $max; i++ )) 
do
	echo $i
	LIM1=$(((i-1)*n_jobs+1))
	LIM2=$((i*n_jobs))
	cat runl2genmul_crop.sh | sed 's"lim1"'$LIM1'"g' | sed 's"lim2"'$LIM2'"g' > runl2genmul_temp$LIM1$LIM2.sh
	
	chmod 755 ./runl2genmul_temp$LIM1$LIM2.sh
	
	tmux new-window -t "$sn:$i" -n "var$i"
	tmux send-keys -t "$sn:$i" C-z './runl2genmul_temp'$LIM1''$LIM2'.sh' Enter
done

# Set the default cwd for new windows (optional, otherwise defaults to session cwd)
#tmux set-option default-path /

# Select window #1 and attach to the session
tmux select-window -t "$sn:0"
tmux -2 attach-session -t "$sn"

