#!/bin/bash
# Script to run multiple l2gen sequentially
# Javier A. Concha
# Created 2016-06-21 (Finally Spring!)

#echo "Type the r that you want to run (4 digits), followed by [ENTER]:"

#read range

sed -n lim1,lim2p file_list.txt > file_listlim1lim2.txt

# coordinates for South Korea Peninsula
SWlon=122
SWlat=32
NElon=132
NElat=41

#for FILE in `cat file_list"$range".txt`
for FILE in `cat file_listlim1lim2.txt`
do
	echo running l2gen on $FILE 	
	
	lonlat2pixline ./"$FILE" "$SWlon" "$SWlat" "$NElon" "$NElat" > ./"$FILE"_lonlat2pixline.o
        eval "$(grep "sline" ./"$FILE"_lonlat2pixline.o)"
        eval "$(grep "eline" ./"$FILE"_lonlat2pixline.o)"
        eval "$(grep "spixl" ./"$FILE"_lonlat2pixline.o)"
        eval "$(grep "epixl" ./"$FILE"_lonlat2pixline.o)"
        #rm ./"$FILE"_lonlat2pixline.o
	
	echo $sline $eline $spixl $epixl

	l2gen ifile=./"$FILE"  ofile1=./"$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1  l2prod="default,ag_412_mlrc,rhos_vvv" sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" 

	let i++
	echo $i
done
echo l2gen run in multiple finished...
