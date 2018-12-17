#!/bin/bash
# Script to run multiple l2gen sequentially
# for an specific ROI based on the lat lon of the in situ point
# Javier A. Concha
# 2016-06-06

clear

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
			lonlat2pixline -x 2 -y 2 "$FILE" "$LON" "$LAT" > "$FILE"_lonlat2pixline.o
			eval "$(grep "sline" "$FILE"_lonlat2pixline.o)"
			eval "$(grep "eline" "$FILE"_lonlat2pixline.o)"
			eval "$(grep "spixl" "$FILE"_lonlat2pixline.o)"
			eval "$(grep "epixl" "$FILE"_lonlat2pixline.o)"
		fi
		echo $sline $eline $spixl $epixl

		echo running l2gen on $FILE 	

# MODISA  
# [0.9903,0.9750,0.9529,0.9145,0.9195,0.9101,0.9492,1.0000]

#		l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,poc,chlor_a,ag_412_mlrc,rhos_vvv,senz,solz"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" gain=[0.9903,0.9750,0.9529,0.9145,0.9195,0.9101,0.9492,1.0000]

#		echo The return values is $?

#		val_extract ifile="$FILE"_L2n2.nc ofile="$FILE"_L2n2_val.o ignore_flags="LAND HIGLINT HILT  STRAYLIGHT CLDICE ATMFAIL LOWLW FILTER NAVFAIL NAVWARN"

#      rm "$FILE"*.nc
#      mkdir -p ../AERONET_GOCI_R2018_MA_CV1p5/$DATE
#      mv ./"$FILE"_* ../AERONET_GOCI_R2018_MA_CV1p5/$DATE

# SeaWiFS
# [0.9879,0.9711,0.9418,0.9067,0.9162,0.9061,0.9492,1.0000]

#		l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,poc,chlor_a,ag_412_mlrc,rhos_vvv,senz,solz"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" gain=[0.9879,0.9711,0.9418,0.9067,0.9162,0.9061,0.9492,1.0000]

#		echo The return values is $?

#		val_extract ifile="$FILE"_L2n2.nc ofile="$FILE"_L2n2_val.o ignore_flags="LAND HIGLINT HILT  STRAYLIGHT CLDICE ATMFAIL LOWLW FILTER NAVFAIL NAVWARN"

#      rm "$FILE"*.nc
#      mkdir -p ../AERONET_GOCI_R2018_SW_CV1p5/$DATE
#      mv ./"$FILE"_* ../AERONET_GOCI_R2018_SW_CV1p5/$DATE

# Wang
# [0.9862,0.9753,0.9473,0.9149,0.9245,0.9223,0.9430,1.0000] NIR-model-derived, Wang et al. (2012)
# [0.9857,0.9749,0.9484,0.9179,0.9299,0.9283,0.9502,1.0000]
 
		l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,poc,chlor_a,ag_412_mlrc,rhos_vvv,senz,solz"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" gain=[0.9857,0.9749,0.9484,0.9179,0.9299,0.9283,0.9502,1.0000]

		echo The return values is $?

		val_extract ifile="$FILE"_L2n2.nc ofile="$FILE"_L2n2_val.o ignore_flags="LAND HIGLINT HILT  STRAYLIGHT CLDICE ATMFAIL LOWLW FILTER NAVFAIL NAVWARN"

      rm "$FILE"*.nc
      mkdir -p ../AERONET_GOCI_R2018_Wang/$DATE
      mv ./"$FILE"_* ../AERONET_GOCI_R2018_Wang/$DATE

# NRL
# [0.9726,0.9520,0.9258,0.8974,0.9007,0.8719,0.9430,1.0000]

#		l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,poc,chlor_a,ag_412_mlrc,rhos_vvv,senz,solz"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" gain=[0.9726,0.9520,0.9258,0.8974,0.9007,0.8719,0.9430,1.0000]

#		echo The return values is $?

#		val_extract ifile="$FILE"_L2n2.nc ofile="$FILE"_L2n2_val.o ignore_flags="LAND HIGLINT HILT  STRAYLIGHT CLDICE ATMFAIL LOWLW FILTER NAVFAIL NAVWARN"

#      rm "$FILE"*.nc
#      mkdir -p ../AERONET_GOCI_R2018_NRL/$DATE
#      mv ./"$FILE"_* ../AERONET_GOCI_R2018_NRL/$DATE

# Ahn
# [1.0105,0.9891,0.9611,0.9186,0.9567,0.9659,0.9613,1.0000]

#		l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,poc,chlor_a,ag_412_mlrc,rhos_vvv,senz,solz"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" gain=[1.0105,0.9891,0.9611,0.9186,0.9567,0.9659,0.9613,1.0000]

#		echo The return values is $?

#		val_extract ifile="$FILE"_L2n2.nc ofile="$FILE"_L2n2_val.o ignore_flags="LAND HIGLINT HILT  STRAYLIGHT CLDICE ATMFAIL LOWLW FILTER NAVFAIL NAVWARN"

#      rm "$FILE"*.nc
#      mkdir -p ../AERONET_GOCI_R2018_Ahn/$DATE
#      mv ./"$FILE"_* ../AERONET_GOCI_R2018_Ahn/$DATE

# Uncalibrated
# [1.0000,1.0000,1.0000,1.0000,1.0000,1.0000,1.0000,1.0000]

#		l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,poc,chlor_a,ag_412_mlrc,rhos_vvv,senz,solz"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" gain=[1.0000,1.0000,1.0000,1.0000,1.0000,1.0000,1.0000,1.0000]
#
#		echo The return values is $?
#
#		val_extract ifile="$FILE"_L2n2.nc ofile="$FILE"_L2n2_val.o ignore_flags="LAND HIGLINT HILT  STRAYLIGHT CLDICE ATMFAIL LOWLW FILTER NAVFAIL NAVWARN"
#		
#      rm "$FILE"*.nc
#      mkdir -p ../AERONET_GOCI_R2018_Uncalibr/$DATE
#      mv ./"$FILE"_* ../AERONET_GOCI_R2018_Uncalibr/$DATE

		echo $i
	done
	cd ..
done

rm idlatlon_listlim1lim2.txt
rm runl2genmul_templim1lim2.sh

echo l2gen run in multiple files finished...

exit
#tmux kill-window
