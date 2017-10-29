#!/bin/bash
fname="invalid-ip-`date '+%Y-%m-%d'`.txt"
filepath=/root/blacklist/$fname
touch $filepath
#echo "seperate------------------------" >> $filepath
cat /var/log/secure|awk '/Invalid user/{print $NF}'|sort|uniq -c|awk '{print $2"="$1;}' >> $filepath
define=5

for i in `cat $filepath`
do
	IP=`echo $i|awk -F= '{print $1}'`
	NUM=`echo $i|awk -F= '{print $2}'`
	if [ $NUM -gt $define ];then
		grep $IP /etc/hosts.deny > /dev/null #查看当前IP是否已经在黑名单中
                if [ $? -gt 0 ];then 		#上一次的命令执行结果为假， 即没黑名单中
                        echo "sshd:$IP" >> /etc/hosts.deny
                fi
	
	fi
done		
