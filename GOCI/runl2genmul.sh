#!/bin/bash
# Script to run multiple l2gen sequentially
# Javier A. Concha
# 2016-01-13

echo "Type the range that you want to run (4 digits), followed by [ENTER]:"

read range

for FILE in `cat file_list.txt`
do 	
	echo running l2gen on $FILE 	
	l2gen ifile=./"$FILE"  ofile1=./"$FILE"_L2.nc l2prod="default,ag_412_mlrc"

	let i++
	echo $i
done
echo l2gen run in multiple files finished...
