#!/bin/bash

ls -1 -d 201* > folder_list.txt
i=1

for LINE in `cat folder_list.txt`
do 
	echo $LINE
	cd $LINE
	count=$(find . -name "*solz"|wc -l)
	let i=$i+$count
	cd ..
	echo $i	
done
