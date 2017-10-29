#!/bin/bash
awk 'BEGIN{printf "%-5s %-10s %-3s \n","num","name","salary"}{printf "%-5s %-10s %-3s \n",$1,$2,$3}' /test/script/user_info.txt

