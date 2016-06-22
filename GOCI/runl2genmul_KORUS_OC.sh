#!/bin/bash
# Script to run multiple l2gen sequentially
# Javier A. Concha
# 2016-01-13

echo "Type the r that you want to run (4 digits), followed by [ENTER]:"

read range

sed -n "${range:0:2}","${range:2:2}"p file_list.txt > file_list"$range".txt

for FILE in `cat file_list"$range".txt`
do 	
	echo running l2gen on $FILE 	
	l2gen ifile=./"$FILE"  ofile1=./"$FILE"_L2n1.nc aer_opt=-1 l2prod="default,ag_412_mlrc"

	let i++
	echo $i
done
echo l2gen run in multiple files finished...
