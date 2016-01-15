#!/bin/bash
# Script to run multiple l2gen sequentially
# Javier A. Concha
# 2016-01-13

for FILE in `cat file_list1018.txt`
do 	
	echo running l2gen on $FILE 	
	l2gen ifile=./"$FILE"/"$FILE"_MTL.txt ofile1=./"$FILE"/"$FILE"_L2.nc aer_opt=-1

	let i++
	echo $i
done
echo l2gen run in multiple files finished...
