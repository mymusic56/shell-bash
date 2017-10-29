#!/bin/bash
echo $USER;
if [ $USER == 'zsj' ];then
	cd /test
	rm -rf a.txt
	exit 11
else
	echo "you not root"
	exit -1
fi
