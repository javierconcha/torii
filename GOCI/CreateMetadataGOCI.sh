#!/bin/bash

for FILE in `cat file_list.txt`
do
	echo Creating Metadata file for $FILE
		
	h5dump -g "/HDFEOS/POINTS/Scene Header" $FILE > "$FILE"_MTL.txt
	h5dump -g "/HDFEOS/POINTS/File Descripter Metadata" $FILE >> "$FILE"_MTL.txt

	let i++
	echo $i

done


