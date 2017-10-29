#!/bin/bash
service $1 status &> /dev/null
if [ $? -eq 0 ];then
	echo "service $1 is running"
else
	
	echo "service $1 is stopped"
fi
