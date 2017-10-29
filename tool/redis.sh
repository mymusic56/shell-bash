#!/bin/bash
#
#author Engine
#date 2016/10/23
#redis daemon start/stop script.
#

#默认端口, 优化： 将端口号作为参数传入
port=6379
basedir="/usr/local/redis-3.2.0"
bin="$basedir/bin"
config="$basedir/redis.conf"
pidfile="$bin/redis.pid"
#启动、停止、重启操作日志
startlog="$bin/bin/start.log"
#0:没有运行
testrunning(){
	if [ -e $pidfile ];then
        	isrunning=1
		#return 1
	else
        	isrunning=0
	fi
}
#echo $isrunning
#exit
retval=0
prog="redis-server"
desc="Redis Server"
ok="SUCCESS"
f="FAILED"
start(){
	testrunning
	if [ $isrunning -eq 1 ];then
		echo "$desc already running......"
		exit 1
	fi
	echo "Start $desc:"
	$bin/$prog $config
	return $?
}
stop(){
	testrunning
	if [ $isrunning -eq 0 ];then
		echo "NO Redis is running"
		exit 0;
	fi
	echo "Stop $desc: "
	#这里怎么停止呢？直接获取进程ID， 杀死进程？
	#默认端口
	$bin/redis-cli -p $port shutdown > msg
	if [ $? -eq 0 ];then
		return 0
	else
		#显示失败信息
		echo $msg
		netstat -tlunp|grep redis > redisinfo
		pid=0
		if [ -n $redisinfo ];then
			 pid=$redisinfo|awk -F "[ ]+" '{print $7}'|awk -F '/' '{print $1}'
		fi
		[ $pid -gt 0 ] && kill -9 $pid
		return $?
	fi
}
restart(){
	echo "Start restart $desc "
	stop
        if [ $? -eq 0 ]; then
		echo "Stop $ok"
        	start
		if [ $? -eq 0 ];then
			echo "Start $ok"
			return 0
		fi	
        fi
	return 1
}

case "$1" in
	start)
		start
		[ $? -eq 0 ] && echo "start $ok"
		[ $? -eq 1 ] && echo "start $f"
		exit $?
	;;
	stop)
		stop
		[ $? -eq 0 ] && echo "stop $ok"
		[ $? -eq 1 ] && echo "stop $f"
		exit $?
	;;
	status)
		testrunning
		[ $isrunning -eq 0 ] && echo "$desc is Not Running."
		[ $isrunning -eq 1 ] && echo "$desc is Running."
		exit $?
	;;
	restart)
		restart
		[ $? -eq 0 ] && echo "restart $ok"
		[ $? -eq 1 ] && echo "restart $f"
		exit $?
	;;
	*)
		echo "Usage: $0 {start|stop|restart|status}"	
		exit 1
	;;
esac
exit
