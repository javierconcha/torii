#!/bin/bash
# Script to download GOCI images sequentially
# by Javier A. Concha
# 2016-02-24

for FILE in `cat scene_list.txt`
do 	
	grep "${FILE:0:25}" goci_l1.txt > list_temp.txt
	prefix=http://oceandata.sci.gsfc.nasa.gov/cgi/gethiddenfile/
	for line in `cat list_temp.txt`
	do
		wget --content-disposition  "$prefix$line"
	done
	mkdir -p ${FILE:0:25}/
        mv "${FILE:0:25}"*.gz  ${FILE:0:25}/
	gunzip ${FILE:0:25}/${FILE:0:25}*.gz
	let i++
        echo $i
done

rm list_temp.txt
