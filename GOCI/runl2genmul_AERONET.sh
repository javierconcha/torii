#!/bin/bash
# Script to run multiple l2gen sequentially
# for an specific ROI based on the lat lon of the in situ point
# Javier A. Concha
# 2016-06-06

sed -n lim1,lim2p idlatlonUNIQ.txt > idlatlon_listlim1lim2.txt

IFS=$'\n'       # make newlines the only separator
for LINE in `cat idlatlon_listlim1lim2.txt`
do 	
	DATE=`echo $LINE | awk -F ' ' '{print $1}'`
	LAT=`echo $LINE | awk -F ' ' '{print $2}'`
	LON=`echo $LINE | awk -F ' ' '{print $3}'`


	i=0
	echo $DATE $LAT $LON

	cd $DATE

	find . -name "*.he5">file_list_temp.txt

	for FILE in `cat file_list_temp.txt`
	do
		let i++
		if [ $i -eq 1 ]; then
			lonlat2pixline -x 1 -y 1 "$FILE" "$LON" "$LAT" > "$FILE"_lonlat2pixline.o
			eval "$(grep "sline" "$FILE"_lonlat2pixline.o)"
			eval "$(grep "eline" "$FILE"_lonlat2pixline.o)"
			eval "$(grep "spixl" "$FILE"_lonlat2pixline.o)"
			eval "$(grep "epixl" "$FILE"_lonlat2pixline.o)"
		fi
		echo $sline $eline $spixl $epixl

		echo running l2gen on $FILE 	
	
		l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,ag_412_mlrc,rhos_vvv,senz,solz"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl"

		#l2gen ifile=./"$FILE"/"$FILE"_MTL.txt ofile1=./"$FILE"/"$FILE"_L2n2SWIR5x5.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,ag_412_mlrc,rhos_vvv" aer_wave_long=2201 aer_wave_short=1609 filter_file=/home/jconchas/ocssw/run/data/oli/msl12_filterUSER.dat filter_opt=1 sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl"

		echo The return values is $?

		val_extract ifile="$FILE"_L2n2.nc ofile="$FILE"_L2n2_val.o	
		
		echo $i
	done
	cd ..
done

rm idlatlon_listlim1lim2.txt
rm runl2genmul_templim1lim2.sh

echo l2gen run in multiple files finished...

#tmux kill-window
