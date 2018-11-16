#!/bin/bash

for DATE in `cat scene_dates.txt`
do
	find ./Images/ -name "*$DATE*" -exec cp '{}' $DATE \;
done
