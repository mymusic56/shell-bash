#!/bin/bash
ping -c 2 $1 > /dev/null
if [ $? -eq 0 ];then
	echo "Host $1 is up"
else
	echo "Host $1 is down"
fi
