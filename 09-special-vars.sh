#!/bin/bash 

echo $@
echo $#
echo $0
echo "Hello World"
echo $?
echo $$
sleep 50 &
echo $!
echo $0 | cut -d "." -f1
echo "$*"
echo "$LINENO"