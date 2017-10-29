#!/bin/bash
echo "MySQL start Install"
mysqlpackage='mysql-5.6.32.tar.gz'
cmakepackage='cmake-3.7.2.tar.gz'
mysqldirname='mysql-5.6.32'
cmakedirname='cmake-3.7.2'
mysqlDir='/usr/local/mysql'
mysqlSock='/usr/local/mysql/data/mysql.sock'
mysqlDataDir='/usr/local/mysql/data'
ddir=`pwd`
#check user
#id -u|awk '{if($1 > 0 ){print "please use root privileges."}}'
if [ `id -u` -gt 0 ];then
	echo -n "root privileges is needed."
fi
#wether mysql is intalled


#check the directory is exits or not
if [ -e $mysqlDir ];then
	echo -n "MySQL has been installe in $mysqlDir"
	exit
fi

#check file exist or not
if [ ! -e "$ddir/$mysqlpackage" ];then
	echo -n "can't find $ddir/$mysqlpackage"
fi
if [ ! -e "$ddir/$cmakepackage" ];then
	echo -n "can't find $ddir/$cmakepackage"
fi
tar -zxvf $mysqlpackage -C /usr/local/src/
tar -zxvf $cmakepackage -C /usr/local/src/
cd /usr/local/src/$cmakedirname

cmakeinstall(){
	./bootstrap
	if [ $? -eq 0 ];then
		gmake && gmake install
	else
		echo -n "cmake ./bootstrap executed failed."
	exit
fi
}
mysqlinstall(){
	cmake -DCMAKE_INSTALL_PREFIX=$mysqlDir -DMYSQL_UNIX_ADDR=$mysqlSock -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EXTRA_CHARSETS=utf8,gbk -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PERFSCHEMA_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_ARCHIVE_STORAGE_ENGINE=1 -DWITH_READLINE=1 -DMYSQL_DATADIR=$mysqlDataDir -DMYSQL_TCP_PORT=3306

	if [ $? -eq 0 ]; then
		echo -n "compile ok"
		make && make install
	else
		echo -n "compile failed"
	fi
	if [ $? -eq 0 ];then
		echo -n "Install Finished"
	else
		echo -n "Install failed"
		exit
	fi
}

init_mysql_config(){
	#add mysql user and group
	groupadd mysql
	useradd -s /sbin/nologin -M -g mysql mysql
	cd $mysqlDir
	
	#modified directory privileges
	chown -R mysql .
	chgrp -R mysql .
	
	#init database
	if [ -e /etc/my.cnf ];then
		rm -rf /etc/my.cnf
	fi
	scripts/mysql_install_db --user=mysql
	if [ $? -eq 0 ];then
		echo -e -n "\033[32m mysql database init finished. \033[0m"
	else
		echo -e -n "\033[31m mysql database init failed. \033[0m"
	fi
	
	#modified directory privileges
	chown -R root .
	chown -R mysql ./data

	#edit mysql config file
	if [ -e /etc/my.cnf ];then
		mv /etc/my.cnf /etc/my.cnf.`date "+%Y%m%d"`
	fi
	cat >  "/etc/my.cnf" <<zhang
	[client]
	socket=/tmp/mysql.sock
	[mysqld]
	basedir=/usr/local/mysql
	datadir=/usr/local/mysql/data
	port=3306

	pid-file=/usr/local/mysql/data/mysql.pid
	socket=/tmp/mysql.sock
	character-set-server=utf8
	#log-bin=/usr/local/mysql/data/mysql-log-bin
	sql-mode=NO_ENGINE_SUBSTITUTION,STRICT_TRANS_TABLES
zhang
	if [ -e "$mysqlDir/my.cnf" ];then
		mv "$mysqlDir/my.cnf" "$mysqlDir/my.cnf.back"
	fi
	
	#modify root password
	support-files/mysql.server start
	bin/mysqladmin -u root password "123456"

	echo -n "set auto statup when machine running."
	#define startup when machine running with level 2345
	cp -Rp support-files/mysql.server /etc/init.d/mysqld
	chkconfig --add mysqld
	#check startup is set right or not ????????????????????????????????
	#chkconfig --list|grep mysqld|awk 
	
	#add environment, use symbolic link, it maste be absolute path.
	ln -s "$mysqlDir/bin/*"  /usr/local/bin
	echo -e -n "\033[32m mysql database init finished. \033[0m"
}

cmakeinstall

if [ $? -eq 0 ]; then
	cd ../$mysqldirname/
	mysqlinstall
	if [ $? -eq 0 ];then
		init_mysql_config
	fi
else
	echo "cmake check failed!"
fi
exit
