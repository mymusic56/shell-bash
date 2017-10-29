#!/bin/bash
ERR_1=10 #not a file
SUCCESS=0
test_file="/test/script333"
if [ -f $test_file ];then
	echo "/test/script/path.sh is a file"
#	exit $SUCCESS
else
	if [ -d $test_file  ];then
		echo "$test_file is a directory"
	else
		echo "$test_file is a directory AND not a file"
		echo "echck the file or directory is exist or not!"
	fi
#	exit $ERR_1
fi
if [ $USER == 'root' ];then
	echo "now user is root"
	exit 0
else 
	echo "now user is $USER"

	exit $ERR_1
fi

