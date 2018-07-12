#!/bin/bash

function printt
{
	count=1
	cat fileFor4.txt | while read line
	do
		#printf '%d %s\n' 1 "abc"
		printf "\t%d\t %-50s\n" $count "$line"
		count=$(($count+1))	
	done
}

if [ $# -eq 0 ];then
	echo "The largest files/directories in $4 are:"
	find -type f -o -type d -print0 | xargs -0 du -h | sort -rh | head -n 5 >fileFor4.txt
	printt

elif [[ $# -eq 4 && $1 == "-n" && $3 == "-d" ]];then
	echo "The largest files/directories in $4 are:"
	find $4 -type f -o -type d -print0 | xargs -0 du -h | sort -rh | head -n $2 >fileFor4.txt
	printt
 
else
	echo "usage: 4.file_size.sh [-n N][-d DTR]"
	echo "Show top N largest files/directories"

fi 
