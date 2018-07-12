#!/bin/bash

n=$1
sum=1

function factorial()
{
	local local_n=$1
	local local_n_sub_1=$(($local_n-1))

	if [ $local_n_sub_1 -lt 1 ];then
		sum=1
	else
		factorial $local_n_sub_1
		sum=`expr $local_n \* $sum`
	fi
}

if [ $# -eq 0  ];then
	echo 'usage:1.factorial.sh [n]'
	echo "calculate a number's factorial"

elif [ $# -eq 1 ];then
	factorial $n
	echo $sum

else
	echo 'Input Error!'

fi
