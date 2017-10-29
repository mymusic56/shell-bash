#!/bin/bash
#read from keybord
read -p "enter a:" a
read -p "enter b:" b
#a=$1
#b=$2
echo "a-b=$(($a-$b))"
echo "a*b=$(($a*$b))"
echo "a**b=$(($a**$b))"
echo "a/b=$(($a/$b))"
echo "a%b=$(($a%$b))"


a=1
b=2
echo $( expr $a + $b )
echo `expr $a + $b`

c[1]=2k
c[1]+=2k
d[1]=3
d[1]+=3
echo "数组c1：${c[1]}, ${d[1]}";
