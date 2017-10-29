#/bin/bash

configfile="check_config.txt";

linenum=1
cat $configfile | while read i
do
	server_name=`echo $i | awk -F";" '{print $1}'`
        noticeMobile=`echo $i | awk -F";" '{print $2}'`
        noticeEmail=`echo $i | awk -F";" '{print $3}'`
        noticeTimes=`echo $i | awk -F";" '{print $4}'`
        lastNoticeTimes=`echo $i | awk -F";" '{print $5}'`
	#过滤掉含有grep的行
	find_result=`ps aux|grep $server_name|grep -v grep`

	if [ $? -ne 0 ] ;then
		echo "${server_name} 服务已停止"
		noticeTimes=$(($noticeTimes+1))
		newline="$server_name;$noticeMobile;$noticeEmail;$noticeTimes;$lastNoticeTimes"
		#echo $newline
		sed -i "${linenum}c ${newline}" $configfile
                #保存检查次数， 或者超过重检次数，发送消息给管理员
	else 
		echo "${server_name} 服务正常"
		#echo $find_result
		if [ $noticeTimes != '0' ];then
			noticeTimes=0
			newline="$server_name;$noticeMobile;$noticeEmail;$noticeTimes;$lastNoticeTimes"
			echo $newline	
			sed -i "${linenum}c ${newline}" $configfile
		fi
	fi	
	linenum=$(($linenum + 1))
done
