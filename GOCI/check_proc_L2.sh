#!/bin/bash

ls -1 -d 201* > folder_list.txt
i=1

for LINE in `cat folder_list.txt`
do 
	echo $i	
	echo $LINE
	cd $LINE
	find . -name "*solz"|wc -l
	let i++
	cd ..
done
