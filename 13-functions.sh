#!/bin/bash 

userid=$(id -u)

if [ $userid -ne 0 ]
then 
    echo "You are not a root user please run with root user access"
    exit 1 
else 
    echo "You are a root user"
fi 

VALIDATE()
{
    if [ $1 -eq 0 ]
    then 
        echo "$2 is successfully installed"
    else 
        echo "$2 is failed!!!"
        exit 1
    fi
}

dnf list installed mysql 
if [ $? -ne 0 ]
then 
    dnf install mysql -y 
    VALIDATE $? "Mysql"
else 
    echo "MySql is already there we are skipping"
fi 

dnf list installed nginx
if [ $? -ne 0 ]
then 
    dnf install nginx -y 
    VALIDATE $? "Nginx"
else 
    echo "Nginx is already there we are skipping!!!"
fi 

dnf list installed python
if [ $? -ne 0 ]
then 
    dnf install python -y 
    VALIDATE $? "Python"
else 
    echo "Python is already there we are skippping"
fi