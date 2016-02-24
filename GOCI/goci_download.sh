#!/bin/bash
# Script to download GOCI images sequentially
# by Javier A. Concha
# 2016-02-24

for FILE in `cat scene_list.txt`
do 
	wget http://oceandata.sci.gsfc.nasa.gov/cgi/gethiddenfile/"$FILE"
        mv $FILE  ${FILE:0:25}
	let i++
        echo $i
done

