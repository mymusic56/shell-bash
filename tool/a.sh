#!/usr/bin/expect
set timeout 100
set pwd "123456"
spawn ssh root@120.77.204.27
expect "password"
send "$pwd\n"
interact
