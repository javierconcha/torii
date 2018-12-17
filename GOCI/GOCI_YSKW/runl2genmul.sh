#!/bin/bash
# Script to run multiple l2gen sequentially
# Javier A. Concha
# Created 2016-06-21 (Finally Spring!)


#read range

sed -n lim1,lim2p file_list.txt > file_listlim1lim2.txt

# coordinates for South Korea Peninsula
SWlon=123.5
SWlat=33
NElon=126
NElat=37

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

        l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,poc,chlor_a,ag_412_mlrc,a_nnn_giop,bbp_nnn_giop,rhos_vvv,senz,solz,slot"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" gain=[0.9903,0.9750,0.9529,0.9145,0.9195,0.9101,0.9492,1.0000]

	let i++
	echo $i
done
echo l2gen run in multiple finished...

tmux kill-window

# MODISA  
# [0.9903,0.9750,0.9529,0.9145,0.9195,0.9101,0.9492,1.0000]

#               l2gen ifile="$FILE" ofile1="$FILE"_L2n2.nc aer_opt=-2 ctl_pt_incr=1 maskglint=1 l2prod="default,poc,chlor_a,ag_412_mlrc,rhos_vvv,senz,solz"  sline="$sline" eline="$eline" spixl="$spixl" epixl="$epixl" gain=[0.9903,0.9750,0.9529,0.9145,0.9195,0.9101,0.9492,1.0000]

#               echo The return values is $?

#               val_extract ifile="$FILE"_L2n2.nc ofile="$FILE"_L2n2_val.o ignore_flags="LAND HIGLINT HILT  STRAYLIGHT CLDICE ATMFAIL LOWLW FILTER NAVFAIL NAVWARN"

#      rm "$FILE"*.nc
#      mkdir -p ../AERONET_GOCI_R2018_MA_CV1p5/$DATE
#      mv ./"$FILE"_* ../AERONET_GOCI_R2018_MA_CV1p5/$DATE
