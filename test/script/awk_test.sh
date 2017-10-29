#!/bin/bash
#separator useage 
echo '111,222,333'|awk -F ',' '{print $1}'
echo '111,222,333'|awk 'BEGIN{FS=","}{print $1 $2 $3}'
echo '111,222,333'|awk 'BEGIN{FS=","}{print NF=$NF}'
echo '111,222,333'|awk 'BEGIN{FS=","}{print "NF-1="$(NF-1)}'
echo '111,222,333'|awk 'BEGIN{FS=","}{print "NF-2="$(NF-2)}'
echo '111,222,333'|awk 'BEGIN{FS=","}{print "NF-3="$(NF-3)}'
#print ip address
# net addr:172.18.220.95  Bcast:172.18.223.255  Mask:255.255.240.0
echo -e "\033[33m print ip:\033[0m"
ifconfig eth0|grep Bcast|awk -F "[ :]+" '{print "\t"$4}'
#print /etc/passwd where uid >= 500
echo -e "\033[32m print uid >= 500 as follow:\033[0m"
awk -F: '$3>=500{print "\t"$1":"$3":"$NF}' /etc/passwd
awk -F: 'BEGIN{print "\n\t""name""\t""uid""\t""bash"}$3>=500{print "\t"$1"\t"$3"\t"$NF}' /etc/passwd

#print /etc/passwd general user where uid >10
echo -e "\033[31m print general user where uid >= 10\033[0m "
awk -F: 'BEGIN{print "\t""name""\t""uid""\t""bash"}$3>=10 && $NF="/bin/bash"{print "\t"$1"\t"$3"\t"$NF}' /etc/passwd
# check the memory usage percentage
echo -e "\033[31m check the memory usage percentage\033[0m"
mem_total=$(free -m |grep Mem | awk -F "[ ]+" '{print $2}')
mem_used=$(free -m |grep Mem | awk -F "[ ]+" '{print $3}')
mem_free=$(free -m |grep Mem | awk -F "[ ]+" '{print $4}')
echo  -e "\t `expr $mem_used \* 100 / $mem_total` %"


#invoke shell 
echo -e "\033[34m \033[0m"
echo -e "\033[34m invoke shell test failed!!!!!!!!!!!!!!\033[0m"
#awk -f /test/script/echo_with_color.sh


