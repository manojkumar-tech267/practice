#!/bin/bash 

read Number1
read Number2

if [ $Number1 -lt $Number2 ]
then 
    echo "$Number1 is less than $Number2"
elif [ $Number1 -gt $Number2 ]
then 
    echo "$Number1 is greater than $Number2"
else 
    echo "$Number1 is equal to $Number2"
fi