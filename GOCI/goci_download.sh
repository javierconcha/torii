#!/bin/bash
# Script to download GOCI images sequentially
# by Javier A. Concha
# Created 2016-02-24
# Modified 2016-06-21

rm file_list.txt

for FILE in `cat scene_dates.txt`
do 	
	grep "$FILE" goci_l1b.txt > list_temp.txt
	grep "$FILE" goci_l1b.txt >> file_list.txt

	prefix=http://oceandata.sci.gsfc.nasa.gov/cgi/gethiddenfile/
	for line in `cat list_temp.txt`
	do
		wget --content-disposition  "$prefix$line"
	done
	mkdir -p $FILE/
        mv *"$FILE"*.gz  $FILE/
	gunzip -vf $FILE/*$FILE*.gz
	let i++
        echo $i
done

rm list_temp.txt
