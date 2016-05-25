#!/bin/bash
# Script to run multiple l2gen sequentially
# Javier A. Concha
# 2016-01-13

echo "Type the range that you want to run (4 digits), followed by [ENTER]:"

read range

if [ ${range:2:2} -ne "00" ]
then
	sed -n "${range:0:2}","${range:2:2}"p file_list.txt > file_list"$range".txt
else
	sed -n "${range:0:2}","${range:0:2}"p file_list.txt > file_list"$range".txt
fi

for FILE in `cat file_list"$range".txt`
do 	
	mkdir -p $FILE
	mv "$FILE".tar.gz "$FILE"/
	cd "$FILE"/
	gzip -d ./"$FILE".tar.gz
	tar -xvf ./"$FILE".tar
	cd ..
	echo running l2gen on $FILE 	
	l2gen ifile=./"$FILE"/"$FILE"_MTL.txt ofile1=./"$FILE"/"$FILE"_L2n1.nc aer_opt=-1 ctl_pt_incr=1 maskglint=1 l2prod="default,ag_412_mlrc"
	let i++
	echo $i
done
echo l2gen run in multiple files finished...
