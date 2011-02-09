#!/bin/bash
# Sorts Foscam 8189W IP camera snapshots into directories 
# by date and time (hour), e.g. 02-08-2011/03, 02-07-2011/17
# Expected filename format is CAMERAMAC(mymac)_num_timestamp_autoinc-num.jpg
# Author:  Nick Davis

for f in $* 
do
	if [ -f $f ];
	then	
		# split filename and capture timestamp
		date=`echo "$f" | awk 'BEGIN {FS="_"}{print $3}'`
		# split each field into time periods (year, month, etc.)
		y=${date:0:4}
		m=${date:4:2}
		d=${date:6:2}
		h=${date:8:2}
		min=${date:10:2}
		datedir=$m-$d-$y
		# create date dir and hour dir if they don't exist, 
		# move file to datedir/hourdir 
		if [ ! -d $datedir ];
		then
			mkdir $datedir
		else
			hourdir="$datedir/$h"
			if [ ! -d $hourdir ];
			then
				mkdir $hourdir
			else
				echo "Moving $f to $hourdir"
				mv $f $hourdir	
			fi
			
		fi 
	fi
done
