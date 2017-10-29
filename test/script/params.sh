#!/bin/bash
echo "
shell 传递的参数实例！
参数1：$0
参数2：$1
参数3：$2
参数4：$3
参数5：$4"
echo "参数依次为：$*， 共：$#个"
echo "PID: $$"
echo "\$@:$@"
echo '$*:'$*
echo "参数个数:$#个"
echo "程序执行状态：$?"
echo "上一个进程ID：$!"
echo "---\$*演示---循环打印---"
count_a=1
for i in "$*";do
    echo "第${count_a}个参数：$i"
    echo $((count_a++)) >> /dev/null
done
count_b=1
echo "---\$@演示---循环打印"
for i in "$@";do
    echo "第${count_b}个参数：$i"
    echo $((count_b++)) >> /dev/null
done


