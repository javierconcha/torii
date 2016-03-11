#!/bin/bash
# Script to download GOCI images sequentially
# by Javier A. Concha
# 2016-02-24

for FILE in `cat scene_list.txt`
do 
	wget --content-disposition  http://oceandata.sci.gsfc.nasa.gov/cgi/gethiddenfile/"$FILE".gz
        mv $FILE.gz  ${FILE:0:25}/$FILE.gz
	gunzip ${FILE:0:25}/$FILE.gz
	let i++
        echo $i
done

