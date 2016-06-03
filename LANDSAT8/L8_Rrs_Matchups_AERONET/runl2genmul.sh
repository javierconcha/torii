#!/bin/bash
# Script to run multiple l2gen sequentially
# Javier A. Concha
# 2016-01-13

echo "Type the range that you want to run (4 digits), followed by [ENTER]:"

read range

if [ ${range:3:3} -ne "000" ]
then
	sed -n "${range:0:3}","${range:3:3}"p file_list.txt > file_list"$range".txt
else
	sed -n "${range:0:3}","${range:0:3}"p file_list.txt > file_list"$range".txt
fi

for FILE in `cat file_list"$range".txt`
do 	
	echo running l2gen on $FILE 	
	l2gen ifile=./"$FILE"/"$FILE"_MTL.txt ofile1=./"$FILE"/"$FILE"_L2n1SWIR5x5.nc aer_opt=-1 ctl_pt_incr=1 maskglint=1 l2prod="default,ag_412_mlrc,rhos_vvv" aer_wave_long=2201 aer_wave_short=1609 filter_file=/home/jconchas/ocssw/run/data/oli/msl12_filterUSER.dat filter_opt=1

	let i++
	echo $i
done
echo l2gen run in multiple files finished...
