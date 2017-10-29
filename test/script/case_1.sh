#!/bin/bash
read -p "please input a number": op
case $op in
	1) echo "you selection is copy"
	;;
	2) echo "delete" ;;
	3) echo "backpu" ;;
	4) echo "quit" ;;
	*) echo "invalid selection"
esac
		
