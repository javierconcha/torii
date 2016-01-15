#!/bin/bash
# Script to run multiple l2gen sequentially
# Javier A. Concha
# 2016-01-13

find ./ -name "*he5" -exec mv -v '{}' '{}'.gz \;
find ./ -name "*he5.gz" -exec gunzip -v '{}' \;

ls -1 *he5 > file_list.txt

for FILE in `cat file_list.txt`
do 	
	echo running l2gen on $FILE 	
	l2gen ifile=./"$FILE" ofile=./"$FILE"_L2.nc aer_opt=-1

	let i++
	echo $i
done
echo l2gen run in multiple files finished...
