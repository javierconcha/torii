#!/bin/bash
# Script to download GOCI images sequentially
# by Javier A. Concha
# Created 2016-02-24
# Modified 2018-01-02

filename=$1

echo "Type the range1 that you want to run, followed by [ENTER]:"

read range1

echo "Type the range2 that you want to run, followed by [ENTER]:"

read range2

sed -n "$range1","$range2"p $filename > "$filename"_"$range1"_"$range2".txt


for FILE in `cat "$filename"_"$range1"_"$range2".txt`
do 	
	prefix=http://oceandata.sci.gsfc.nasa.gov/cgi/gethiddenfile/
	wget --content-disposition  "$prefix$FILE"
	bn=$(basename $FILE _valregion.tar)
	mkdir -p $bn/
   mv $FILE  $bn/
	cd $bn/
	tar -xf $FILE
	rm $FILE
	cd ..
	let i++
   echo $i
done

