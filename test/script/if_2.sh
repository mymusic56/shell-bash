#!/bin/bash
read -p "please input the file you want to check:" file_name
if [[ -e $file_name && -r $file_name && -w $file_name ]];then
	echo "Hello world, $USER" >> $file_name
	echo "success"
else
	echo "$file_name is not a file"
fi
read -p "请输入要添加的文件名称：" file_name
if [[ -e $file_name && -r $file_name && -w $file_name ]];then
	echo "Hello world,awk" >> $file_name
	echo success
else
	echo "$file_name not is a file"
fi
