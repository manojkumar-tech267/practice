#!/bin/bash 

id=$(id -u)

if [ $id -eq 0 ]
then 
  echo "You are running with root access!!!"
else 
  echo "You are not a root user please run with root access"
  exit 1 
fi

VALIDATE()
{
  if [ $1 -eq 0 ]
  then 
    echo "$2 is successfully installed"
  else 
    echo "$2 is failed"
    exit 1
  fi
}


dnf list installed nginx 

if [ $? -ne 0 ]
then
  echo "Nginx is not installed we are installing!!!"
  dnf install nginx -y 
  VALIDATE $? "Nginx"
else 
  echo "Nginx is already there we are skipping!!!"
fi