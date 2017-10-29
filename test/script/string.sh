#!/bin/bash
string="abcde"
echo ""$string" length is ${#string}"
echo "${string} length is ${#string}"
#bcd
echo ${string:1:3}
#find the place char 'a' in string 'abcd'
echo `expr index "$string" a`
#define an array, separate by space 
array_name=("$string" 1 2 3 4 5 'eee')
#print the array
echo $array_name
echo ${array_name[@]}
#print the first element of the array
array_name0=${array_name[0]}
echo "the first element of the array is ${array_name0}"
#???? does not auto linefeed
$(echo $(cat /etc/passwd) >> /test/script/passwd_sh_to.txt)


